import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import '../../domain/printer/bambu_report.dart';
import '../../domain/printer/printer_adapter.dart';
import '../../domain/printer/printer_status.dart';
import 'mqtt_transport.dart';

class BambuLanConfig {
  const BambuLanConfig({
    required this.host,
    required this.serial,
    required this.accessCode,
    this.pinnedCertSha256,
  });

  /// Printer IP on the local network (an IP literal, not a host name).
  final String host;
  final String serial;

  /// 8-character LAN access code shown on the printer screen.
  final String accessCode;

  /// SHA-256 of the printer certificate seen on the first successful
  /// connection (trust on first use). Null on the first connection.
  final String? pinnedCertSha256;

  @override
  String toString() => 'BambuLanConfig($host, $serial, accessCode: ***)';
}

/// Bambu Lab printers in LAN mode: MQTT over TLS on port 8883, user `bblp`,
/// password = access code. Read-only: this app never sends print commands;
/// the only message published is `pushall` (ask for a full report).
class BambuLanAdapter implements PrinterAdapter {
  BambuLanAdapter(
    this.config, {
    MqttTransport? transport,
    this.onRawMessage,
    this.firstReportTimeout = const Duration(seconds: 10),
  }) : _transport = transport ?? MqttClientTransport();

  static const port = 8883;
  static const username = 'bblp';

  final BambuLanConfig config;
  final MqttTransport _transport;

  /// Receives raw report JSON for the debug screen. Never sees the code.
  final void Function(String raw)? onRawMessage;
  final Duration firstReportTimeout;

  final _status = StreamController<PrinterStatus>.broadcast();
  final _connection = StreamController<PrinterConnection>.broadcast();
  Map<String, Object?> _merged = const {};
  PrinterStatus _last = PrinterStatus.unknown;
  StreamSubscription<MqttMessageData>? _msgSub;
  StreamSubscription<void>? _dropSub;
  Timer? _noReportTimer;
  bool _gotReport = false;
  String? _observedCertSha256;
  bool _certMismatch = false;

  PrinterStatus get lastStatus => _last;
  Map<String, Object?> get mergedReport => _merged;

  /// Fingerprint seen during the last connection, to be pinned by the caller.
  String? get observedCertSha256 => _observedCertSha256;

  @override
  Stream<PrinterStatus> get statusStream => _status.stream;

  @override
  Stream<PrinterConnection> get connectionStream => _connection.stream;

  @override
  bool get supportsFileFetch => false;

  @override
  Future<Uint8List?> fetchJobFile(String fileName) async => null;

  /// Accepts the self-signed certificate only for this connection (whose
  /// host is the configured IP literal), and only if it matches the pinned
  /// fingerprint once one is known.
  bool _acceptCertificate(X509Certificate cert) {
    final fp = sha256.convert(cert.der).toString();
    _observedCertSha256 = fp;
    final pinned = config.pinnedCertSha256;
    if (pinned != null && pinned != fp) {
      _certMismatch = true;
      return false;
    }
    return true;
  }

  @override
  Future<void> connect() async {
    if (InternetAddress.tryParse(config.host.trim()) == null ||
        normalizeSerial(config.serial).isEmpty ||
        config.accessCode.trim().isEmpty) {
      throw const PrinterAdapterException(PrinterConnectionError.invalidConfig);
    }
    _connection.add(const PrinterConnecting());
    try {
      await _transport.connect(
        host: config.host.trim(),
        port: port,
        username: username,
        password: config.accessCode.trim(),
        clientId: 'printcost-${Random().nextInt(1 << 31).toRadixString(36)}',
        onBadCertificate: _acceptCertificate,
      );
    } on TransportException catch (e) {
      final error = switch (e.failure) {
        TransportFailure.unreachable => PrinterConnectionError.unreachable,
        TransportFailure.rejected => PrinterConnectionError.rejected,
        TransportFailure.tls =>
          _certMismatch
              ? PrinterConnectionError.certificateChanged
              : PrinterConnectionError.unknown,
        TransportFailure.other => PrinterConnectionError.unknown,
      };
      _connection.add(PrinterConnectionFailed(error, e.detail));
      throw PrinterAdapterException(error, e.detail);
    }

    _msgSub = _transport.messages.listen(_onMessage);
    _dropSub = _transport.disconnected.listen((_) {
      _connection.add(
        const PrinterConnectionFailed(
          PrinterConnectionError.unreachable,
          'lost',
        ),
      );
    });
    _transport.subscribe(reportTopic(config.serial));
    _transport.publish(requestTopic(config.serial), jsonEncode(pushAllRequest));
    _connection.add(const PrinterConnected());
    _noReportTimer = Timer(firstReportTimeout, () {
      if (!_gotReport) {
        _connection.add(
          const PrinterConnectionFailed(PrinterConnectionError.noReports),
        );
      }
    });
  }

  void _onMessage(MqttMessageData m) {
    if (m.topic != reportTopic(config.serial)) return;
    final raw = decodePayload(m.payload);
    onRawMessage?.call(raw);
    final Object? json;
    try {
      json = jsonDecode(raw);
    } on FormatException {
      return;
    }
    if (json is! Map<String, Object?>) return;
    _merged = mergeReport(_merged, json);
    if (!_gotReport && json.containsKey(BambuFields.print)) {
      _gotReport = true;
      _noReportTimer?.cancel();
    }
    final next = statusFromReport(_merged);
    _last = next;
    _status.add(next);
  }

  /// Connects and waits for the first status, for the setup wizard.
  Future<PrinterStatus> testConnection({Duration? timeout}) async {
    final first = statusStream.first;
    try {
      await connect();
    } on Object {
      // The stream closes on disconnect; don't leak its "no element" error.
      first.ignore();
      rethrow;
    }
    try {
      return await first.timeout(timeout ?? firstReportTimeout);
    } on TimeoutException {
      throw const PrinterAdapterException(PrinterConnectionError.noReports);
    }
  }

  @override
  Future<void> disconnect() async {
    _noReportTimer?.cancel();
    await _msgSub?.cancel();
    await _dropSub?.cancel();
    await _transport.disconnect();
    _connection.add(const PrinterDisconnected());
    await _status.close();
    await _connection.close();
  }
}

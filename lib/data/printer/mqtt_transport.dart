import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum TransportFailure { unreachable, rejected, tls, other }

class TransportException implements Exception {
  const TransportException(this.failure, [this.detail]);
  final TransportFailure failure;
  final String? detail;

  @override
  String toString() => 'TransportException(${failure.name}, $detail)';
}

typedef MqttMessageData = ({String topic, Uint8List payload});

/// Thin seam over the MQTT library so the adapter logic can be unit tested.
abstract interface class MqttTransport {
  Future<void> connect({
    required String host,
    required int port,
    required String username,
    required String password,
    required String clientId,
    required bool Function(X509Certificate cert) onBadCertificate,
  });

  void subscribe(String topic);
  void publish(String topic, String payload);
  Stream<MqttMessageData> get messages;

  /// Emits when the connection drops after being established.
  Stream<void> get disconnected;
  Future<void> disconnect();
}

/// MQTT over TLS with `mqtt_client`.
class MqttClientTransport implements MqttTransport {
  MqttServerClient? _client;
  final _messages = StreamController<MqttMessageData>.broadcast();
  final _disconnected = StreamController<void>.broadcast();
  StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>? _sub;
  bool _closing = false;

  @override
  Stream<MqttMessageData> get messages => _messages.stream;

  @override
  Stream<void> get disconnected => _disconnected.stream;

  @override
  Future<void> connect({
    required String host,
    required int port,
    required String username,
    required String password,
    required String clientId,
    required bool Function(X509Certificate cert) onBadCertificate,
  }) async {
    final client = MqttServerClient.withPort(host, clientId, port)
      ..secure = true
      // Self-signed printer certificate: an empty context trusts no public
      // roots, so the only accepted certificate is decided by
      // [onBadCertificate].
      ..securityContext = SecurityContext()
      ..onBadCertificate = onBadCertificate
      ..keepAlivePeriod = 30
      ..connectTimeoutPeriod = 8000
      ..setProtocolV311()
      // Library logging would print the CONNECT packet (with the password).
      ..logging(on: false);
    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .authenticateAs(username, password)
        .startClean();
    client.onDisconnected = () {
      if (!_closing) _disconnected.add(null);
    };
    _client = client;

    MqttClientConnectionStatus? status;
    try {
      status = await client.connect();
    } on SocketException catch (e) {
      throw TransportException(
        TransportFailure.unreachable,
        e.osError?.message,
      );
    } on HandshakeException catch (e) {
      throw TransportException(TransportFailure.tls, e.message);
    } on TlsException catch (e) {
      throw TransportException(TransportFailure.tls, e.message);
    } on NoConnectionException catch (e) {
      final code = client.connectionStatus?.returnCode;
      if (code == MqttConnectReturnCode.badUsernameOrPassword ||
          code == MqttConnectReturnCode.notAuthorized) {
        throw TransportException(TransportFailure.rejected, code?.name);
      }
      throw TransportException(TransportFailure.unreachable, e.toString());
    } on Exception catch (e) {
      throw TransportException(TransportFailure.other, e.toString());
    }
    if (status?.state != MqttConnectionState.connected) {
      final code = status?.returnCode;
      client.disconnect();
      throw TransportException(
        code == MqttConnectReturnCode.badUsernameOrPassword ||
                code == MqttConnectReturnCode.notAuthorized
            ? TransportFailure.rejected
            : TransportFailure.other,
        code?.name,
      );
    }
    _sub = client.updates?.listen((batch) {
      for (final m in batch) {
        final msg = m.payload;
        if (msg is MqttPublishMessage) {
          _messages.add((
            topic: m.topic,
            payload: Uint8List.fromList(msg.payload.message),
          ));
        }
      }
    });
  }

  @override
  void subscribe(String topic) => _client?.subscribe(topic, MqttQos.atMostOnce);

  @override
  void publish(String topic, String payload) {
    final builder = MqttClientPayloadBuilder()..addUTF8String(payload);
    _client?.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  @override
  Future<void> disconnect() async {
    _closing = true;
    await _sub?.cancel();
    _client?.disconnect();
    _client = null;
    await _messages.close();
    await _disconnected.close();
  }
}

String decodePayload(Uint8List payload) =>
    utf8.decode(payload, allowMalformed: true);

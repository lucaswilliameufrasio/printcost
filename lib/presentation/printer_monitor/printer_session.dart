import 'dart:async';
import 'dart:developer' as developer;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/printer/bambu_lan_adapter.dart';
import '../../data/printer/printer_connection_repository.dart';
import '../../data/printer/secret_store.dart';
import '../../domain/printer/bambu_report.dart';
import '../../domain/printer/printer_adapter.dart';
import '../../domain/printer/printer_status.dart';
import '../../l10n/generated/app_localizations.dart';
import '../providers.dart';
import 'print_notifier.dart';

final secretStoreProvider = Provider<SecretStore>((ref) => SecureSecretStore());

final printerConnectionRepositoryProvider =
    Provider<PrinterConnectionRepository>(
      (ref) => PrinterConnectionRepository(
        ref.watch(databaseProvider),
        ref.watch(secretStoreProvider),
      ),
    );

final printerConnectionsProvider = StreamProvider(
  (ref) => ref.watch(printerConnectionRepositoryProvider).watchAll(),
);

final printNotifierProvider = Provider<PrintNotifier>(
  (ref) => LocalPrintNotifier(channelName: _l10n(ref).pmNotifyChannel),
);

/// Creates the adapter for a connection; overridden in tests.
typedef AdapterFactory = BambuLanAdapter Function(
  BambuLanConfig config,
  void Function(String raw) onRaw,
);

final adapterFactoryProvider = Provider<AdapterFactory>(
  (ref) =>
      (config, onRaw) => BambuLanAdapter(config, onRawMessage: onRaw),
);

AppLocalizations _l10n(Ref ref) {
  final code =
      ref.read(settingsProvider).value?.localeCode ??
      PlatformDispatcher.instance.locale.languageCode;
  return lookupAppLocalizations(Locale(code == 'en' ? 'en' : 'pt'));
}

class PrinterSessionState {
  const PrinterSessionState({
    this.connection = const PrinterDisconnected(),
    this.status = PrinterStatus.unknown,
    this.rawLog = const [],
    this.merged = const {},
    this.lastEstimatedTotalSeconds,
    this.lastFinished,
  });

  final PrinterConnection connection;
  final PrinterStatus status;

  /// Most recent raw messages, newest first (debug screen).
  final List<String> rawLog;
  final Map<String, Object?> merged;

  /// Latest total-duration estimate seen while printing.
  final int? lastEstimatedTotalSeconds;

  /// Snapshot of the job when it reached "finished" (for registering it).
  final PrinterStatus? lastFinished;

  PrinterSessionState copyWith({
    PrinterConnection? connection,
    PrinterStatus? status,
    List<String>? rawLog,
    Map<String, Object?>? merged,
    int? lastEstimatedTotalSeconds,
    PrinterStatus? lastFinished,
  }) => PrinterSessionState(
    connection: connection ?? this.connection,
    status: status ?? this.status,
    rawLog: rawLog ?? this.rawLog,
    merged: merged ?? this.merged,
    lastEstimatedTotalSeconds:
        lastEstimatedTotalSeconds ?? this.lastEstimatedTotalSeconds,
    lastFinished: lastFinished ?? this.lastFinished,
  );
}

const _maxRawLog = 30;
const _retryDelay = Duration(seconds: 15);

/// One live connection per configured printer, kept alive while the module
/// is enabled so finish/fail notifications work while browsing the app.
class PrinterSession extends Notifier<PrinterSessionState> {
  PrinterSession(this.connectionId);
  final int connectionId;

  BambuLanAdapter? _adapter;
  final _subs = <StreamSubscription<Object?>>[];
  Timer? _retry;
  bool _disposed = false;

  @override
  PrinterSessionState build() {
    final enabled = ref.watch(
      settingsProvider.select((s) => s.value?.printerModuleEnabled ?? false),
    );
    _disposed = false;
    ref.onDispose(() {
      _disposed = true;
      unawaited(_teardown());
    });
    if (enabled) Future.microtask(connect);
    return const PrinterSessionState();
  }

  Future<void> _teardown() async {
    _retry?.cancel();
    for (final s in _subs) {
      await s.cancel();
    }
    _subs.clear();
    final a = _adapter;
    _adapter = null;
    await a?.disconnect();
  }

  Future<void> connect() async {
    await _teardown();
    if (_disposed) return;
    final repo = ref.read(printerConnectionRepositoryProvider);
    final row = await repo.get(connectionId);
    final code = await repo.accessCode(connectionId);
    if (_disposed || row == null) return;
    if (code == null) {
      state = state.copyWith(
        connection: const PrinterConnectionFailed(
          PrinterConnectionError.invalidConfig,
        ),
      );
      return;
    }
    final adapter = ref.read(adapterFactoryProvider)(
      BambuLanConfig(
        host: row.host,
        serial: row.serial,
        accessCode: code,
        pinnedCertSha256: await repo.certPin(connectionId),
      ),
      _onRaw,
    );
    _adapter = adapter;
    _subs
      ..add(adapter.statusStream.listen(_onStatus))
      ..add(adapter.connectionStream.listen(_onConnection));
    try {
      await adapter.connect();
      final fp = adapter.observedCertSha256;
      if (fp != null && await repo.certPin(connectionId) == null) {
        await repo.pinCertificate(connectionId, fp);
      }
    } on PrinterAdapterException {
      // Reported through connectionStream.
    }
  }

  void _onRaw(String raw) {
    if (kDebugMode) developer.log(raw, name: 'printcost.printer.raw');
    if (_disposed) return;
    final log = [raw, ...state.rawLog];
    state = state.copyWith(
      rawLog: log.length > _maxRawLog ? log.sublist(0, _maxRawLog) : log,
    );
  }

  void _onConnection(PrinterConnection c) {
    if (_disposed) return;
    state = state.copyWith(connection: c);
    if (c is PrinterConnectionFailed &&
        c.error == PrinterConnectionError.unreachable) {
      _retry?.cancel();
      _retry = Timer(_retryDelay, () => unawaited(connect()));
    }
  }

  void _onStatus(PrinterStatus next) {
    if (_disposed) return;
    final previous = state.status;
    state = state.copyWith(
      status: next,
      merged: _adapter?.mergedReport,
      lastEstimatedTotalSeconds: next.state == PrintState.printing
          ? next.estimatedTotalSeconds
          : null,
      lastFinished: next.state == PrintState.finished ? next : null,
    );
    if (shouldNotify(previous.state, next.state)) {
      final l = _l10n(ref);
      unawaited(
        ref
            .read(printNotifierProvider)
            .show(
              id: connectionId,
              title: next.state == PrintState.finished
                  ? l.pmNotifyFinished
                  : l.pmNotifyFailed,
              body: next.taskName ?? next.fileName ?? '',
            ),
      );
    }
  }
}

final printerSessionProvider =
    NotifierProvider.family<PrinterSession, PrinterSessionState, int>(
      PrinterSession.new,
    );

/// Starts sessions for all connections while the module is enabled.
final printerBackgroundWatcherProvider = Provider<void>((ref) {
  final enabled = ref.watch(
    settingsProvider.select((s) => s.value?.printerModuleEnabled ?? false),
  );
  if (!enabled) return;
  final connections = ref.watch(printerConnectionsProvider).value ?? const [];
  for (final c in connections) {
    ref.watch(printerSessionProvider(c.id));
  }
});

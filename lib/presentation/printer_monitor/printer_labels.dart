import '../../domain/printer/printer_status.dart';
import '../../l10n/generated/app_localizations.dart';

String printStateLabel(AppLocalizations l, PrintState s) => switch (s) {
  PrintState.idle => l.pmState_idle,
  PrintState.preparing => l.pmState_preparing,
  PrintState.printing => l.pmState_printing,
  PrintState.paused => l.pmState_paused,
  PrintState.finished => l.pmState_finished,
  PrintState.failed => l.pmState_failed,
  PrintState.unknown => l.pmState_unknown,
};

String connectionErrorMessage(
  AppLocalizations l,
  PrinterConnectionError e, {
  required String host,
  String? detail,
}) => switch (e) {
  PrinterConnectionError.unreachable => l.errUnreachable(host),
  PrinterConnectionError.rejected => l.errRejected,
  PrinterConnectionError.noReports => l.errNoReports,
  PrinterConnectionError.certificateChanged => l.errCertChanged,
  PrinterConnectionError.invalidConfig => l.errInvalidConfig,
  PrinterConnectionError.unknown => l.errUnknownPrinter(detail ?? ''),
};

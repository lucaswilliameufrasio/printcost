/// Simple, brand-neutral print state shown to the user.
enum PrintState { idle, preparing, printing, paused, finished, failed, unknown }

class PrinterStatus {
  const PrinterStatus({
    required this.state,
    this.progressPercent,
    this.remainingMinutes,
    this.fileName,
    this.taskName,
    this.errorCode,
  });

  static const unknown = PrinterStatus(state: PrintState.unknown);

  final PrintState state;
  final int? progressPercent;
  final int? remainingMinutes;

  /// File on the printer (e.g. `/data/Metadata/plate_1.gcode` or `x.gcode.3mf`).
  final String? fileName;

  /// Job name shown on the printer (usually the project/plate name).
  final String? taskName;
  final int? errorCode;

  bool get isActive =>
      state == PrintState.printing ||
      state == PrintState.paused ||
      state == PrintState.preparing;

  /// Total job duration estimated from the printer's own progress and
  /// remaining time. Null when it cannot be estimated.
  int? get estimatedTotalSeconds {
    final p = progressPercent;
    final r = remainingMinutes;
    if (p == null || r == null || p <= 0 || p >= 100) return null;
    return (r * 60 * 100) ~/ (100 - p);
  }
}

/// Connection problems, mapped to plain-language messages in the UI.
enum PrinterConnectionError {
  /// No answer on the IP/port: wrong IP, other network, printer off, or
  /// LAN mode disabled.
  unreachable,

  /// The printer refused the access code (wrong code, code changed after
  /// toggling LAN mode, or Developer Mode off on newer firmware).
  rejected,

  /// TLS handshake failed or the printer certificate changed.
  certificateChanged,

  /// Connected, but no status arrived (often Developer Mode off).
  noReports,

  /// Invalid configuration (e.g. IP is not an IP address).
  invalidConfig,

  unknown,
}

sealed class PrinterConnection {
  const PrinterConnection();
}

final class PrinterDisconnected extends PrinterConnection {
  const PrinterDisconnected();
}

final class PrinterConnecting extends PrinterConnection {
  const PrinterConnecting();
}

final class PrinterConnected extends PrinterConnection {
  const PrinterConnected();
}

final class PrinterConnectionFailed extends PrinterConnection {
  const PrinterConnectionFailed(this.error, [this.detail]);
  final PrinterConnectionError error;

  /// Technical detail for support/debug (never contains the access code).
  final String? detail;
}

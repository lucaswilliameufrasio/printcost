import 'dart:typed_data';

import 'printer_status.dart';

/// Brand-neutral printer integration. Implementations: [BambuLanAdapter]
/// today; e.g. a Moonraker/Klipper adapter later.
abstract interface class PrinterAdapter {
  /// Connects and starts streaming status. Throws [PrinterAdapterException].
  Future<void> connect();

  /// Merged, up-to-date status. Emits on every change.
  Stream<PrinterStatus> get statusStream;

  /// Connection state changes (connected, lost, failed...).
  Stream<PrinterConnection> get connectionStream;

  Future<void> disconnect();

  /// Whether [fetchJobFile] can download the sliced file from the printer.
  bool get supportsFileFetch;

  /// Downloads the job file (e.g. `.gcode.3mf`) when supported.
  Future<Uint8List?> fetchJobFile(String fileName);
}

class PrinterAdapterException implements Exception {
  const PrinterAdapterException(this.error, [this.detail]);
  final PrinterConnectionError error;
  final String? detail;

  @override
  String toString() => 'PrinterAdapterException(${error.name}, $detail)';
}

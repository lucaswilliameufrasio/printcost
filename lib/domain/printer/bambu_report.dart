import 'printer_status.dart';

/// Bambu LAN MQTT reports arrive as partial diffs, e.g. a full
/// `{"print": {...all fields...}}` after `pushall`, then small
/// `{"print": {"mc_percent": 43, "command": "push_status"}}` updates.
/// The merged state keeps every field seen so far.
///
/// Maps are merged recursively; any other value (including lists) replaces
/// the old one. Pure function: returns a new map.
Map<String, Object?> mergeReport(
  Map<String, Object?> base,
  Map<String, Object?> diff,
) {
  final out = Map<String, Object?>.of(base);
  for (final MapEntry(:key, :value) in diff.entries) {
    final old = out[key];
    if (old is Map<String, Object?> && value is Map<String, Object?>) {
      out[key] = mergeReport(old, value);
    } else {
      out[key] = value;
    }
  }
  return out;
}

/// Field names in the `print` object of `device/{serial}/report`.
/// Confirm against the raw messages of your printer (debug screen) if a
/// firmware update renames something.
abstract final class BambuFields {
  static const print = 'print';
  static const gcodeState = 'gcode_state';
  static const percent = 'mc_percent';
  static const remainingMinutes = 'mc_remaining_time';
  static const gcodeFile = 'gcode_file';
  static const subtaskName = 'subtask_name';
  static const printError = 'print_error';
}

PrintState parseGcodeState(String? s) => switch (s?.toUpperCase()) {
  'IDLE' => PrintState.idle,
  'INIT' || 'OFFLINE' => PrintState.idle,
  'PREPARE' || 'SLICING' => PrintState.preparing,
  'RUNNING' => PrintState.printing,
  'PAUSE' => PrintState.paused,
  'FINISH' => PrintState.finished,
  'FAILED' => PrintState.failed,
  _ => PrintState.unknown,
};

int? _int(Object? v) => switch (v) {
  final int i => i,
  final double d => d.round(),
  final String s =>
    int.tryParse(s.trim()) ?? double.tryParse(s.trim())?.round(),
  _ => null,
};

String? _str(Object? v) => v is String && v.trim().isNotEmpty ? v.trim() : null;

/// Reads the simple status from a merged report.
PrinterStatus statusFromReport(Map<String, Object?> report) {
  final p = report[BambuFields.print];
  if (p is! Map<String, Object?>) return PrinterStatus.unknown;
  final percent = _int(p[BambuFields.percent]);
  final error = _int(p[BambuFields.printError]);
  return PrinterStatus(
    state: parseGcodeState(_str(p[BambuFields.gcodeState])),
    progressPercent: percent?.clamp(0, 100),
    remainingMinutes: _int(p[BambuFields.remainingMinutes]),
    fileName: _str(p[BambuFields.gcodeFile]),
    taskName: _str(p[BambuFields.subtaskName]),
    errorCode: error == 0 ? null : error,
  );
}

/// Payload that asks the printer for a full report.
const pushAllRequest = {
  'pushing': {
    'sequence_id': '0',
    'command': 'pushall',
    'version': 1,
    'push_target': 1,
  },
};

/// Serial as typed by the user -> topic form (no spaces/dashes, upper case).
String normalizeSerial(String serial) =>
    serial.replaceAll(RegExp('[^A-Za-z0-9]'), '').toUpperCase();

String reportTopic(String serial) => 'device/${normalizeSerial(serial)}/report';
String requestTopic(String serial) =>
    'device/${normalizeSerial(serial)}/request';

/// Whether the transition should notify the user.
bool shouldNotify(PrintState previous, PrintState next) =>
    previous != next &&
    (next == PrintState.finished || next == PrintState.failed) &&
    (previous == PrintState.printing ||
        previous == PrintState.paused ||
        previous == PrintState.preparing);

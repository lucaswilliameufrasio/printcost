import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/domain/printer/bambu_report.dart';
import 'package:printcost/domain/printer/printer_status.dart';

/// Shapes based on public documentation of Bambu LAN reports. Field names
/// must still be confirmed against a real printer (debug screen).
const fullReport = '''
{"print":{"command":"push_status","msg":0,"sequence_id":"20",
 "gcode_state":"RUNNING","mc_percent":12,"mc_remaining_time":95,
 "gcode_file":"/data/Metadata/plate_1.gcode","subtask_name":"Vaso bicolor",
 "print_error":0,"nozzle_temper":219.9,"bed_temper":55.0,
 "ams":{"ams":[{"id":"0","tray":[{"id":"0","tray_type":"PLA"},{"id":"1","tray_type":"PETG"}]}]},
 "lights_report":[{"node":"chamber_light","mode":"on"}]}}
''';

Map<String, Object?> json(String s) => jsonDecode(s) as Map<String, Object?>;

void main() {
  group('mergeReport', () {
    test('partial diff keeps every field seen before', () {
      var state = mergeReport(const {}, json(fullReport));
      state = mergeReport(
        state,
        json(
          '{"print":{"command":"push_status","msg":1,"mc_percent":13,"nozzle_temper":220.1}}',
        ),
      );
      final p = state['print']! as Map<String, Object?>;
      expect(p['mc_percent'], 13);
      expect(p['gcode_state'], 'RUNNING');
      expect(p['subtask_name'], 'Vaso bicolor');
      expect(p['nozzle_temper'], 220.1);
    });

    test('nested maps merge, lists are replaced', () {
      final a = json(
        '{"print":{"ams":{"ams":[1,2],"tray_now":"0"},"x":[1,2,3]}}',
      );
      final b = json('{"print":{"ams":{"tray_now":"1"},"x":[9]}}');
      final p = mergeReport(a, b)['print']! as Map<String, Object?>;
      expect(p['ams'], {
        'ams': [1, 2],
        'tray_now': '1',
      });
      expect(p['x'], [9]);
    });

    test('does not mutate inputs and accepts other top-level keys', () {
      final a = json('{"print":{"mc_percent":1}}');
      final merged = mergeReport(a, json('{"info":{"command":"get_version"}}'));
      expect(merged.keys, containsAll(['print', 'info']));
      expect((a['print']! as Map)['mc_percent'], 1);
    });
  });

  group('statusFromReport', () {
    test('running with progress, remaining time, file and task', () {
      final s = statusFromReport(json(fullReport));
      expect(s.state, PrintState.printing);
      expect(s.progressPercent, 12);
      expect(s.remainingMinutes, 95);
      expect(s.fileName, '/data/Metadata/plate_1.gcode');
      expect(s.taskName, 'Vaso bicolor');
      expect(s.errorCode, isNull);
    });

    test('all known states', () {
      PrintState st(String v) => statusFromReport({
        'print': {'gcode_state': v},
      }).state;
      expect(st('IDLE'), PrintState.idle);
      expect(st('PREPARE'), PrintState.preparing);
      expect(st('RUNNING'), PrintState.printing);
      expect(st('PAUSE'), PrintState.paused);
      expect(st('FINISH'), PrintState.finished);
      expect(st('FAILED'), PrintState.failed);
      expect(st('SOMETHING_NEW'), PrintState.unknown);
    });

    test('tolerates numbers sent as strings and missing print object', () {
      final s = statusFromReport({
        'print': {
          'mc_percent': '45',
          'mc_remaining_time': '30.0',
          'print_error': 50348044,
        },
      });
      expect(s.progressPercent, 45);
      expect(s.remainingMinutes, 30);
      expect(s.errorCode, 50348044);
      expect(statusFromReport({}).state, PrintState.unknown);
    });

    test('estimated total time from progress and remaining', () {
      // 25% done, 90 min left -> 120 min total
      const s = PrinterStatus(
        state: PrintState.printing,
        progressPercent: 25,
        remainingMinutes: 90,
      );
      expect(s.estimatedTotalSeconds, 7200);
      expect(
        const PrinterStatus(
          state: PrintState.finished,
          progressPercent: 100,
        ).estimatedTotalSeconds,
        isNull,
      );
    });
  });

  test('topics use the serial without separators', () {
    expect(reportTopic('01p00a-123 456'), 'device/01P00A123456/report');
    expect(requestTopic('01P00A123456'), 'device/01P00A123456/request');
    expect(jsonEncode(pushAllRequest), contains('"command":"pushall"'));
  });

  test('notifies only when a running print finishes or fails', () {
    expect(shouldNotify(PrintState.printing, PrintState.finished), isTrue);
    expect(shouldNotify(PrintState.paused, PrintState.failed), isTrue);
    expect(shouldNotify(PrintState.unknown, PrintState.finished), isFalse);
    expect(shouldNotify(PrintState.finished, PrintState.finished), isFalse);
    expect(shouldNotify(PrintState.printing, PrintState.paused), isFalse);
  });
}

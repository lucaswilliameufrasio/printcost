import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/printer/bambu_lan_adapter.dart';
import 'package:printcost/data/printer/mqtt_transport.dart';
import 'package:printcost/domain/printer/printer_adapter.dart';
import 'package:printcost/domain/printer/printer_status.dart';

import 'fake_transport.dart';

const config = BambuLanConfig(
  host: '192.168.0.50',
  serial: '01P00A-123456',
  accessCode: '12345678',
);

void main() {
  test(
    'connects as bblp:8883, subscribes to report and asks for pushall',
    () async {
      final t = FakeTransport();
      final a = BambuLanAdapter(config, transport: t);
      await a.connect();
      expect(t.port, 8883);
      expect(t.username, 'bblp');
      expect(t.password, '12345678');
      expect(t.subscribed, ['device/01P00A123456/report']);
      expect(t.published.single.$1, 'device/01P00A123456/request');
      expect(jsonDecode(t.published.single.$2), {
        'pushing': {
          'sequence_id': '0',
          'command': 'pushall',
          'version': 1,
          'push_target': 1,
        },
      });
      await a.disconnect();
    },
  );

  test('merges partial reports into the status stream and logs raw', () async {
    final t = FakeTransport();
    final raw = <String>[];
    final a = BambuLanAdapter(config, transport: t, onRawMessage: raw.add);
    final statuses = <PrinterStatus>[];
    final sub = a.statusStream.listen(statuses.add);
    await a.connect();
    t.emit(
      'device/01P00A123456/report',
      '{"print":{"gcode_state":"RUNNING","mc_percent":50,"mc_remaining_time":10,"subtask_name":"Vaso"}}',
    );
    t.emit('device/01P00A123456/report', '{"print":{"mc_percent":51}}');
    t.emit('device/OTHER/report', '{"print":{"mc_percent":99}}');
    t.emit('device/01P00A123456/report', 'not json');
    t.emit(
      'device/01P00A123456/report',
      '{"print":{"gcode_state":"FINISH","mc_percent":100,"mc_remaining_time":0}}',
    );
    await pumpEventQueue();

    expect(statuses.map((s) => s.progressPercent), [50, 51, 100]);
    expect(statuses[1].taskName, 'Vaso');
    expect(statuses.last.state, PrintState.finished);
    expect(raw, hasLength(4));
    expect(raw.join(), isNot(contains('12345678')));
    await sub.cancel();
    await a.disconnect();
  });

  test('access code is never in toString', () {
    expect('$config', isNot(contains('12345678')));
  });

  group('human errors', () {
    Future<PrinterConnectionError> errorFor(
      FakeTransport t, [
      BambuLanConfig c = config,
    ]) async {
      try {
        await BambuLanAdapter(c, transport: t).connect();
      } on PrinterAdapterException catch (e) {
        return e.error;
      }
      fail('expected an error');
    }

    test('unreachable / rejected / invalid ip', () async {
      expect(
        await errorFor(FakeTransport(fail: TransportFailure.unreachable)),
        PrinterConnectionError.unreachable,
      );
      expect(
        await errorFor(FakeTransport(fail: TransportFailure.rejected)),
        PrinterConnectionError.rejected,
      );
      expect(
        await errorFor(
          FakeTransport(),
          const BambuLanConfig(
            host: 'printer.local',
            serial: 'X',
            accessCode: '1',
          ),
        ),
        PrinterConnectionError.invalidConfig,
      );
    });

    test('no report after connecting -> noReports', () async {
      final t = FakeTransport();
      final a = BambuLanAdapter(
        config,
        transport: t,
        firstReportTimeout: const Duration(milliseconds: 20),
      );
      await expectLater(
        a.testConnection(),
        throwsA(
          isA<PrinterAdapterException>().having(
            (e) => e.error,
            'error',
            PrinterConnectionError.noReports,
          ),
        ),
      );
      await a.disconnect();
    });
  });

  group('certificate pinning (trust on first use)', () {
    final cert = FakeCert(Uint8List.fromList([1, 2, 3]));
    final fp = sha256.convert([1, 2, 3]).toString();

    test('first connection accepts and exposes the fingerprint', () async {
      final a = BambuLanAdapter(config, transport: FakeTransport(cert: cert));
      await a.connect();
      expect(a.observedCertSha256, fp);
      await a.disconnect();
    });

    test('same pinned certificate is accepted', () async {
      final a = BambuLanAdapter(
        BambuLanConfig(
          host: config.host,
          serial: config.serial,
          accessCode: config.accessCode,
          pinnedCertSha256: fp,
        ),
        transport: FakeTransport(cert: cert),
      );
      await a.connect();
      await a.disconnect();
    });

    test('a different certificate is rejected', () async {
      final a = BambuLanAdapter(
        BambuLanConfig(
          host: config.host,
          serial: config.serial,
          accessCode: config.accessCode,
          pinnedCertSha256: 'other',
        ),
        transport: FakeTransport(cert: cert),
      );
      await expectLater(
        a.connect(),
        throwsA(
          isA<PrinterAdapterException>().having(
            (e) => e.error,
            'error',
            PrinterConnectionError.certificateChanged,
          ),
        ),
      );
    });
  });
}

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/db/app_database.dart';
import 'package:printcost/data/printer/bambu_lan_adapter.dart';
import 'package:printcost/data/printer/secret_store.dart';
import 'package:printcost/domain/printer/printer_status.dart';
import 'package:printcost/presentation/printer_monitor/print_notifier.dart';
import 'package:printcost/presentation/printer_monitor/printer_session.dart';
import 'package:printcost/presentation/providers.dart';

import 'fake_transport.dart';

void main() {
  test(
    'notifies when a running print finishes and keeps the estimate',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      await db.customSelect('SELECT 1').get();
      await db
          .update(db.appSettings)
          .write(
            const AppSettingsCompanion(
              printerModuleEnabled: Value(true),
              localeCode: Value('pt'),
            ),
          );
      final secrets = MemorySecretStore();
      final notifier = NoopPrintNotifier();
      final transport = FakeTransport();
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          secretStoreProvider.overrideWithValue(secrets),
          printNotifierProvider.overrideWithValue(notifier),
          adapterFactoryProvider.overrideWithValue(
            (config, onRaw) => BambuLanAdapter(
              config,
              transport: transport,
              onRawMessage: onRaw,
            ),
          ),
        ],
      );
      addTearDown(() async {
        container.dispose();
        await db.close();
      });

      final id = await container
          .read(printerConnectionRepositoryProvider)
          .add(
            name: 'P1S',
            host: '192.168.0.50',
            serial: '01P00A123456',
            accessCode: '1a2b3c4d',
          );
      // Riverpod 3 pauses providers without listeners.
      container.listen(settingsProvider, (_, _) {});
      await container.read(settingsProvider.future);
      final sub = container.listen(printerSessionProvider(id), (_, _) {});
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(transport.password, '1a2b3c4d');

      const topic = 'device/01P00A123456/report';
      transport.emit(
        topic,
        '{"print":{"gcode_state":"RUNNING","mc_percent":25,"mc_remaining_time":90,"subtask_name":"Vaso"}}',
      );
      await pumpEventQueue();
      expect(sub.read().status.state, PrintState.printing);
      expect(sub.read().lastEstimatedTotalSeconds, 7200);

      transport.emit(
        topic,
        '{"print":{"gcode_state":"FINISH","mc_percent":100,"mc_remaining_time":0}}',
      );
      await pumpEventQueue();
      final s = sub.read();
      expect(s.status.state, PrintState.finished);
      expect(s.lastEstimatedTotalSeconds, 7200);
      expect(s.lastFinished?.taskName, 'Vaso');
      expect(s.rawLog, hasLength(2));
      expect(notifier.shown.single, ('Impressão concluída', 'Vaso'));
    },
  );
}

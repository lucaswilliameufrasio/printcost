import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/db/app_database.dart';
import 'package:printcost/data/printer/bambu_lan_adapter.dart';
import 'package:printcost/data/printer/mqtt_transport.dart';
import 'package:printcost/data/printer/secret_store.dart';
import 'package:printcost/presentation/printer_monitor/print_notifier.dart';
import 'package:printcost/presentation/printer_monitor/printer_module.dart';
import 'package:printcost/presentation/printer_monitor/printer_session.dart';

import '../printer/fake_transport.dart';
import 'test_app.dart';

const runningReport =
    '{"print":{"gcode_state":"IDLE","mc_percent":0,"mc_remaining_time":0}}';

Future<void> enableModule(AppDatabase db) =>
    (db.update(db.appSettings))
        .write(const AppSettingsCompanion(printerModuleEnabled: Value(true)));

Future<void> openWizardAndFill(WidgetTester tester) async {
  await tester.tap(find.text('Mais'));
  await settle(tester);
  await tester.tap(find.text('Impressora na rede'));
  await settle(tester);
  await tester.tap(find.byKey(const Key('printers.add')));
  await settle(tester);

  expect(find.text('Ative o modo LAN'), findsOneWidget);
  await tester.tap(find.byKey(const Key('wizard.next')));
  await settle(tester);
  expect(find.text('Ative o Developer Mode'), findsOneWidget);
  expect(
    find.textContaining('sem suporte oficial da fabricante'),
    findsOneWidget,
  );
  await tester.tap(find.byKey(const Key('wizard.next')));
  await settle(tester);

  // Validation keeps the user on step 3 until fields are valid.
  await tester.tap(find.byKey(const Key('wizard.next')));
  await settle(tester);
  expect(find.text('Use o formato 192.168.0.50'), findsOneWidget);

  await tester.enterText(find.byKey(const Key('wizard.ip')), '192.168.0.50');
  await tester.enterText(
    find.byKey(const Key('wizard.serial')),
    '01P00A-123456',
  );
  await tester.enterText(find.byKey(const Key('wizard.code')), '1a2b3c4d');
  await tester.tap(find.byKey(const Key('wizard.next')));
  await settle(tester);
  expect(find.text('Testar conexão'), findsWidgets);
}

void main() {
  final secrets = MemorySecretStore();
  final transports = <FakeTransport>[];

  testApp(
    'wizard: 4 steps, test connection, save code only in secure storage',
    (tester, db) async {
      await openWizardAndFill(tester);
      await tester.tap(find.byKey(const Key('wizard.test')));
      await settle(tester);

      expect(find.byKey(const Key('wizard.success')), findsOneWidget);
      expect(find.textContaining('Ociosa'), findsOneWidget);
      expect(transports.first.password, '1a2b3c4d');
      expect(transports.first.subscribed, ['device/01P00A123456/report']);

      await tester.tap(find.byKey(const Key('wizard.save')));
      await settle(tester);

      final rows = await tester.runAsync(
        () => db.select(db.printerConnections).get(),
      );
      expect(rows!.single.host, '192.168.0.50');
      expect(rows.single.serial, '01P00A-123456');
      expect(secrets.values[accessCodeKey(rows.single.id)], '1a2b3c4d');
      // The secret never reaches the SQLite file (and so never the backup).
      final dump = await tester.runAsync(
        () => db.customSelect('SELECT * FROM printer_connections').get(),
      );
      expect(dump!.single.data.values.join(), isNot(contains('1a2b3c4d')));
    },
    extraSeed: enableModule,
    overrides: [
      ...printerModuleOverrides(),
      secretStoreProvider.overrideWithValue(secrets),
      printNotifierProvider.overrideWithValue(NoopPrintNotifier()),
      adapterFactoryProvider.overrideWithValue((config, onRaw) {
        final t = FakeTransport()..autoReport = runningReport;
        transports.add(t);
        return BambuLanAdapter(config, transport: t, onRawMessage: onRaw);
      }),
    ],
  );

  testApp(
    'wizard: wrong access code shows a human message',
    (tester, db) async {
      await openWizardAndFill(tester);
      await tester.tap(find.byKey(const Key('wizard.test')));
      await settle(tester);
      expect(find.byKey(const Key('wizard.error')), findsOneWidget);
      expect(find.textContaining('Confira o código de acesso'), findsOneWidget);
      expect(find.byKey(const Key('wizard.save')), findsNothing);
    },
    extraSeed: enableModule,
    overrides: [
      ...printerModuleOverrides(),
      secretStoreProvider.overrideWithValue(MemorySecretStore()),
      printNotifierProvider.overrideWithValue(NoopPrintNotifier()),
      adapterFactoryProvider.overrideWithValue(
        (config, onRaw) => BambuLanAdapter(
          config,
          transport: FakeTransport(fail: TransportFailure.rejected),
        ),
      ),
    ],
  );

  testApp('module is hidden while the flag is off', (tester, db) async {
    await tester.tap(find.text('Mais'));
    await settle(tester);
    expect(find.text('Impressora na rede'), findsNothing);
  }, overrides: printerModuleOverrides());
}

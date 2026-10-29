import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/app.dart';
import 'package:printcost/data/db/app_database.dart';
import 'package:printcost/domain/pricing/cost_calculator.dart';
import 'package:printcost/presentation/providers.dart';

/// Pumps the whole app on an in-memory database with the hand-checked
/// example data (see test/domain/cost_calculator_test.dart).
Future<AppDatabase> pumpTestApp(
  WidgetTester tester, {
  List<Override> overrides = const [],
  bool seed = true,
  String locale = 'pt',
  bool onboardingDone = true,
  Future<void> Function(AppDatabase db)? extraSeed,
}) async {
  tester.view.physicalSize = const Size(1080, 6000);
  tester.view.devicePixelRatio = 2.5;
  addTearDown(tester.view.reset);

  final db = AppDatabase(NativeDatabase.memory());
  await tester.runAsync(() async {
    await db.customSelect('SELECT 1').get(); // runs migrations + settings row
    // The hand-checked example sells on a channel with a 12% commission.
    final channel = await db
        .into(db.salesChannels)
        .insert(
          SalesChannelsCompanion.insert(
            name: 'Loja 12%',
            tiers: const [FeeTier(feeBp: 1200)],
            sortOrder: const Value(-1),
          ),
        );
    await (db.update(db.appSettings)).write(
      AppSettingsCompanion(
        onboardingDone: Value(onboardingDone),
        defaultChannelId: Value(channel),
        localeCode: Value(locale),
        kwhPrice: const Value(9000),
        laborHourCents: const Value(3000),
        packagingCents: const Value(200),
        defaultWasteBp: const Value(1000),
        defaultFailureBp: const Value(500),
        defaultMarginBp: const Value(3000),
        taxBp: const Value(600),
      ),
    );
    if (seed) {
      await db
          .into(db.filaments)
          .insert(
            FilamentsCompanion.insert(
              brand: 'Marca',
              material: 'PLA',
              colorName: const Value('Branco'),
              rollPriceCents: 12000,
              stockMg: 1000000,
            ),
          );
      await db
          .into(db.printers)
          .insert(
            PrintersCompanion.insert(
              name: 'A1',
              powerWatts: 150,
              machineValueCents: 500000,
              lifespanHours: 5000,
              maintenancePerHourCents: const Value(20),
            ),
          );
    }
    if (extraSeed != null) await extraSeed(db);
  });

  await tester.pumpWidget(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db), ...overrides],
      child: const PrintCostApp(),
    ),
  );
  await settle(tester);
  return db;
}

/// testWidgets that tears the app down inside the test body, so drift and
/// Riverpod timers are flushed before the framework checks for leaks.
void testApp(
  String description,
  Future<void> Function(WidgetTester tester, AppDatabase db) body, {
  List<Override> overrides = const [],
  bool seed = true,
  String locale = 'pt',
  bool onboardingDone = true,
  Future<void> Function(AppDatabase db)? extraSeed,
}) {
  testWidgets(description, (tester) async {
    final db = await pumpTestApp(
      tester,
      overrides: overrides,
      seed: seed,
      locale: locale,
      onboardingDone: onboardingDone,
      extraSeed: extraSeed,
    );
    try {
      await body(tester, db);
    } finally {
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 1));
      await tester.runAsync(db.close);
      await tester.pump(const Duration(seconds: 1));
    }
  }, timeout: const Timeout(Duration(seconds: 60)));
}

/// Lets drift stream queries (real async) deliver, then settles frames.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

String brl(String amount) => 'R\$ $amount';

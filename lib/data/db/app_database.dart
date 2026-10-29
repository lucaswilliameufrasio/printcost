import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/models/job_status.dart';
import '../../domain/pricing/cost_calculator.dart';
import '../../domain/pricing/price_rounding.dart';
import 'app_database.steps.dart';
import 'converters.dart';
import 'seed_channels.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Absolute path of the SQLite file (also used by backup/restore).
Future<String> databaseFilePath() async {
  final dir = await getApplicationSupportDirectory();
  return p.join(dir.path, 'printcost.sqlite');
}

String _directName() =>
    Platform.localeName.startsWith('en') ? 'Direct sale' : 'Venda direta';

@DriftDatabase(
  tables: [
    Filaments,
    Printers,
    AppSettings,
    Jobs,
    JobFilaments,
    PrinterConnections,
    SalesChannels,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// For tests: pass `NativeDatabase.memory()`.
  AppDatabase(super.e);

  AppDatabase.defaults()
    : super(
        driftDatabase(
          name: 'printcost',
          native: const DriftNativeOptions(databasePath: databaseFilePath),
        ),
      );

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      final direct = await seedSalesChannels(this, directName: _directName());
      await into(appSettings).insert(
        AppSettingsCompanion(
          id: const Value(1),
          defaultChannelId: Value(direct),
        ),
      );
    },
    onUpgrade: stepByStep(
      // v2: optional printer module (local network printers).
      from1To2: (m, schema) async {
        await m.createTable(schema.printerConnections);
      },
      // v3: sales channels, first-run setup, several parts per print.
      from2To3: (m, schema) async {
        await m.createTable(schema.salesChannels);
        await m.addColumn(
          schema.appSettings,
          schema.appSettings.onboardingDone,
        );
        await m.addColumn(
          schema.appSettings,
          schema.appSettings.defaultChannelId,
        );
        await m.addColumn(schema.jobs, schema.jobs.channelId);
        await m.addColumn(schema.jobs, schema.jobs.channelName);
        await m.addColumn(schema.jobs, schema.jobs.marketplaceFixedCents);
        await m.addColumn(schema.jobs, schema.jobs.unitsPerPrint);

        var defaultChannel = await seedSalesChannels(
          this,
          directName: _directName(),
        );
        // Keep the old global marketplace fee as a channel of its own.
        final old = await customSelect(
          'SELECT marketplace_fee_bp FROM app_settings WHERE id = 1',
        ).getSingleOrNull();
        final oldFee = old?.read<int>('marketplace_fee_bp') ?? 0;
        if (oldFee > 0) {
          defaultChannel = await into(salesChannels).insert(
            SalesChannelsCompanion.insert(
              name: 'Marketplace',
              tiers: [FeeTier(feeBp: oldFee)],
              sortOrder: const Value(3),
            ),
          );
        }
        // Existing users already set things up; skip the first-run screens.
        await customUpdate(
          'UPDATE app_settings SET onboarding_done = 1, default_channel_id = ?',
          variables: [Variable.withInt(defaultChannel)],
        );
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await into(appSettings).insert(
        const AppSettingsCompanion(id: Value(1)),
        mode: InsertMode.insertOrIgnore,
      );
    },
  );
}

/// Inserts the starter channels and returns the id of "direct sale".
Future<int> seedSalesChannels(
  AppDatabase db, {
  required String directName,
}) async {
  final direct = await db
      .into(db.salesChannels)
      .insert(
        SalesChannelsCompanion.insert(
          name: directName,
          tiers: const [FeeTier()],
          sortOrder: const Value(0),
        ),
      );
  await db
      .into(db.salesChannels)
      .insert(
        SalesChannelsCompanion.insert(
          name: 'Shopee',
          tiers: shopeeExampleTiers,
          isExample: const Value(true),
          infoUrl: const Value(shopeeFeesUrl),
          sortOrder: const Value(1),
        ),
      );
  await db
      .into(db.salesChannels)
      .insert(
        SalesChannelsCompanion.insert(
          name: 'Mercado Livre (Clássico)',
          tiers: mercadoLivreExampleTiers,
          isExample: const Value(true),
          infoUrl: const Value(mercadoLivreFeesUrl),
          sortOrder: const Value(2),
        ),
      );
  return direct;
}

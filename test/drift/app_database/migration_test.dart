// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/db/app_database.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  test('migration from v1 to v2 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // Raw schema snapshots store booleans as 0/1 and dates as unix seconds.
    final created = DateTime(2026, 10, 1, 12).millisecondsSinceEpoch ~/ 1000;
    final oldFilamentsData = <v1.FilamentsData>[
      v1.FilamentsData(
        id: 1,
        brand: 'Marca',
        material: 'PLA',
        colorName: 'Branco',
        colorArgb: 0xFFFFFFFF,
        rollPriceCents: 12000,
        rollWeightGrams: 1000,
        stockMg: 750000,
        lowStockAlertMg: 100000,
        archived: 0,
        createdAt: created,
      ),
    ];
    final expectedNewFilamentsData = <v2.FilamentsData>[
      v2.FilamentsData(
        id: 1,
        brand: 'Marca',
        material: 'PLA',
        colorName: 'Branco',
        colorArgb: 0xFFFFFFFF,
        rollPriceCents: 12000,
        rollWeightGrams: 1000,
        stockMg: 750000,
        lowStockAlertMg: 100000,
        archived: 0,
        createdAt: created,
      ),
    ];

    final oldPrintersData = <v1.PrintersData>[
      v1.PrintersData(
        id: 1,
        name: 'A1',
        powerWatts: 95,
        machineValueCents: 300000,
        lifespanHours: 5000,
        maintenancePerHourCents: 10,
        archived: 0,
        createdAt: created,
      ),
    ];
    final expectedNewPrintersData = <v2.PrintersData>[
      v2.PrintersData(
        id: 1,
        name: 'A1',
        powerWatts: 95,
        machineValueCents: 300000,
        lifespanHours: 5000,
        maintenancePerHourCents: 10,
        archived: 0,
        createdAt: created,
      ),
    ];

    final oldAppSettingsData = <v1.AppSettingsData>[];
    final expectedNewAppSettingsData = <v2.AppSettingsData>[];

    final oldJobsData = <v1.JobsData>[];
    final expectedNewJobsData = <v2.JobsData>[];

    final oldJobFilamentsData = <v1.JobFilamentsData>[];
    final expectedNewJobFilamentsData = <v2.JobFilamentsData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.filaments, oldFilamentsData);
        batch.insertAll(oldDb.printers, oldPrintersData);
        batch.insertAll(oldDb.appSettings, oldAppSettingsData);
        batch.insertAll(oldDb.jobs, oldJobsData);
        batch.insertAll(oldDb.jobFilaments, oldJobFilamentsData);
      },
      validateItems: (newDb) async {
        expect(
          expectedNewFilamentsData,
          await newDb.select(newDb.filaments).get(),
        );
        expect(
          expectedNewPrintersData,
          await newDb.select(newDb.printers).get(),
        );
        // beforeOpen always guarantees the single settings row (id 1).
        expect(expectedNewAppSettingsData, isEmpty);
        final settings = await newDb.select(newDb.appSettings).get();
        expect(settings.single.id, 1);
        expect(expectedNewJobsData, await newDb.select(newDb.jobs).get());
        expect(
          expectedNewJobFilamentsData,
          await newDb.select(newDb.jobFilaments).get(),
        );
      },
    );
  });
}

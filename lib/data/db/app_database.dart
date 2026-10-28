import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/models/job_status.dart';
import '../../domain/pricing/price_rounding.dart';
import 'app_database.steps.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Absolute path of the SQLite file (also used by backup/restore).
Future<String> databaseFilePath() async {
  final dir = await getApplicationSupportDirectory();
  return p.join(dir.path, 'printcost.sqlite');
}

@DriftDatabase(
  tables: [
    Filaments,
    Printers,
    AppSettings,
    Jobs,
    JobFilaments,
    PrinterConnections,
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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: stepByStep(
      // v2: optional printer module (local network printers).
      from1To2: (m, schema) async {
        await m.createTable(schema.printerConnections);
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

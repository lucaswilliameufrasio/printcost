import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/backup/backup_service.dart';
import 'package:printcost/data/db/app_database.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late Directory tmp;
  late BackupService service;

  setUp(() async {
    tmp = await Directory.systemTemp.createTemp('printcost_backup_test');
    service = BackupService(tempDir: tmp);
  });
  tearDown(() => tmp.delete(recursive: true));

  test('export -> validate -> restore keeps the data', () async {
    final db = AppDatabase(NativeDatabase.memory());
    await db
        .into(db.filaments)
        .insert(
          FilamentsCompanion.insert(
            brand: 'Marca',
            material: 'PETG',
            colorName: const Value('Azul'),
            rollPriceCents: 9990,
            stockMg: 500000,
          ),
        );
    final bytes = await service.export(db);
    final schema = db.schemaVersion;
    await db.close();

    expect(await service.validate(bytes, currentSchema: schema), schema);

    final path = '${tmp.path}/restored.sqlite';
    await service.replaceDatabaseFile(bytes, path);
    final restored = AppDatabase(NativeDatabase(File(path)));
    final rows = await restored.select(restored.filaments).get();
    expect(rows.single.material, 'PETG');
    expect(rows.single.stockMg, 500000);
    await restored.close();
  });

  test('rejects files that are not SQLite', () async {
    expect(
      () => service.validate(
        Uint8List.fromList(List.filled(200, 65)),
        currentSchema: 2,
      ),
      throwsA(
        isA<BackupException>().having(
          (e) => e.problem,
          'problem',
          BackupProblem.notSqlite,
        ),
      ),
    );
  });

  test('rejects other SQLite databases and newer versions', () async {
    final otherPath = '${tmp.path}/other.sqlite';
    sqlite3.open(otherPath)
      ..execute('CREATE TABLE notes (id INTEGER)')
      ..close();
    await expectLater(
      service.validate(await File(otherPath).readAsBytes(), currentSchema: 2),
      throwsA(
        isA<BackupException>().having(
          (e) => e.problem,
          'problem',
          BackupProblem.notPrintCost,
        ),
      ),
    );

    final db = AppDatabase(NativeDatabase.memory());
    await db.customStatement('PRAGMA user_version = 99');
    final newer = await service.export(db);
    await db.close();
    await expectLater(
      service.validate(newer, currentSchema: 2),
      throwsA(
        isA<BackupException>().having(
          (e) => e.problem,
          'problem',
          BackupProblem.newerVersion,
        ),
      ),
    );
  });
}

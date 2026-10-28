import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import '../db/app_database.dart';

enum BackupProblem { notSqlite, notPrintCost, newerVersion }

class BackupException implements Exception {
  const BackupException(this.problem);
  final BackupProblem problem;

  @override
  String toString() => 'BackupException(${problem.name})';
}

const _sqliteHeader = 'SQLite format 3\u0000';
const _requiredTables = {'filaments', 'printers', 'app_settings', 'jobs'};

/// Manual backup/restore of the whole SQLite database.
class BackupService {
  BackupService({required this.tempDir});

  /// Directory for temporary files (e.g. `getTemporaryDirectory()`).
  final Directory tempDir;

  String suggestedFileName(DateTime now) {
    String two(int v) => v.toString().padLeft(2, '0');
    return 'printcost-backup-${now.year}${two(now.month)}${two(now.day)}-'
        '${two(now.hour)}${two(now.minute)}.sqlite';
  }

  /// Consistent snapshot of the open database (works while the app runs).
  Future<Uint8List> export(AppDatabase db) async {
    final file = File(
      p.join(
        tempDir.path,
        'export-${DateTime.now().microsecondsSinceEpoch}.sqlite',
      ),
    );
    try {
      final escaped = file.path.replaceAll("'", "''");
      await db.customStatement("VACUUM INTO '$escaped'");
      return await file.readAsBytes();
    } finally {
      if (file.existsSync()) await file.delete();
    }
  }

  /// Checks that [bytes] is a PrintCost database this version can open.
  /// Returns its schema version or throws [BackupException].
  Future<int> validate(Uint8List bytes, {required int currentSchema}) async {
    if (bytes.length < 100 ||
        String.fromCharCodes(bytes.sublist(0, 16)) != _sqliteHeader) {
      throw const BackupException(BackupProblem.notSqlite);
    }
    final file = File(
      p.join(
        tempDir.path,
        'check-${DateTime.now().microsecondsSinceEpoch}.sqlite',
      ),
    );
    await file.writeAsBytes(bytes, flush: true);
    try {
      final db = sqlite3.open(file.path, mode: OpenMode.readOnly);
      try {
        final tables = {
          for (final row in db.select(
            "SELECT name FROM sqlite_master WHERE type = 'table'",
          ))
            row['name'] as String,
        };
        if (!tables.containsAll(_requiredTables)) {
          throw const BackupException(BackupProblem.notPrintCost);
        }
        final version =
            db.select('PRAGMA user_version').first.values.first as int;
        if (version > currentSchema) {
          throw const BackupException(BackupProblem.newerVersion);
        }
        return version;
      } finally {
        db.close();
      }
    } on SqliteException {
      throw const BackupException(BackupProblem.notSqlite);
    } finally {
      if (file.existsSync()) await file.delete();
    }
  }

  /// Replaces the database file. The database must be closed before and
  /// reopened after (drift runs pending migrations on open).
  Future<void> replaceDatabaseFile(Uint8List bytes, String dbPath) async {
    for (final suffix in ['-wal', '-shm', '-journal']) {
      final f = File('$dbPath$suffix');
      if (f.existsSync()) await f.delete();
    }
    final tmp = File('$dbPath.restore');
    await tmp.writeAsBytes(bytes, flush: true);
    await tmp.rename(dbPath);
  }
}

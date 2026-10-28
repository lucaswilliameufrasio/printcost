import 'package:drift/drift.dart';

import '../db/app_database.dart';

/// Filaments, printers and global settings.
class CatalogRepository {
  CatalogRepository(this._db);
  final AppDatabase _db;

  Stream<List<FilamentRow>> watchFilaments({bool includeArchived = false}) {
    final q = _db.select(_db.filaments)
      ..orderBy([
        (f) => OrderingTerm.asc(f.material),
        (f) => OrderingTerm.asc(f.brand),
        (f) => OrderingTerm.asc(f.colorName),
      ]);
    if (!includeArchived) q.where((f) => f.archived.equals(false));
    return q.watch();
  }

  Future<FilamentRow?> filament(int id) => (_db.select(
    _db.filaments,
  )..where((f) => f.id.equals(id))).getSingleOrNull();

  Future<int> saveFilament(FilamentsCompanion data) async {
    if (data.id.present) {
      await (_db.update(
        _db.filaments,
      )..where((f) => f.id.equals(data.id.value))).write(data);
      return data.id.value;
    }
    return _db.into(_db.filaments).insert(data);
  }

  /// Archived filaments disappear from pickers but keep history intact.
  Future<void> archiveFilament(int id) =>
      (_db.update(_db.filaments)..where((f) => f.id.equals(id))).write(
        const FilamentsCompanion(archived: Value(true)),
      );

  Stream<List<PrinterRow>> watchPrinters() =>
      (_db.select(_db.printers)
            ..where((p) => p.archived.equals(false))
            ..orderBy([(p) => OrderingTerm.asc(p.name)]))
          .watch();

  Future<int> savePrinter(PrintersCompanion data) async {
    if (data.id.present) {
      await (_db.update(
        _db.printers,
      )..where((p) => p.id.equals(data.id.value))).write(data);
      return data.id.value;
    }
    return _db.into(_db.printers).insert(data);
  }

  Future<void> archivePrinter(int id) =>
      (_db.update(_db.printers)..where((p) => p.id.equals(id))).write(
        const PrintersCompanion(archived: Value(true)),
      );

  Stream<SettingsRow> watchSettings() =>
      (_db.select(_db.appSettings)..where((s) => s.id.equals(1))).watchSingle();

  Future<SettingsRow> settings() =>
      (_db.select(_db.appSettings)..where((s) => s.id.equals(1))).getSingle();

  Future<void> updateSettings(AppSettingsCompanion data) =>
      (_db.update(_db.appSettings)..where((s) => s.id.equals(1))).write(data);
}

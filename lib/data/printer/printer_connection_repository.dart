import 'package:drift/drift.dart';

import '../db/app_database.dart';
import 'secret_store.dart';

/// Printer connections: non-secret data in SQLite, access code and the
/// pinned certificate fingerprint only in [SecretStore].
class PrinterConnectionRepository {
  PrinterConnectionRepository(this._db, this._secrets);
  final AppDatabase _db;
  final SecretStore _secrets;

  Stream<List<PrinterConnectionRow>> watchAll() => (_db.select(
    _db.printerConnections,
  )..orderBy([(c) => OrderingTerm.asc(c.name)])).watch();

  Future<PrinterConnectionRow?> get(int id) => (_db.select(
    _db.printerConnections,
  )..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<int> add({
    required String name,
    required String host,
    required String serial,
    required String accessCode,
    int? printerId,
    String? certSha256,
  }) async {
    final id = await _db
        .into(_db.printerConnections)
        .insert(
          PrinterConnectionsCompanion.insert(
            name: name,
            host: host,
            serial: serial,
            printerId: Value(printerId),
          ),
        );
    await _secrets.write(accessCodeKey(id), accessCode);
    if (certSha256 != null) await _secrets.write(certPinKey(id), certSha256);
    return id;
  }

  Future<String?> accessCode(int id) => _secrets.read(accessCodeKey(id));
  Future<String?> certPin(int id) => _secrets.read(certPinKey(id));
  Future<void> pinCertificate(int id, String sha256) =>
      _secrets.write(certPinKey(id), sha256);

  Future<void> delete(int id) async {
    await (_db.delete(
      _db.printerConnections,
    )..where((c) => c.id.equals(id))).go();
    await _secrets.delete(accessCodeKey(id));
    await _secrets.delete(certPinKey(id));
  }
}

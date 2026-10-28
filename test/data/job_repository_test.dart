import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/db/app_database.dart';
import 'package:printcost/data/repositories/catalog_repository.dart';
import 'package:printcost/data/repositories/job_repository.dart';
import 'package:printcost/domain/models/job_status.dart';
import 'package:printcost/domain/pricing/price_rounding.dart';
import 'package:printcost/domain/stock/stock_deduction.dart';

void main() {
  late AppDatabase db;
  late CatalogRepository catalog;
  late JobRepository jobs;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    catalog = CatalogRepository(db);
    jobs = JobRepository(db);
  });
  tearDown(() => db.close());

  Future<int> addFilament(String color, int stockG, int alertG) =>
      catalog.saveFilament(
        FilamentsCompanion.insert(
          brand: 'Marca',
          material: 'PLA',
          colorName: Value(color),
          rollPriceCents: 12000,
          stockMg: stockG * 1000,
          lowStockAlertMg: Value(alertG * 1000),
        ),
      );

  JobsCompanion job({int quantity = 1}) => JobsCompanion.insert(
    name: 'Vaso',
    status: JobStatus.quote,
    quantity: Value(quantity),
    printSeconds: 3600,
    postProcessMinutes: 0,
    kwhPrice: 9000,
    laborHourCents: 0,
    packagingCents: 0,
    wasteBp: 1000,
    failureBp: 0,
    marginBp: 3000,
    marketplaceFeeBp: 0,
    taxBp: 0,
    priceRounding: PriceRounding.none,
    costCents: 1000,
    priceCents: 2000,
    profitCents: 1000,
  );

  JobFilamentsCompanion line(int filamentId, int grams) =>
      JobFilamentsCompanion.insert(
        jobId: 0,
        filamentId: Value(filamentId),
        label: 'PLA',
        weightMg: grams * 1000,
        rollPriceCents: 12000,
        rollWeightGrams: 1000,
      );

  test('settings row is created with sensible defaults', () async {
    final s = await catalog.settings();
    expect(s.currencyCode, 'BRL');
    expect(s.defaultMarginBp, 3000);
    expect(s.printerModuleEnabled, isFalse);
  });

  test(
    'marking as printed deducts each filament once, with waste and qty',
    () async {
      final white = await addFilament('Branco', 1000, 100);
      final black = await addFilament('Preto', 200, 100);
      final id = await jobs.saveJob(job(quantity: 2), [
        line(white, 50),
        line(black, 40),
      ]);

      final r = await jobs.markPrinted(id);
      expect(r.alreadyDeducted, isFalse);
      // white: 50 g × 2 × 1,10 = 110 g -> 890 g
      expect((await catalog.filament(white))!.stockMg, 890000);
      // black: 40 g × 2 × 1,10 = 88 g -> 112 g (alert at 100 g: not yet)
      expect((await catalog.filament(black))!.stockMg, 112000);
      expect(r.deduction!.warnings, isEmpty);

      final saved = (await jobs.job(id))!.job;
      expect(saved.stockDeducted, isTrue);
      expect(saved.printedAt, isNotNull);
      expect(saved.status, JobStatus.inProduction);

      final again = await jobs.markPrinted(id);
      expect(again.alreadyDeducted, isTrue);
      expect((await catalog.filament(white))!.stockMg, 890000);
    },
  );

  test('warns when a roll is running out', () async {
    final f = await addFilament('Azul', 150, 100);
    final id = await jobs.saveJob(job(), [line(f, 50)]);
    final r = await jobs.markPrinted(id);
    expect(r.deduction!.warnings.single.kind, StockWarningKind.low);
    expect(r.filamentNames[f], contains('Azul'));
  });

  test(
    'deleting a job removes its lines; deleted filament keeps snapshot',
    () async {
      final f = await addFilament('Verde', 1000, 100);
      final id = await jobs.saveJob(job(), [line(f, 10)]);
      await (db.delete(db.filaments)..where((t) => t.id.equals(f))).go();
      final j = await jobs.job(id);
      expect(j!.filaments.single.filamentId, isNull);
      expect(j.filaments.single.label, 'PLA');
      await jobs.deleteJob(id);
      expect(await db.select(db.jobFilaments).get(), isEmpty);
    },
  );
}

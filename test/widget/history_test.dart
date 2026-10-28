import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/db/app_database.dart';
import 'package:printcost/data/repositories/job_repository.dart';
import 'package:printcost/domain/models/job_status.dart';
import 'package:printcost/domain/pricing/price_rounding.dart';

import 'test_app.dart';

void main() {
  testApp('mark as printed deducts stock and warns when low', (
    tester,
    db,
  ) async {
    await tester.tap(find.text('Histórico'));
    await settle(tester);
    await tester.tap(find.text('Suporte de celular'));
    await settle(tester);
    await tester.tap(find.byKey(const Key('job.markPrinted')));
    await settle(tester);

    expect(find.textContaining('está acabando'), findsOneWidget);
    final f = await tester.runAsync(() => db.select(db.filaments).getSingle());
    expect(f!.stockMg, 90000);
    await tester.tap(find.text('OK'));
    await settle(tester);
    expect(find.byKey(const Key('job.markPrinted')), findsNothing);
    expect(find.text('Impressa'), findsOneWidget);
  }, extraSeed: _seedJob);
}

Future<void> _seedJob(AppDatabase db) async {
  final f = (await db.select(db.filaments).get()).single;
  // Leave the roll close to the alert threshold (100 g).
  await (db.update(db.filaments)..where((t) => t.id.equals(f.id))).write(
    const FilamentsCompanion(stockMg: Value(150000)),
  );
  await JobRepository(db).saveJob(
    JobsCompanion.insert(
      name: 'Suporte de celular',
      status: JobStatus.quote,
      printSeconds: 3600,
      postProcessMinutes: 0,
      kwhPrice: 0,
      laborHourCents: 0,
      packagingCents: 0,
      wasteBp: 0,
      failureBp: 0,
      marginBp: 3000,
      marketplaceFeeBp: 0,
      taxBp: 0,
      priceRounding: PriceRounding.none,
      costCents: 500,
      priceCents: 1000,
      profitCents: 500,
    ),
    [
      JobFilamentsCompanion.insert(
        jobId: 0,
        filamentId: Value(f.id),
        label: 'PLA · Marca · Branco',
        weightMg: 60000,
        rollPriceCents: 12000,
        rollWeightGrams: 1000,
      ),
    ],
  );
}

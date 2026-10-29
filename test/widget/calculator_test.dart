import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/domain/models/job_status.dart';

import 'test_app.dart';

void main() {
  testApp('calculates the hand-checked example', (tester, db) async {
    await tester.enterText(find.byKey(const Key('calc.grams.0')), '50');
    await tester.enterText(find.byKey(const Key('calc.hours')), '4');
    await tester.enterText(find.byKey(const Key('calc.post')), '15');
    await tester.pump();

    expect(find.byKey(const Key('calc.price')), findsOneWidget);
    expect(
      tester.widget<Text>(find.byKey(const Key('calc.price'))).data,
      brl('43,29'),
    );
    expect(
      tester.widget<Text>(find.byKey(const Key('calc.cost'))).data,
      brl('22,51'),
    );
    expect(find.text('Material'), findsOneWidget);
    expect(find.text(brl('6,60')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const Key('calc.priceBar')),
        matching: find.text(brl('43,29')),
      ),
      findsOneWidget,
    );
    // Same margin on the seeded "direct sale" channel (no fees):
    // 22,51 / (1 − 0,30 − 0,06) = 35,17
    // Its name follows the device language when the database is created.
    final channels = await tester.runAsync(
      () => db.select(db.salesChannels).get(),
    );
    final direct = channels!.firstWhere(
      (c) => !c.isExample && c.tiers.single.feeBp == 0,
    );
    expect(find.text(direct.name), findsOneWidget);
    expect(find.text(brl('35,17')), findsOneWidget);
  });

  testApp('several parts per print: price per part and stored per part', (
    tester,
    db,
  ) async {
    await tester.enterText(find.byKey(const Key('calc.grams.0')), '200');
    await tester.enterText(find.byKey(const Key('calc.hours')), '4');
    await tester.enterText(find.byKey(const Key('calc.units')), '4');
    await tester.enterText(find.byKey(const Key('calc.post')), '15');
    await tester.pump();

    // 200 g / 4 = 50 g per part: material 6,60 like the single part, while
    // energy (0,54 → 0,14) and wear (4,80 → 1,20) are split by 4.
    expect(find.text('Preço sugerido por peça'), findsOneWidget);
    expect(find.text(brl('6,60')), findsOneWidget);
    expect(find.byKey(const Key('calc.batchTotal')), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('calc.save')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('calc.save')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('save.name')), 'Chaveiro');
    await tester.tap(find.byKey(const Key('save.confirm')));
    await settle(tester);

    final job = (await tester.runAsync(() => db.select(db.jobs).get()))!.single;
    expect(job.unitsPerPrint, 4);
    expect(job.quantity, 4, reason: 'quantity defaults to parts per print');
    expect(job.channelName, 'Loja 12%');
    final lines = await tester.runAsync(() => db.select(db.jobFilaments).get());
    expect(lines!.single.weightMg, 50000, reason: 'stored per part');
  });

  testApp('shows a friendly error when margin + fees reach 100%', (
    tester,
    db,
  ) async {
    await tester.enterText(find.byKey(const Key('calc.grams.0')), '50');
    await tester.enterText(find.byKey(const Key('calc.margin')), '82');
    await tester.pump();

    expect(find.byKey(const Key('calc.price')), findsNothing);
    expect(find.byKey(const Key('calc.error')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const Key('calc.error')),
        matching: find.textContaining('somam 100%'),
      ),
      findsOneWidget,
    );
    // The bottom bar repeats the error so it is seen without scrolling.
    expect(
      find.descendant(
        of: find.byKey(const Key('calc.priceBar')),
        matching: find.textContaining('somam 100%'),
      ),
      findsOneWidget,
    );
  });

  testApp('supports several filaments and saves to history', (
    tester,
    db,
  ) async {
    await tester.enterText(find.byKey(const Key('calc.grams.0')), '50');
    await tester.tap(find.text('Adicionar outro filamento'));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('calc.grams.1')), '10');
    await tester.enterText(find.byKey(const Key('calc.hours')), '4');
    await tester.enterText(find.byKey(const Key('calc.post')), '15');
    await tester.pump();

    // 60 g instead of 50 g: material 7,92 instead of 6,60.
    expect(find.text(brl('7,92')), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('calc.save')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('calc.save')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('save.name')), 'Vaso');
    await tester.tap(find.byKey(const Key('save.confirm')));
    await settle(tester);

    final jobs = await tester.runAsync(() => db.select(db.jobs).get());
    expect(jobs!.single.name, 'Vaso');
    expect(jobs.single.status, JobStatus.quote);
    final lines = await tester.runAsync(() => db.select(db.jobFilaments).get());
    expect(lines!.map((l) => l.weightMg), [50000, 10000]);
    expect(find.text('Peça salva no histórico'), findsOneWidget);
  });
}

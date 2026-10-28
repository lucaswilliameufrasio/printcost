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
    expect(find.textContaining('somam 100%'), findsOneWidget);
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

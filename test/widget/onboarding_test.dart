import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testApp(
    'first run: costs, filament, skip printer, channel, then calculator',
    (tester, db) async {
      expect(find.text('Seus custos'), findsOneWidget);
      await tester.enterText(find.byKey(const Key('ob.labor')), '40');
      await tester.tap(find.byKey(const Key('ob.next')));
      await tester.pumpAndSettle();

      expect(find.text('Seu primeiro filamento'), findsOneWidget);
      // Brand and price are required.
      await tester.tap(find.byKey(const Key('ob.next')));
      await tester.pumpAndSettle();
      expect(find.text('Seu primeiro filamento'), findsOneWidget);
      await tester.enterText(find.byKey(const Key('ob.brand')), 'Voolt');
      await tester.enterText(find.byKey(const Key('ob.rollPrice')), '119,90');
      await tester.tap(find.byKey(const Key('ob.next')));
      await tester.pumpAndSettle();

      expect(find.text('Sua impressora'), findsOneWidget);
      await tester.tap(find.byKey(const Key('ob.skip')));
      await tester.pumpAndSettle();

      expect(find.text('Onde você vende'), findsOneWidget);
      expect(find.textContaining('taxas de exemplo'), findsWidgets);
      await tester.tap(find.text('Shopee'));
      await tester.pump();
      await tester.tap(find.byKey(const Key('ob.next')));
      await settle(tester);

      expect(find.byKey(const Key('calc.grams.0')), findsOneWidget);
      final settings = await tester.runAsync(
        () => db.select(db.appSettings).getSingle(),
      );
      expect(settings!.onboardingDone, isTrue);
      expect(settings.laborHourCents, 4000);
      final channels = await tester.runAsync(
        () => db.select(db.salesChannels).get(),
      );
      expect(
        channels!.singleWhere((c) => c.id == settings.defaultChannelId).name,
        'Shopee',
      );
      final filaments = await tester.runAsync(
        () => db.select(db.filaments).get(),
      );
      expect(filaments!.single.brand, 'Voolt');
      expect(filaments.single.rollPriceCents, 11990);
      expect(filaments.single.stockMg, 1000000);
      final printers = await tester.runAsync(
        () => db.select(db.printers).get(),
      );
      expect(printers, isEmpty);
    },
    seed: false,
    onboardingDone: false,
  );
}

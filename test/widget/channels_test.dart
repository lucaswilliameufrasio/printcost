import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testApp('example fees: calculator points to the channel to check them', (
    tester,
    db,
  ) async {
    await tester.enterText(find.byKey(const Key('calc.grams.0')), '50');
    await tester.pump();
    // The default channel has fees the user set: no notice.
    expect(find.byKey(const Key('calc.exampleFees')), findsNothing);
    // Other channels with example fees say so in the comparison list.
    expect(find.text('Shopee · taxas de exemplo'), findsOneWidget);

    await tester.tap(find.byKey(const Key('calc.channel')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Shopee').last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('calc.exampleFees')), findsOneWidget);

    await tester.tap(find.byKey(const Key('calc.exampleFees')));
    await settle(tester);
    expect(find.byKey(const Key('channel.exampleWarning')), findsOneWidget);
    expect(find.byKey(const Key('channel.officialFees')), findsOneWidget);
    expect(
      tester
          .widget<TextField>(
            find.descendant(
              of: find.byKey(const Key('channel.infoUrl')),
              matching: find.byType(TextField),
            ),
          )
          .controller!
          .text,
      startsWith('https://seller.shopee.com.br/'),
    );

    // The user checks the fees, fixes them and saves.
    await tester.enterText(find.byKey(const Key('channel.percent.0')), '18');
    await tester.tap(find.byKey(const Key('channel.save')));
    await settle(tester);

    // Back on the calculator, still with the same part, without the notice.
    expect(find.byKey(const Key('calc.grams.0')), findsOneWidget);
    expect(find.byKey(const Key('calc.exampleFees')), findsNothing);
    final shopee = await tester.runAsync(
      () => (db.select(
        db.salesChannels,
      )..where((c) => c.name.equals('Shopee'))).getSingle(),
    );
    expect(shopee!.isExample, isFalse);
    expect(shopee.tiers.first.feeBp, 1800);
  });

  testApp('rejects a fees link that is not https', (tester, db) async {
    await tester.tap(find.text('Mais'));
    await settle(tester);
    await tester.tap(find.text('Canais de venda'));
    await settle(tester);
    await tester.tap(find.text('Loja 12%'));
    await settle(tester);

    await tester.enterText(
      find.byKey(const Key('channel.infoUrl')),
      'loja.com/taxas',
    );
    await tester.tap(find.byKey(const Key('channel.save')));
    await tester.pumpAndSettle();
    expect(find.text('Use um link que comece com https://'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('channel.infoUrl')),
      'https://loja.com/taxas',
    );
    await tester.tap(find.byKey(const Key('channel.save')));
    await settle(tester);
    final channel = await tester.runAsync(
      () => (db.select(
        db.salesChannels,
      )..where((c) => c.name.equals('Loja 12%'))).getSingle(),
    );
    expect(channel!.infoUrl, 'https://loja.com/taxas');
  });
}

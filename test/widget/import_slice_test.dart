import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/slicer/three_mf_parser.dart';
import 'package:printcost/presentation/calculator/calculator_screen.dart';
import 'package:printcost/presentation/slicer/import_slice.dart';

import 'test_app.dart';

void main() {
  final info = parseThreeMf(
    File('test/fixtures/sample_bambu_sliced.3mf').readAsBytesSync(),
  );

  testApp(
    'importing a .3mf fills grams per filament and print time',
    (tester, db) async {
      await tester.tap(find.byKey(const Key('calc.import')));
      await settle(tester);

      // Two sliced plates -> the user picks one.
      expect(find.text('Qual placa você quer importar?'), findsOneWidget);
      await tester.tap(find.text('Vaso bicolor'));
      await settle(tester);

      expect(find.text('Dados encontrados no arquivo'), findsOneWidget);
      expect(find.text('Tempo de impressão: 2h 15min'), findsOneWidget);
      await tester.tap(find.byKey(const Key('import.apply')));
      await settle(tester);

      String text(String key) => tester
          .widget<EditableText>(
            find.descendant(
              of: find.byKey(Key(key)),
              matching: find.byType(EditableText),
            ),
          )
          .controller
          .text;
      expect(text('calc.grams.0'), '35,88');
      expect(text('calc.grams.1'), '9,43');
      expect(text('calc.hours'), '2');
      expect(text('calc.minutes'), '15');
      expect(find.byKey(const Key('calc.price')), findsOneWidget);
    },
    overrides: [
      sliceImportActionProvider.overrideWithValue(
        (context, ref) =>
            applySliceInfo(context, ref, info, sourceFile: 'Vaso.gcode.3mf'),
      ),
    ],
  );
}

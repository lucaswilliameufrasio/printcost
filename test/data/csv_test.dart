import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/export/csv.dart';

String decode(List<int> bytes) {
  expect(bytes.sublist(0, 3), [0xEF, 0xBB, 0xBF], reason: 'UTF-8 BOM');
  return utf8.decode(bytes.sublist(3));
}

void main() {
  test('quotes cells with separators, quotes and line breaks', () {
    final text = decode(
      encodeCsv([
        ['Peça', 'Preço'],
        ['Vaso; grande', '43,90'],
        ['Diz "oi"', 'linha\nnova'],
      ], separator: ';'),
    );
    expect(
      text,
      'Peça;Preço\r\n'
      '"Vaso; grande";43,90\r\n'
      '"Diz ""oi""";"linha\nnova"\r\n',
    );
  });

  test('comma separator quotes decimal commas', () {
    final text = decode(
      encodeCsv([
        ['a', '1,5'],
      ]),
    );
    expect(text, 'a,"1,5"\r\n');
  });

  test('user text that looks like a formula is neutralized', () {
    expect(csvText('=HYPERLINK("x")'), "'=HYPERLINK(\"x\")");
    expect(csvText('+55 11'), "'+55 11");
    expect(csvText('@loja'), "'@loja");
    expect(csvText('Maria'), 'Maria');
    expect(csvText(''), '');
  });
}

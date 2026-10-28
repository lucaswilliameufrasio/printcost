import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/core/format/scaled_decimal.dart';
import 'package:printcost/core/money/ratio.dart';

void main() {
  group('parseScaled', () {
    int? money(String s, [String sep = ',']) =>
        parseScaled(s, scale: 2, decimalSeparator: sep);

    test('pt-BR inputs', () {
      expect(money('12,90'), 1290);
      expect(money('12,9'), 1290);
      expect(money('1.234,56'), 123456);
      expect(money('R\$ 1.234,56'), 123456);
      expect(money('1.234'), 123400);
      expect(money('1.234.567'), 123456700);
      expect(money('0,5'), 50);
      expect(money(',5'), 50);
      expect(money('12'), 1200);
    });

    test('dot as decimal on a pt-BR keyboard', () {
      expect(money('0.5'), 50);
      expect(money('12.90'), 1290);
    });

    test('en inputs', () {
      expect(money('1,234.56', '.'), 123456);
      expect(money('1,234', '.'), 123400);
      expect(money('12.5', '.'), 1250);
    });

    test('rounds extra decimals half-up', () {
      expect(money('0,125'.replaceAll('.', '')), 13);
      expect(parseScaled('0,89567', scale: 4), 8957);
    });

    test('invalid', () {
      expect(money(''), isNull);
      expect(money('abc'), isNull);
      expect(money('-1'), isNull);
      expect(money('1,2,3.4'), isNull);
      expect(parseScaled('-1,5', scale: 2, allowNegative: true), -150);
    });
  });

  test('formatScaled', () {
    expect(formatScaled(1290, scale: 2), '12,90');
    expect(formatScaled(1290, scale: 2, trimZeros: true), '12,9');
    expect(formatScaled(1200, scale: 2, trimZeros: true), '12');
    expect(formatScaled(5, scale: 2), '0,05');
    expect(formatScaled(-5, scale: 2, decimalSeparator: '.'), '-0.05');
    expect(formatScaled(12340, scale: 3, trimZeros: true), '12,34');
  });

  group('Ratio', () {
    test('roundHalfUp', () {
      expect(Ratio.of(5, 2).roundHalfUp(), 3);
      expect(Ratio.of(-5, 2).roundHalfUp(), -3);
      expect(Ratio.of(7, 3).roundHalfUp(), 2);
      expect(Ratio.of(22512, 1000).roundHalfUp(), 23);
    });
    test('ceil and arithmetic', () {
      expect(Ratio.of(7, 3).ceil(), 3);
      expect(Ratio.of(6, 3).ceil(), 2);
      expect(Ratio.of(1, 3) + Ratio.of(1, 6), Ratio.of(1, 2));
      expect(Ratio.of(1, 2) / Ratio.of(1, 4), Ratio.of(2));
    });
  });
}

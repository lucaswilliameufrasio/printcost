import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/core/format/scaled_decimal.dart';
import 'package:printcost/presentation/common/formatters.dart';

void main() {
  final fmt = Formatters(locale: 'pt-BR', currencyCode: 'BRL');

  test('money fields always show cents', () {
    expect(fmt.inputMoney(2500), '25,00');
    expect(fmt.inputMoney(0), '0,00');
    expect(fmt.inputMoney(11990), '119,90');
  });

  test('kWh price keeps 2 to 4 decimals', () {
    expect(fmt.inputMoney(9000, Scales.kwhPrice), '0,90');
    expect(fmt.inputMoney(8950, Scales.kwhPrice), '0,895');
    expect(fmt.inputMoney(8951, Scales.kwhPrice), '0,8951');
  });

  test('percent and grams stay short', () {
    // Same scale as money (2), but no forced cents.
    expect(fmt.input(0, Scales.percent), '0');
    expect(fmt.input(1250, Scales.percent), '12,5');
    expect(fmt.input(50000, Scales.grams), '50');
  });

  test('whole currency for chart axes', () {
    expect(fmt.moneyWhole(1200), r'R$ 1.200');
  });
}

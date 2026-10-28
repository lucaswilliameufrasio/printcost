import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/domain/stock/stock_deduction.dart';

void main() {
  const stock = [
    FilamentStock(filamentId: 1, stockMg: 1000000, lowStockAlertMg: 100000),
    FilamentStock(filamentId: 2, stockMg: 150000, lowStockAlertMg: 100000),
    FilamentStock(filamentId: 3, stockMg: 20000, lowStockAlertMg: 50000),
  ];

  test('deducts grams plus waste from each filament', () {
    final r = deductStock(
      stock: stock,
      consumption: const [FilamentConsumption(filamentId: 1, weightMg: 100000)],
      wasteBp: 1000,
    );
    expect(r.deductedMg, {1: 110000});
    expect(r.newStockMg, {1: 890000});
    expect(r.warnings, isEmpty);
  });

  test('several filaments, same filament twice is summed', () {
    final r = deductStock(
      stock: stock,
      consumption: const [
        FilamentConsumption(filamentId: 1, weightMg: 10000),
        FilamentConsumption(filamentId: 2, weightMg: 20000),
        FilamentConsumption(filamentId: 1, weightMg: 5000),
      ],
    );
    expect(r.newStockMg, {1: 985000, 2: 130000});
  });

  test('warns when the roll is running out', () {
    final r = deductStock(
      stock: stock,
      consumption: const [FilamentConsumption(filamentId: 2, weightMg: 60000)],
    );
    expect(r.newStockMg[2], 90000);
    expect(r.warnings.single.kind, StockWarningKind.low);
    expect(r.warnings.single.filamentId, 2);
  });

  test('never goes below zero and flags insufficient stock', () {
    final r = deductStock(
      stock: stock,
      consumption: const [FilamentConsumption(filamentId: 3, weightMg: 30000)],
    );
    expect(r.newStockMg[3], 0);
    expect(r.warnings.single.kind, StockWarningKind.insufficient);
  });

  test('ignores unknown filaments and zero usage', () {
    final r = deductStock(
      stock: stock,
      consumption: const [
        FilamentConsumption(filamentId: 99, weightMg: 30000),
        FilamentConsumption(filamentId: 1, weightMg: 0),
      ],
    );
    expect(r.newStockMg, isEmpty);
  });
}

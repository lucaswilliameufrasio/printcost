import '../../core/money/ratio.dart';

/// Current stock of one filament roll.
class FilamentStock {
  const FilamentStock({
    required this.filamentId,
    required this.stockMg,
    required this.lowStockAlertMg,
  });

  final int filamentId;
  final int stockMg;

  /// Warn when the remaining stock is at or below this amount.
  final int lowStockAlertMg;
}

/// Filament consumed by a printed part.
class FilamentConsumption {
  const FilamentConsumption({required this.filamentId, required this.weightMg});
  final int filamentId;
  final int weightMg;
}

enum StockWarningKind {
  /// Remaining stock is at or below the alert threshold.
  low,

  /// The part needed more filament than registered; stock went to zero.
  insufficient,
}

class StockWarning {
  const StockWarning({
    required this.filamentId,
    required this.kind,
    required this.remainingMg,
  });

  final int filamentId;
  final StockWarningKind kind;
  final int remainingMg;
}

class StockDeductionResult {
  const StockDeductionResult({
    required this.newStockMg,
    required this.deductedMg,
    required this.warnings,
  });

  /// New stock per filament id (only filaments that changed).
  final Map<int, int> newStockMg;

  /// Amount deducted per filament id, including waste/purge.
  final Map<int, int> deductedMg;
  final List<StockWarning> warnings;
}

/// Computes the stock after printing a part. Pure function.
///
/// The waste/purge percentage used for the cost is also deducted, because
/// that filament really leaves the roll. Stock never goes below zero.
/// Consumptions of filaments that are not in [stock] (e.g. deleted) are
/// ignored.
StockDeductionResult deductStock({
  required List<FilamentStock> stock,
  required List<FilamentConsumption> consumption,
  int wasteBp = 0,
}) {
  final byId = {for (final s in stock) s.filamentId: s};
  final deducted = <int, int>{};
  for (final c in consumption) {
    if (!byId.containsKey(c.filamentId) || c.weightMg <= 0) continue;
    final withWaste = (Ratio.of(c.weightMg) * Ratio.of(10000 + wasteBp, 10000))
        .roundHalfUp();
    deducted.update(
      c.filamentId,
      (v) => v + withWaste,
      ifAbsent: () => withWaste,
    );
  }

  final newStock = <int, int>{};
  final warnings = <StockWarning>[];
  for (final MapEntry(key: id, value: amount) in deducted.entries) {
    final s = byId[id]!;
    final raw = s.stockMg - amount;
    final remaining = raw < 0 ? 0 : raw;
    newStock[id] = remaining;
    if (raw < 0) {
      warnings.add(
        StockWarning(
          filamentId: id,
          kind: StockWarningKind.insufficient,
          remainingMg: remaining,
        ),
      );
    } else if (remaining <= s.lowStockAlertMg) {
      warnings.add(
        StockWarning(
          filamentId: id,
          kind: StockWarningKind.low,
          remainingMg: remaining,
        ),
      );
    }
  }
  return StockDeductionResult(
    newStockMg: newStock,
    deductedMg: deducted,
    warnings: warnings,
  );
}

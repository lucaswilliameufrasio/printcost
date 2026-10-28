/// How the suggested price is rounded for display/sale.
///
/// Rounding always goes **up**, so it never eats into the margin.
enum PriceRounding {
  none,

  /// Next price ending in ,90 (e.g. 43,29 -> 43,90; 43,95 -> 44,90).
  endsIn90,

  /// Next price ending in ,99.
  endsIn99,

  /// Next multiple of 0,50.
  halfUnit,

  /// Next whole unit (e.g. 43,29 -> 44,00).
  wholeUnit;

  static PriceRounding fromName(String? name) => PriceRounding.values
      .firstWhere((r) => r.name == name, orElse: () => PriceRounding.none);
}

/// Applies [rounding] to a price in cents.
int applyPriceRounding(int cents, PriceRounding rounding) {
  if (cents <= 0) return cents;
  switch (rounding) {
    case PriceRounding.none:
      return cents;
    case PriceRounding.endsIn90:
      return _nextEnding(cents, 90);
    case PriceRounding.endsIn99:
      return _nextEnding(cents, 99);
    case PriceRounding.halfUnit:
      return _ceilToMultiple(cents, 50);
    case PriceRounding.wholeUnit:
      return _ceilToMultiple(cents, 100);
  }
}

int _nextEnding(int cents, int ending) {
  final whole = cents ~/ 100;
  final candidate = whole * 100 + ending;
  return candidate >= cents ? candidate : candidate + 100;
}

int _ceilToMultiple(int cents, int step) =>
    cents % step == 0 ? cents : (cents ~/ step + 1) * step;

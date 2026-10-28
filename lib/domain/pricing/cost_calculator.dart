import '../../core/money/ratio.dart';
import 'price_rounding.dart';

/// Filament consumed by one part. A part can use several filaments (AMS).
class FilamentUsage {
  const FilamentUsage({
    required this.weightMg,
    required this.rollPriceCents,
    required this.rollWeightGrams,
  });

  /// Weight used, in milligrams (12,34 g = 12340).
  final int weightMg;

  /// Price paid for the whole roll, in cents.
  final int rollPriceCents;

  /// Net filament weight of the roll, in grams (usually 1000).
  final int rollWeightGrams;
}

/// Cost-relevant data of a printer.
class MachineProfile {
  const MachineProfile({
    required this.powerWatts,
    required this.machineValueCents,
    required this.lifespanHours,
    this.maintenancePerHourCents = 0,
  });

  final int powerWatts;
  final int machineValueCents;

  /// Expected useful life in printing hours. `0` disables depreciation.
  final int lifespanHours;
  final int maintenancePerHourCents;
}

/// Everything needed to price one part. All values are integers:
/// money in cents, percentages in basis points (1% = 100), weight in mg,
/// time in seconds, kWh price in ten-thousandths of the currency unit.
class PricingInput {
  const PricingInput({
    required this.filaments,
    required this.printSeconds,
    required this.machine,
    required this.kwhPrice,
    required this.postProcessMinutes,
    required this.laborHourCents,
    required this.packagingCents,
    required this.wasteBp,
    required this.failureBp,
    required this.marginBp,
    required this.marketplaceFeeBp,
    required this.taxBp,
    this.rounding = PriceRounding.none,
  });

  final List<FilamentUsage> filaments;
  final int printSeconds;
  final MachineProfile? machine;

  /// Price of 1 kWh with 4 decimal places (R$ 0,8950 = 8950).
  final int kwhPrice;
  final int postProcessMinutes;
  final int laborHourCents;
  final int packagingCents;
  final int wasteBp;
  final int failureBp;
  final int marginBp;
  final int marketplaceFeeBp;
  final int taxBp;
  final PriceRounding rounding;
}

/// Detailed result. Every amount is in cents.
class CostBreakdown {
  const CostBreakdown({
    required this.materialCents,
    required this.energyCents,
    required this.machineWearCents,
    required this.laborCents,
    required this.packagingCents,
    required this.subtotalCents,
    required this.failureCents,
    required this.totalCostCents,
    required this.unroundedPriceCents,
    required this.priceCents,
    required this.marketplaceFeeCents,
    required this.taxCents,
    required this.netProfitCents,
    required this.netMarginBp,
  });

  final int materialCents;
  final int energyCents;
  final int machineWearCents;
  final int laborCents;
  final int packagingCents;

  /// material + energy + wear + labor + packaging.
  final int subtotalCents;

  /// Extra cost reserved for failed prints.
  final int failureCents;

  /// subtotal + failure. This is the real cost of the part.
  final int totalCostCents;

  /// cost / (1 - margin - fees - taxes), before rounding.
  final int unroundedPriceCents;

  /// Suggested sale price after the chosen rounding.
  final int priceCents;
  final int marketplaceFeeCents;
  final int taxCents;

  /// price - cost - marketplace fee - taxes.
  final int netProfitCents;

  /// Net profit as a share of the price, in basis points.
  final int netMarginBp;
}

enum PricingError {
  /// Some value is negative.
  negativeValue,

  /// A filament has a roll weight of zero.
  invalidRollWeight,

  /// margin + marketplace fee + taxes is 100% or more: no price can cover it.
  deductionsTooHigh,
}

sealed class PricingResult {
  const PricingResult();
}

final class PricingSuccess extends PricingResult {
  const PricingSuccess(this.breakdown);
  final CostBreakdown breakdown;
}

final class PricingFailure extends PricingResult {
  const PricingFailure(this.error, {this.deductionsBp});
  final PricingError error;

  /// Sum of margin + fees + taxes, set for [PricingError.deductionsTooHigh].
  final int? deductionsBp;
}

const int _bpPerUnit = 10000;

/// Pure pricing function. No I/O, no Flutter, no database.
///
/// * Material = Σ(grams × price per gram) × (1 + waste%)
/// * Energy = (W / 1000) × hours × kWh price
/// * Wear = (machine value / lifespan h + maintenance/h) × hours
/// * Labor = post-processing minutes × hourly rate / 60
/// * Subtotal = material + energy + wear + labor + packaging
/// * Cost = subtotal × (1 + failure%)
/// * Price = cost / (1 − margin − fees − taxes)
///
/// Each component is computed exactly and rounded half-up to cents once, so
/// the parts of the breakdown always add up to the totals shown.
PricingResult calculatePrice(PricingInput input) {
  final ints = <int>[
    input.printSeconds,
    input.kwhPrice,
    input.postProcessMinutes,
    input.laborHourCents,
    input.packagingCents,
    input.wasteBp,
    input.failureBp,
    input.marginBp,
    input.marketplaceFeeBp,
    input.taxBp,
    for (final f in input.filaments) ...[
      f.weightMg,
      f.rollPriceCents,
      f.rollWeightGrams,
    ],
    if (input.machine case final m?) ...[
      m.powerWatts,
      m.machineValueCents,
      m.lifespanHours,
      m.maintenancePerHourCents,
    ],
  ];
  if (ints.any((v) => v < 0)) {
    return const PricingFailure(PricingError.negativeValue);
  }
  if (input.filaments.any((f) => f.rollWeightGrams == 0 && f.weightMg > 0)) {
    return const PricingFailure(PricingError.invalidRollWeight);
  }
  final deductionsBp = input.marginBp + input.marketplaceFeeBp + input.taxBp;
  if (deductionsBp >= _bpPerUnit) {
    return PricingFailure(
      PricingError.deductionsTooHigh,
      deductionsBp: deductionsBp,
    );
  }

  // Material: mg × (rollPrice / (rollWeight g × 1000)) summed, then waste.
  var material = Ratio.zero;
  for (final f in input.filaments) {
    if (f.weightMg == 0) continue;
    material +=
        Ratio.of(f.weightMg) *
        Ratio.of(f.rollPriceCents, f.rollWeightGrams * 1000);
  }
  material *= Ratio.of(_bpPerUnit + input.wasteBp, _bpPerUnit);
  final materialCents = material.roundHalfUp();

  final hours = Ratio.of(input.printSeconds, 3600);

  var energyCents = 0;
  var wearCents = 0;
  if (input.machine case final m?) {
    // W/1000 × h × (kwhPrice / 10000 currency) × 100 cents.
    energyCents =
        (Ratio.of(m.powerWatts, 1000) * hours * Ratio.of(input.kwhPrice, 100))
            .roundHalfUp();
    final depreciationPerHour = m.lifespanHours == 0
        ? Ratio.zero
        : Ratio.of(m.machineValueCents, m.lifespanHours);
    wearCents =
        ((depreciationPerHour + Ratio.of(m.maintenancePerHourCents)) * hours)
            .roundHalfUp();
  }

  final laborCents = Ratio.of(
    input.postProcessMinutes * input.laborHourCents,
    60,
  ).roundHalfUp();

  final subtotal =
      materialCents +
      energyCents +
      wearCents +
      laborCents +
      input.packagingCents;
  final totalCost =
      (Ratio.of(subtotal) * Ratio.of(_bpPerUnit + input.failureBp, _bpPerUnit))
          .roundHalfUp();
  final failureCents = totalCost - subtotal;

  final unroundedPrice =
      (Ratio.of(totalCost) * Ratio.of(_bpPerUnit, _bpPerUnit - deductionsBp))
          .roundHalfUp();
  final price = applyPriceRounding(unroundedPrice, input.rounding);

  final feeCents = Ratio.of(
    price * input.marketplaceFeeBp,
    _bpPerUnit,
  ).roundHalfUp();
  final taxCents = Ratio.of(price * input.taxBp, _bpPerUnit).roundHalfUp();
  final profit = price - totalCost - feeCents - taxCents;
  final marginBp = price == 0
      ? 0
      : Ratio.of(profit * _bpPerUnit, price).roundHalfUp();

  return PricingSuccess(
    CostBreakdown(
      materialCents: materialCents,
      energyCents: energyCents,
      machineWearCents: wearCents,
      laborCents: laborCents,
      packagingCents: input.packagingCents,
      subtotalCents: subtotal,
      failureCents: failureCents,
      totalCostCents: totalCost,
      unroundedPriceCents: unroundedPrice,
      priceCents: price,
      marketplaceFeeCents: feeCents,
      taxCents: taxCents,
      netProfitCents: profit,
      netMarginBp: marginBp,
    ),
  );
}

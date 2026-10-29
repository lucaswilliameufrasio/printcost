import '../../core/format/scaled_decimal.dart';
import '../../domain/pricing/cost_calculator.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/formatters.dart';

/// `20% + R$ 4,50`, `14%`, `R$ 2,00` or "No fees".
String feeLabel(AppLocalizations l, Formatters fmt, FeeTier t) {
  final parts = [
    if (t.feeBp > 0) fmt.percent(t.feeBp),
    if (t.fixedCents > 0) fmt.money(t.fixedCents),
  ];
  return parts.isEmpty ? l.channelNoFees : parts.join(' + ');
}

/// One line per tier, or just the fee when there is a single tier.
String tiersSummary(AppLocalizations l, Formatters fmt, List<FeeTier> tiers) {
  final sorted = normalizeTiers(tiers);
  if (sorted.length == 1) return feeLabel(l, fmt, sorted.single);
  return [
    for (final t in sorted)
      l.channelTierSummary(fmt.money(t.minPriceCents), feeLabel(l, fmt, t)),
  ].join('\n');
}

/// For prefilling percent fields from basis points.
String percentInput(Formatters fmt, int bp) => fmt.input(bp, Scales.percent);

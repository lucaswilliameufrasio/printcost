import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/money/ratio.dart';
import '../../domain/pricing/cost_calculator.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/formatters.dart';

/// Categorical palette (fixed order, never cycled), validated for
/// colorblind separation on light and dark surfaces.
const _lightSlots = [
  Color(0xFF2A78D6),
  Color(0xFFEB6834),
  Color(0xFF1BAF7A),
  Color(0xFFEDA100),
  Color(0xFFE87BA4),
  Color(0xFF008300),
  Color(0xFF6250D6),
  Color(0xFFE34948),
];
const _darkSlots = [
  Color(0xFF3987E5),
  Color(0xFFD95926),
  Color(0xFF199E70),
  Color(0xFFC98500),
  Color(0xFFD55181),
  Color(0xFF008300),
  Color(0xFF9085E9),
  Color(0xFFE66767),
];

class _Part {
  const _Part(this.slot, this.label, this.cents);
  final int slot;
  final String label;
  final int cents;
}

/// Part-to-whole of the sale price: one horizontal stacked bar plus a
/// legend that doubles as the table view with exact values.
class BreakdownChart extends StatelessWidget {
  const BreakdownChart({required this.breakdown, required this.fmt, super.key});

  final CostBreakdown breakdown;
  final Formatters fmt;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final slots = theme.brightness == Brightness.dark
        ? _darkSlots
        : _lightSlots;
    final b = breakdown;
    final parts = [
      _Part(0, l.breakdownMaterial, b.materialCents),
      _Part(1, l.breakdownEnergy, b.energyCents),
      _Part(2, l.breakdownWear, b.machineWearCents),
      _Part(3, l.breakdownLabor, b.laborCents),
      _Part(4, l.breakdownPackaging, b.packagingCents),
      _Part(5, l.breakdownFailure, b.failureCents),
      _Part(
        6,
        '${l.breakdownFees} + ${l.breakdownTaxes}',
        b.marketplaceFeeCents + b.taxCents,
      ),
      _Part(7, l.breakdownProfit, b.netProfitCents),
    ];
    final visible = parts.where((p) => p.cents > 0).toList();
    final total = visible.fold<int>(0, (s, p) => s + p.cents);

    // Stack segments; doubles here are only screen geometry, never money.
    final stack = <BarChartRodStackItem>[];
    var from = 0.0;
    for (final p in visible) {
      final to = from + p.cents;
      stack.add(
        BarChartRodStackItem(
          from,
          to,
          slots[p.slot],
          borderSide: BorderSide(color: theme.colorScheme.surface, width: 2),
        ),
      );
      from = to;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (total > 0)
          SizedBox(
            height: 36,
            child: Semantics(
              label: l.calcBreakdown,
              child: RotatedBox(
                quarterTurns: 1,
                child: BarChart(
                  BarChartData(
                    maxY: total.toDouble(),
                    minY: 0,
                    alignment: BarChartAlignment.center,
                    titlesData: const FlTitlesData(show: false),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barTouchData: const BarTouchData(enabled: false),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: total.toDouble(),
                            width: 28,
                            rodStackItems: stack,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    ],
                  ),
                  duration: Duration.zero,
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        for (final p in parts)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: slots[p.slot],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(p.label)),
                Text(
                  total == 0
                      ? ''
                      : fmt.percent(
                          Ratio.of(p.cents * 10000, total).roundHalfUp(),
                        ),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 96,
                  child: Text(fmt.money(p.cents), textAlign: TextAlign.end),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

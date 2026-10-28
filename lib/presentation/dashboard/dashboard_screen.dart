import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/stats/dashboard_stats.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../providers.dart';
import '../router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    return Scaffold(
      appBar: AppBar(title: Text(l.navDashboard)),
      body: AsyncView(
        value: ref.watch(dashboardStatsProvider),
        builder: (s) {
          if (s.soldJobs == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(l.dashboardEmpty, textAlign: TextAlign.center),
              ),
            );
          }
          final theme = Theme.of(context);
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2,
                children: [
                  _StatTile(l.dashProfit, fmt.money(s.profitCents)),
                  _StatTile(l.dashRevenue, fmt.money(s.revenueCents)),
                  _StatTile(l.dashAvgMargin, fmt.percent(s.averageMarginBp)),
                  _StatTile(l.dashJobsSold, '${s.soldJobs}'),
                ],
              ),
              const SizedBox(height: 12),
              _Section(
                title: l.dashProfitByMonth,
                child: SizedBox(
                  height: 220,
                  child: _MonthlyProfitChart(stats: s, fmt: fmt),
                ),
              ),
              const SizedBox(height: 12),
              _Section(
                title: l.dashTopJobs,
                child: Column(
                  children: [
                    for (final j in s.topJobs)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(j.name),
                        subtitle: Text(fmt.percent(j.marginBp)),
                        trailing: Text(
                          fmt.money(j.totalProfitCents),
                          style: theme.textTheme.titleSmall,
                        ),
                        onTap: () => context.go(Routes.job(j.id)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (s.filamentUsageMg.isNotEmpty)
                _Section(
                  title: l.dashFilamentUsage,
                  child: Column(
                    children: [
                      for (final (label, mg) in s.filamentUsageMg.take(5))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(label)),
                                  Text(fmt.weight(mg)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: mg / s.filamentUsageMg.first.$2,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              Text(l.dashNote, style: theme.textTheme.bodySmall),
            ],
          );
        },
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: theme.textTheme.bodySmall),
            FittedBox(child: Text(value, style: theme.textTheme.headlineSmall)),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          child,
        ],
      ),
    ),
  );
}

/// Single series: one hue, no legend (the title names it), tooltip on touch.
class _MonthlyProfitChart extends StatelessWidget {
  const _MonthlyProfitChart({required this.stats, required this.fmt});
  final DashboardStats stats;
  final Formatters fmt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final barColor = dark ? const Color(0xFF3987E5) : const Color(0xFF2A78D6);
    final months = stats.profitByMonth.length > 12
        ? stats.profitByMonth.sublist(stats.profitByMonth.length - 12)
        : stats.profitByMonth;
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return BarChart(
      BarChartData(
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: theme.colorScheme.outlineVariant, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= months.length) return const SizedBox();
                final (m, _) = months[i];
                return SideTitleWidget(
                  meta: meta,
                  child: Text(fmt.monthShort(m.year, m.month), style: muted),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => theme.colorScheme.inverseSurface,
            getTooltipItem: (group, _, _, _) {
              final (m, cents) = months[group.x];
              return BarTooltipItem(
                '${fmt.monthShort(m.year, m.month)}\n${fmt.money(cents)}',
                TextStyle(color: theme.colorScheme.onInverseSurface),
              );
            },
          ),
        ),
        barGroups: [
          for (final (i, (_, cents)) in months.indexed)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  // Chart geometry only; values stay integer cents elsewhere.
                  toY: cents / 100,
                  color: barColor,
                  width: 16,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

import '../../core/money/ratio.dart';
import '../models/job_status.dart';

/// Minimal view of a saved job used for statistics.
class JobStatsEntry {
  const JobStatsEntry({
    required this.id,
    required this.name,
    required this.status,
    required this.quantity,
    required this.priceCents,
    required this.profitCents,
    required this.date,
    this.filaments = const [],
  });

  final int id;
  final String name;
  final JobStatus status;
  final int quantity;

  /// Per unit.
  final int priceCents;
  final int profitCents;

  /// Date the job counts for (printed date, or creation date).
  final DateTime date;
  final List<({String label, int weightMg})> filaments;
}

class MonthKey implements Comparable<MonthKey> {
  const MonthKey(this.year, this.month);
  final int year;
  final int month;

  @override
  int compareTo(MonthKey other) => year != other.year
      ? year.compareTo(other.year)
      : month.compareTo(other.month);

  @override
  bool operator ==(Object other) =>
      other is MonthKey && other.year == year && other.month == month;

  @override
  int get hashCode => Object.hash(year, month);
}

class JobProfit {
  const JobProfit({
    required this.id,
    required this.name,
    required this.totalProfitCents,
    required this.marginBp,
  });
  final int id;
  final String name;
  final int totalProfitCents;
  final int marginBp;
}

class DashboardStats {
  const DashboardStats({
    required this.profitByMonth,
    required this.revenueCents,
    required this.profitCents,
    required this.averageMarginBp,
    required this.soldJobs,
    required this.topJobs,
    required this.filamentUsageMg,
  });

  /// Net profit per month, oldest first.
  final List<(MonthKey, int)> profitByMonth;
  final int revenueCents;
  final int profitCents;

  /// Total profit / total revenue (weighted average margin).
  final int averageMarginBp;
  final int soldJobs;

  /// Most profitable jobs, best first.
  final List<JobProfit> topJobs;

  /// Filament label -> total grams (mg) used, most used first.
  final List<(String, int)> filamentUsageMg;

  String? get mostUsedFilament =>
      filamentUsageMg.isEmpty ? null : filamentUsageMg.first.$1;
}

/// Builds dashboard numbers. Quotes (not approved) are ignored.
/// Pure function so it can be unit tested.
DashboardStats computeDashboardStats(
  List<JobStatsEntry> jobs, {
  int topCount = 5,
}) {
  final sold = jobs.where((j) => j.status != JobStatus.quote).toList();
  final byMonth = <MonthKey, int>{};
  final usage = <String, int>{};
  var revenue = 0;
  var profit = 0;
  for (final j in sold) {
    final jobProfit = j.profitCents * j.quantity;
    revenue += j.priceCents * j.quantity;
    profit += jobProfit;
    final key = MonthKey(j.date.year, j.date.month);
    byMonth.update(key, (v) => v + jobProfit, ifAbsent: () => jobProfit);
    for (final f in j.filaments) {
      final mg = f.weightMg * j.quantity;
      usage.update(f.label, (v) => v + mg, ifAbsent: () => mg);
    }
  }
  final months = byMonth.keys.toList()..sort();
  final top = [
    for (final j in sold)
      JobProfit(
        id: j.id,
        name: j.name,
        totalProfitCents: j.profitCents * j.quantity,
        marginBp: j.priceCents == 0
            ? 0
            : Ratio.of(j.profitCents * 10000, j.priceCents).roundHalfUp(),
      ),
  ]..sort((a, b) => b.totalProfitCents.compareTo(a.totalProfitCents));
  final usageList = usage.entries.map((e) => (e.key, e.value)).toList()
    ..sort((a, b) => b.$2.compareTo(a.$2));

  return DashboardStats(
    profitByMonth: [for (final m in months) (m, byMonth[m]!)],
    revenueCents: revenue,
    profitCents: profit,
    averageMarginBp: revenue == 0
        ? 0
        : Ratio.of(profit * 10000, revenue).roundHalfUp(),
    soldJobs: sold.length,
    topJobs: top.take(topCount).toList(),
    filamentUsageMg: usageList,
  );
}

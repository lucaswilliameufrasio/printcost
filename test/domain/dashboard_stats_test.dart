import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/domain/models/job_status.dart';
import 'package:printcost/domain/stats/dashboard_stats.dart';

void main() {
  JobStatsEntry job(
    int id,
    JobStatus status,
    DateTime date, {
    int qty = 1,
    int price = 1000,
    int profit = 300,
    List<({String label, int weightMg})> filaments = const [],
  }) => JobStatsEntry(
    id: id,
    name: 'Peça $id',
    status: status,
    quantity: qty,
    priceCents: price,
    profitCents: profit,
    date: date,
    filaments: filaments,
  );

  test('ignores quotes and groups profit by month', () {
    final s = computeDashboardStats([
      job(1, JobStatus.delivered, DateTime(2026, 9, 3), qty: 2),
      job(2, JobStatus.inProduction, DateTime(2026, 9, 20), profit: 100),
      job(
        3,
        JobStatus.delivered,
        DateTime(2026, 10),
        price: 2000,
        profit: 1000,
      ),
      job(4, JobStatus.quote, DateTime(2026, 10, 2), profit: 99999),
    ]);
    expect(s.soldJobs, 3);
    expect(s.profitByMonth.map((e) => (e.$1.month, e.$2)), [
      (9, 700),
      (10, 1000),
    ]);
    expect(s.revenueCents, 2000 + 1000 + 2000);
    expect(s.profitCents, 1700);
    // 1700 / 5000 = 34%
    expect(s.averageMarginBp, 3400);
    expect(s.topJobs.first.id, 3);
    expect(s.topJobs.first.marginBp, 5000);
  });

  test('most used filament accounts for quantity', () {
    final s = computeDashboardStats([
      job(
        1,
        JobStatus.delivered,
        DateTime(2026),
        qty: 3,
        filaments: [(label: 'PLA Branco', weightMg: 10000)],
      ),
      job(
        2,
        JobStatus.delivered,
        DateTime(2026),
        filaments: [
          (label: 'PETG Preto', weightMg: 25000),
          (label: 'PLA Branco', weightMg: 1000),
        ],
      ),
    ]);
    expect(s.mostUsedFilament, 'PLA Branco');
    expect(s.filamentUsageMg.first.$2, 31000);
  });

  test('empty input', () {
    final s = computeDashboardStats([]);
    expect(s.averageMarginBp, 0);
    expect(s.mostUsedFilament, isNull);
  });
}

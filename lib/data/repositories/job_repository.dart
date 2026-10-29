import 'package:drift/drift.dart';

import '../../domain/models/job_status.dart';
import '../../domain/stats/dashboard_stats.dart';
import '../../domain/stock/stock_deduction.dart';
import '../db/app_database.dart';

class JobWithFilaments {
  const JobWithFilaments(this.job, this.filaments);
  final JobRow job;
  final List<JobFilamentRow> filaments;
}

/// Result of marking a job as printed, with names for the warnings.
class PrintedResult {
  const PrintedResult({
    required this.alreadyDeducted,
    required this.deduction,
    required this.filamentNames,
  });
  final bool alreadyDeducted;
  final StockDeductionResult? deduction;
  final Map<int, String> filamentNames;
}

String filamentLabel(FilamentRow f) =>
    [f.material, f.brand, if (f.colorName.isNotEmpty) f.colorName].join(' · ');

class JobRepository {
  JobRepository(this._db);
  final AppDatabase _db;

  Stream<List<JobRow>> watchJobs({JobStatus? status, String search = ''}) {
    final q = _db.select(_db.jobs)
      ..orderBy([(j) => OrderingTerm.desc(j.createdAt)]);
    if (status != null) q.where((j) => j.status.equalsValue(status));
    final term = search.trim();
    if (term.isNotEmpty) {
      q.where((j) => j.name.contains(term) | j.customer.contains(term));
    }
    return q.watch();
  }

  Stream<JobWithFilaments?> watchJob(int id) {
    final jobStream = (_db.select(
      _db.jobs,
    )..where((j) => j.id.equals(id))).watchSingleOrNull();
    return jobStream.asyncMap((job) async {
      if (job == null) return null;
      final lines = await (_db.select(
        _db.jobFilaments,
      )..where((l) => l.jobId.equals(id))).get();
      return JobWithFilaments(job, lines);
    });
  }

  Future<JobWithFilaments?> job(int id) => watchJob(id).first;

  /// Every job with its filament lines, newest first (for export).
  Future<List<JobWithFilaments>> allJobs() async {
    final jobs = await (_db.select(
      _db.jobs,
    )..orderBy([(j) => OrderingTerm.desc(j.createdAt)])).get();
    final lines = await _db.select(_db.jobFilaments).get();
    final byJob = <int, List<JobFilamentRow>>{};
    for (final l in lines) {
      byJob.putIfAbsent(l.jobId, () => []).add(l);
    }
    return [for (final j in jobs) JobWithFilaments(j, byJob[j.id] ?? [])];
  }

  /// Inserts or replaces a job and its filament lines atomically.
  Future<int> saveJob(JobsCompanion job, List<JobFilamentsCompanion> lines) =>
      _db.transaction(() async {
        int id;
        if (job.id.present) {
          id = job.id.value;
          await (_db.update(
            _db.jobs,
          )..where((j) => j.id.equals(id))).write(job);
          await (_db.delete(
            _db.jobFilaments,
          )..where((l) => l.jobId.equals(id))).go();
        } else {
          id = await _db.into(_db.jobs).insert(job);
        }
        for (final l in lines) {
          await _db.into(_db.jobFilaments).insert(l.copyWith(jobId: Value(id)));
        }
        return id;
      });

  Future<void> setStatus(int id, JobStatus status) => (_db.update(
    _db.jobs,
  )..where((j) => j.id.equals(id))).write(JobsCompanion(status: Value(status)));

  Future<void> deleteJob(int id) =>
      (_db.delete(_db.jobs)..where((j) => j.id.equals(id))).go();

  /// Marks the job as printed and deducts the filament used (× quantity,
  /// plus waste) from stock. Idempotent: stock is deducted only once.
  Future<PrintedResult> markPrinted(int id) => _db.transaction(() async {
    final job = await (_db.select(
      _db.jobs,
    )..where((j) => j.id.equals(id))).getSingle();
    if (job.stockDeducted) {
      return const PrintedResult(
        alreadyDeducted: true,
        deduction: null,
        filamentNames: {},
      );
    }
    final lines = await (_db.select(
      _db.jobFilaments,
    )..where((l) => l.jobId.equals(id))).get();
    final ids = {
      for (final l in lines)
        if (l.filamentId != null) l.filamentId!,
    };
    final rows = ids.isEmpty
        ? <FilamentRow>[]
        : await (_db.select(_db.filaments)..where((f) => f.id.isIn(ids))).get();

    final result = deductStock(
      stock: [
        for (final f in rows)
          FilamentStock(
            filamentId: f.id,
            stockMg: f.stockMg,
            lowStockAlertMg: f.lowStockAlertMg,
          ),
      ],
      consumption: [
        for (final l in lines)
          if (l.filamentId != null)
            FilamentConsumption(
              filamentId: l.filamentId!,
              weightMg: l.weightMg * job.quantity,
            ),
      ],
      wasteBp: job.wasteBp,
    );
    for (final MapEntry(key: fid, value: mg) in result.newStockMg.entries) {
      await (_db.update(_db.filaments)..where((f) => f.id.equals(fid))).write(
        FilamentsCompanion(stockMg: Value(mg)),
      );
    }
    await (_db.update(_db.jobs)..where((j) => j.id.equals(id))).write(
      JobsCompanion(
        stockDeducted: const Value(true),
        printedAt: Value(DateTime.now()),
        status: job.status == JobStatus.quote
            ? const Value(JobStatus.inProduction)
            : const Value.absent(),
      ),
    );
    return PrintedResult(
      alreadyDeducted: false,
      deduction: result,
      filamentNames: {for (final f in rows) f.id: filamentLabel(f)},
    );
  });

  Stream<List<JobStatsEntry>> watchStatsEntries() {
    final jobsQuery = _db.select(_db.jobs);
    return jobsQuery.watch().asyncMap((jobs) async {
      final lines = await _db.select(_db.jobFilaments).get();
      final byJob = <int, List<JobFilamentRow>>{};
      for (final l in lines) {
        byJob.putIfAbsent(l.jobId, () => []).add(l);
      }
      return [
        for (final j in jobs)
          JobStatsEntry(
            id: j.id,
            name: j.name,
            status: j.status,
            quantity: j.quantity,
            priceCents: j.priceCents,
            profitCents: j.profitCents,
            date: j.printedAt ?? j.createdAt,
            filaments: [
              for (final l in byJob[j.id] ?? const <JobFilamentRow>[])
                (label: l.label, weightMg: l.weightMg),
            ],
          ),
      ];
    });
  }
}

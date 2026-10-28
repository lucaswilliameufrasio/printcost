import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/app_database.dart';
import '../data/repositories/catalog_repository.dart';
import '../data/repositories/job_repository.dart';
import '../domain/models/job_status.dart';
import '../domain/stats/dashboard_stats.dart';

/// Overridden in tests with an in-memory database.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.defaults();
  ref.onDispose(db.close);
  return db;
});

final catalogRepositoryProvider = Provider<CatalogRepository>(
  (ref) => CatalogRepository(ref.watch(databaseProvider)),
);

final jobRepositoryProvider = Provider<JobRepository>(
  (ref) => JobRepository(ref.watch(databaseProvider)),
);

final settingsProvider = StreamProvider<SettingsRow>(
  (ref) => ref.watch(catalogRepositoryProvider).watchSettings(),
);

final filamentsProvider = StreamProvider<List<FilamentRow>>(
  (ref) => ref.watch(catalogRepositoryProvider).watchFilaments(),
);

final printersProvider = StreamProvider<List<PrinterRow>>(
  (ref) => ref.watch(catalogRepositoryProvider).watchPrinters(),
);

final jobsProvider =
    StreamProvider.family<List<JobRow>, ({JobStatus? status, String search})>(
      (ref, filter) => ref
          .watch(jobRepositoryProvider)
          .watchJobs(status: filter.status, search: filter.search),
    );

final jobProvider = StreamProvider.family<JobWithFilaments?, int>(
  (ref, id) => ref.watch(jobRepositoryProvider).watchJob(id),
);

final dashboardStatsProvider = StreamProvider<DashboardStats>(
  (ref) => ref
      .watch(jobRepositoryProvider)
      .watchStatsEntries()
      .map(computeDashboardStats),
);

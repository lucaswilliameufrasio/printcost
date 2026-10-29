import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/db/app_database.dart';
import '../../domain/models/job_status.dart';
import '../../l10n/generated/app_localizations.dart';
import '../calculator/save_job_sheet.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../providers.dart';
import '../router.dart';
import 'export_csv.dart';
import 'quote_actions.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  JobStatus? _status;
  String _search = '';
  bool _selecting = false;
  final Set<int> _selected = {};

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    final jobsAsync = ref.watch(
      jobsProvider((status: _status, search: _search)),
    );
    final jobs = jobsAsync.value ?? const <JobRow>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selecting ? l.quoteSelectedCount(_selected.length) : l.navHistory,
        ),
        leading: _selecting
            ? IconButton(
                tooltip: l.cancel,
                icon: const Icon(Icons.close),
                onPressed: () => setState(() {
                  _selecting = false;
                  _selected.clear();
                }),
              )
            : null,
        actions: [
          if (!_selecting)
            IconButton(
              key: const Key('history.exportCsv'),
              tooltip: l.historyExportCsv,
              icon: const Icon(Icons.table_view_outlined),
              onPressed: () => exportHistoryCsv(context, ref),
            ),
          if (!_selecting)
            IconButton(
              tooltip: l.selectForQuote,
              icon: const Icon(Icons.picture_as_pdf_outlined),
              onPressed: () => setState(() => _selecting = true),
            ),
        ],
      ),
      floatingActionButton: _selecting && _selected.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () async {
                await shareQuotePdf(
                  context,
                  ref,
                  jobs.where((j) => _selected.contains(j.id)).toList(),
                );
                if (mounted) {
                  setState(() {
                    _selecting = false;
                    _selected.clear();
                  });
                }
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: Text(l.createQuote),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: SearchBar(
              hintText: l.historySearch,
              leading: const Icon(Icons.search),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: Text(l.filterAll),
                  selected: _status == null,
                  onSelected: (_) => setState(() => _status = null),
                ),
                for (final s in JobStatus.values)
                  ChoiceChip(
                    label: Text(statusLabel(l, s)),
                    selected: _status == s,
                    onSelected: (_) => setState(() => _status = s),
                  ),
              ],
            ),
          ),
          Expanded(
            child: AsyncView(
              value: jobsAsync,
              builder: (jobs) => jobs.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          l.historyEmpty,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 88),
                      itemCount: jobs.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final j = jobs[i];
                        final subtitle = [
                          if (j.customer != null) j.customer!,
                          fmt.date(j.createdAt),
                          statusLabel(l, j.status),
                        ].join(' · ');
                        return ListTile(
                          leading: _selecting
                              ? Checkbox(
                                  value: _selected.contains(j.id),
                                  onChanged: (_) => _toggle(j.id),
                                )
                              : JobThumb(photoPath: j.photoPath),
                          title: Text(j.name),
                          subtitle: Text(subtitle),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(fmt.money(j.priceCents * j.quantity)),
                              if (j.quantity > 1)
                                Text(
                                  l.quantityUnits(j.quantity),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                            ],
                          ),
                          onTap: _selecting
                              ? () => _toggle(j.id)
                              : () => context.go(Routes.job(j.id)),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggle(int id) => setState(() {
    if (!_selected.remove(id)) _selected.add(id);
  });
}

class JobThumb extends StatelessWidget {
  const JobThumb({required this.photoPath, this.size = 48, super.key});
  final String? photoPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final path = photoPath;
    if (path != null && File(path).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(path),
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return CircleAvatar(radius: size / 2, child: const Icon(Icons.view_in_ar));
  }
}

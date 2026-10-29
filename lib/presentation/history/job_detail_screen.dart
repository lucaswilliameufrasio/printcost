import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/job_repository.dart';
import '../../domain/models/job_status.dart';
import '../../domain/stock/stock_deduction.dart';
import '../../l10n/generated/app_localizations.dart';
import '../calculator/calculator_prefill.dart';
import '../calculator/save_job_sheet.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../providers.dart';
import '../router.dart';
import 'history_screen.dart';
import 'quote_actions.dart';

/// Shows stock warnings after a part is marked as printed.
Future<void> showStockResult(
  BuildContext context,
  PrintedResult result,
  Formatters fmt,
) async {
  final l = AppLocalizations.of(context);
  if (result.alreadyDeducted) {
    showSnack(context, l.stockAlreadyDeducted);
    return;
  }
  final warnings = result.deduction?.warnings ?? const <StockWarning>[];
  if (warnings.isEmpty) {
    showSnack(context, l.stockUpdated);
    return;
  }
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.warning_amber),
      title: Text(l.stockUpdated),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final w in warnings)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(switch (w.kind) {
                StockWarningKind.low => l.lowStockWarning(
                  result.filamentNames[w.filamentId] ?? '?',
                  fmt.weight(w.remainingMg),
                ),
                StockWarningKind.insufficient => l.insufficientStockWarning(
                  result.filamentNames[w.filamentId] ?? '?',
                ),
              }),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l.ok),
        ),
      ],
    ),
  );
}

class JobDetailScreen extends ConsumerWidget {
  const JobDetailScreen({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    final repo = ref.read(jobRepositoryProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.jobDetails)),
      body: AsyncView(
        value: ref.watch(jobProvider(id)),
        builder: (data) {
          if (data == null) return const SizedBox();
          final j = data.job;
          final theme = Theme.of(context);
          Widget row(String label, String value, {Key? key}) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(child: Text(label)),
                Text(value, key: key, style: theme.textTheme.titleSmall),
              ],
            ),
          );
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  JobThumb(photoPath: j.photoPath, size: 72),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(j.name, style: theme.textTheme.titleLarge),
                        if (j.customer != null) Text(j.customer!),
                        Text(
                          j.printedAt != null
                              ? l.printedOn(fmt.date(j.printedAt!))
                              : l.createdOn(fmt.date(j.createdAt)),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SegmentedButton<JobStatus>(
                showSelectedIcon: false,
                segments: [
                  for (final s in JobStatus.values)
                    ButtonSegment(value: s, label: Text(statusLabel(l, s))),
                ],
                selected: {j.status},
                onSelectionChanged: (v) => repo.setStatus(id, v.first),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      row(l.unitPrice, fmt.money(j.priceCents)),
                      row(l.unitCost, fmt.money(j.costCents)),
                      row(l.unitProfit, fmt.money(j.profitCents)),
                      row(l.jobQuantity, '${j.quantity}'),
                      if (j.channelName case final channel?)
                        row(l.csvChannel, channel),
                      const Divider(),
                      row(
                        l.totalLabel,
                        fmt.money(j.priceCents * j.quantity),
                        key: const Key('job.total'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      for (final f in data.filaments)
                        row(f.label, fmt.weight(f.weightMg)),
                      row(l.printTimeLabel, fmt.duration(j.printSeconds)),
                      if (j.printerName != null)
                        row(l.calcPrinter, j.printerName!),
                      if (j.sourceFile != null)
                        row(l.sourceFileLabel, j.sourceFile!),
                    ],
                  ),
                ),
              ),
              if (j.notes != null) ...[
                const SizedBox(height: 16),
                Text(j.notes!),
              ],
              const SizedBox(height: 24),
              if (!j.stockDeducted)
                FilledButton.icon(
                  key: const Key('job.markPrinted'),
                  onPressed: () async {
                    final r = await repo.markPrinted(id);
                    if (context.mounted) await showStockResult(context, r, fmt);
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(l.markPrinted),
                )
              else
                Chip(
                  avatar: const Icon(Icons.check_circle),
                  label: Text(l.printedBadge),
                ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  ref
                      .read(calculatorPrefillProvider.notifier)
                      .set(CalculatorPrefill(job: data));
                  context.go(Routes.calculator);
                },
                icon: const Icon(Icons.calculate_outlined),
                label: Text(l.openInCalculator),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => shareQuotePdf(context, ref, [j]),
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: Text(l.generatePdf),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () async {
                  if (!await confirm(
                    context,
                    message: l.deleteJobConfirm,
                    action: l.delete,
                  )) {
                    return;
                  }
                  await repo.deleteJob(id);
                  if (context.mounted) context.go(Routes.history);
                },
                icon: const Icon(Icons.delete_outline),
                label: Text(l.delete),
              ),
            ],
          );
        },
      ),
    );
  }
}

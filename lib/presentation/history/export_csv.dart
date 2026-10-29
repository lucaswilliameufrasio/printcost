import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/scaled_decimal.dart';
import '../../data/export/csv.dart';
import '../../l10n/generated/app_localizations.dart';
import '../calculator/save_job_sheet.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../common/share.dart';
import '../providers.dart';

/// Shares the whole history as a spreadsheet. Money columns are plain
/// numbers in the user's decimal format, so the spreadsheet can sum them.
Future<void> exportHistoryCsv(BuildContext context, WidgetRef ref) async {
  final l = AppLocalizations.of(context);
  final fmt = Formatters.of(context, ref);
  final jobs = await ref.read(jobRepositoryProvider).allJobs();
  if (!context.mounted) return;
  if (jobs.isEmpty) {
    showSnack(context, l.historyExportEmpty);
    return;
  }
  final sep = fmt.decimalSeparator;
  String number(int value, int scale) =>
      formatScaled(value, scale: scale, decimalSeparator: sep);

  final rows = <List<String>>[
    [
      l.csvDate,
      l.csvName,
      l.csvCustomer,
      l.csvStatus,
      l.csvQuantity,
      l.csvChannel,
      l.csvUnitPrice,
      l.csvUnitCost,
      l.csvUnitProfit,
      l.csvTotalPrice,
      l.csvTotalProfit,
      l.csvFilamentGrams,
    ],
    for (final w in jobs)
      [
        fmt.date(w.job.printedAt ?? w.job.createdAt),
        csvText(w.job.name),
        csvText(w.job.customer ?? ''),
        statusLabel(l, w.job.status),
        '${w.job.quantity}',
        csvText(w.job.channelName ?? ''),
        number(w.job.priceCents, Scales.money),
        number(w.job.costCents, Scales.money),
        number(w.job.profitCents, Scales.money),
        number(w.job.priceCents * w.job.quantity, Scales.money),
        number(w.job.profitCents * w.job.quantity, Scales.money),
        number(
          w.filaments.fold(0, (s, f) => s + f.weightMg) * w.job.quantity,
          Scales.grams,
        ),
      ],
  ];
  try {
    await shareBytes(
      encodeCsv(rows, separator: sep == ',' ? ';' : ','),
      fileName: '${l.appTitle}-${l.csvFileName}.csv',
      mimeType: 'text/csv',
    );
  } on Exception catch (e) {
    if (context.mounted) showSnack(context, l.unexpectedError('$e'));
  }
}

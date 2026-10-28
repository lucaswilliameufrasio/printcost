import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

import '../../data/db/app_database.dart';
import '../../domain/printer/printer_status.dart';
import '../../l10n/generated/app_localizations.dart';
import '../calculator/calculator_prefill.dart';
import '../common/async_view.dart';
import '../router.dart';
import '../slicer/import_slice.dart';
import 'printer_list_screen.dart';
import 'printer_module.dart';
import 'printer_session.dart';
import 'printer_status_card.dart';

class PrinterMonitorScreen extends ConsumerWidget {
  const PrinterMonitorScreen({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final connections = ref.watch(printerConnectionsProvider).value ?? const [];
    final connection = connections.where((c) => c.id == id).firstOrNull;
    if (connection == null) {
      return Scaffold(appBar: AppBar(title: Text(l.pmTitle)));
    }
    final session = ref.watch(printerSessionProvider(id));
    final status = session.status;
    return Scaffold(
      appBar: AppBar(
        title: Text(connection.name),
        actions: [
          IconButton(
            tooltip: l.pmDebugTitle,
            icon: const Icon(Icons.bug_report_outlined),
            onPressed: () => context.go(PrinterRoutes.debug(id)),
          ),
          IconButton(
            tooltip: l.delete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              if (!await confirm(
                context,
                message: l.pmDeleteConfirm,
                action: l.delete,
              )) {
                return;
              }
              await ref.read(printerConnectionRepositoryProvider).delete(id);
              if (context.mounted) context.go(PrinterRoutes.list);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          PrinterStatusCard(connection: connection),
          const SizedBox(height: 12),
          if (session.connection is PrinterConnectionFailed ||
              session.connection is PrinterDisconnected)
            OutlinedButton.icon(
              onPressed: () =>
                  ref.read(printerSessionProvider(id).notifier).connect(),
              icon: const Icon(Icons.refresh),
              label: Text(l.pmReconnect),
            ),
          if (status.state == PrintState.finished)
            FilledButton.icon(
              key: const Key('printer.register'),
              onPressed: () => _register(context, ref, connection, session),
              icon: const Icon(Icons.add_task),
              label: Text(l.pmRegisterPrint),
            ),
          const SizedBox(height: 12),
          Text(
            l.pmForegroundNote,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          const RemoteAccessTip(),
        ],
      ),
    );
  }

  Future<void> _register(
    BuildContext context,
    WidgetRef ref,
    PrinterConnectionRow connection,
    PrinterSessionState session,
  ) async {
    final l = AppLocalizations.of(context);
    final use3mf = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.pmRegisterPrint),
        content: Text('${l.pmRegisterText}\n\n${l.pmRegisterNoFetch}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l.pmOnlyTime),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l.pmChoose3mf),
          ),
        ],
      ),
    );
    if (use3mf == null || !context.mounted) return;
    if (use3mf) {
      await importSliceFile(context, ref, printerId: connection.printerId);
      return;
    }
    final s = session.lastFinished ?? session.status;
    final file = s.fileName == null ? null : p.basename(s.fileName!);
    ref
        .read(calculatorPrefillProvider.notifier)
        .set(
          CalculatorPrefill(
            printSeconds: session.lastEstimatedTotalSeconds,
            sourceFile: file,
            suggestedName: s.taskName ?? file,
            printerId: connection.printerId,
          ),
        );
    context.go(Routes.calculator);
  }
}

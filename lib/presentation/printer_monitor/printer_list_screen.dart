import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import 'printer_module.dart';
import 'printer_session.dart';
import 'printer_status_card.dart';

class PrinterListScreen extends ConsumerWidget {
  const PrinterListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.pmTitle)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('printers.add'),
        onPressed: () => context.go(PrinterRoutes.setup),
        icon: const Icon(Icons.add),
        label: Text(l.pmAdd),
      ),
      body: AsyncView(
        value: ref.watch(printerConnectionsProvider),
        builder: (connections) => ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
          children: [
            if (connections.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l.pmEmpty, textAlign: TextAlign.center),
              ),
            for (final c in connections) ...[
              PrinterStatusCard(
                connection: c,
                onTap: () => context.go(PrinterRoutes.monitor(c.id)),
              ),
              const SizedBox(height: 12),
            ],
            const RemoteAccessTip(),
          ],
        ),
      ),
    );
  }
}

class RemoteAccessTip extends StatelessWidget {
  const RemoteAccessTip({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Card(
      child: ExpansionTile(
        leading: const Icon(Icons.vpn_lock_outlined),
        title: Text(l.pmRemoteTitle),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [Text(l.pmRemoteText)],
      ),
    );
  }
}

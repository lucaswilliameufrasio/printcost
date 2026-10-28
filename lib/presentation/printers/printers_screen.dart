import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/money/ratio.dart';
import '../../data/db/app_database.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../providers.dart';
import '../router.dart';

int wearPerHourCents(PrinterRow p) =>
    (p.lifespanHours == 0
            ? Ratio.zero
            : Ratio.of(p.machineValueCents, p.lifespanHours))
        .roundHalfUp() +
    p.maintenancePerHourCents;

class PrintersScreen extends ConsumerWidget {
  const PrintersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    return Scaffold(
      appBar: AppBar(title: Text(l.printers)),
      floatingActionButton: FloatingActionButton(
        tooltip: l.newPrinter,
        onPressed: () => context.go(Routes.newPrinter),
        child: const Icon(Icons.add),
      ),
      body: AsyncView(
        value: ref.watch(printersProvider),
        builder: (printers) => printers.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(l.noPrinters, textAlign: TextAlign.center),
                ),
              )
            : ListView.separated(
                itemCount: printers.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final p = printers[i];
                  return ListTile(
                    leading: const Icon(Icons.print_outlined),
                    title: Text(p.name),
                    subtitle: Text(
                      '${p.powerWatts} W · '
                      '${l.wearPerHour(fmt.money(wearPerHourCents(p)))}',
                    ),
                    onTap: () => context.go(Routes.printer(p.id)),
                  );
                },
              ),
      ),
    );
  }
}

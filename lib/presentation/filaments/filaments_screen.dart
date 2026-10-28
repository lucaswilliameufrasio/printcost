import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/money/ratio.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../providers.dart';
import '../router.dart';

class FilamentsScreen extends ConsumerWidget {
  const FilamentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    return Scaffold(
      appBar: AppBar(title: Text(l.filaments)),
      floatingActionButton: FloatingActionButton(
        tooltip: l.newFilament,
        onPressed: () => context.go(Routes.newFilament),
        child: const Icon(Icons.add),
      ),
      body: AsyncView(
        value: ref.watch(filamentsProvider),
        builder: (filaments) {
          if (filaments.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(l.noFilaments, textAlign: TextAlign.center),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 88),
            itemCount: filaments.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final f = filaments[i];
              final low = f.stockMg <= f.lowStockAlertMg;
              final perKg = f.rollWeightGrams == 0
                  ? 0
                  : Ratio.of(
                      f.rollPriceCents * 1000,
                      f.rollWeightGrams,
                    ).roundHalfUp();
              final progress = f.rollWeightGrams == 0
                  ? 0.0
                  : (f.stockMg / (f.rollWeightGrams * 1000)).clamp(0.0, 1.0);
              return ListTile(
                leading: ColorDot(argb: f.colorArgb),
                title: Text(
                  [
                    f.material,
                    f.brand,
                    f.colorName,
                  ].where((s) => s.isNotEmpty).join(' · '),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${l.stockLeft(fmt.weight(f.stockMg))} · '
                      '${l.pricePerKg(fmt.money(perKg))}',
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(value: progress),
                  ],
                ),
                trailing: low
                    ? Chip(
                        avatar: const Icon(Icons.warning_amber, size: 18),
                        label: Text(l.lowStockBadge),
                      )
                    : null,
                onTap: () => context.go(Routes.filament(f.id)),
              );
            },
          );
        },
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({required this.argb, this.size = 32, super.key});
  final int? argb;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: argb == null ? null : Color(argb!),
        border: Border.all(color: scheme.outline),
      ),
      child: argb == null
          ? Icon(Icons.circle_outlined, size: size * 0.6, color: scheme.outline)
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import '../router.dart';

/// Entries contributed by optional modules (shown only when enabled).
class MoreEntry {
  const MoreEntry({
    required this.icon,
    required this.title,
    required this.route,
    this.subtitle,
  });
  final IconData icon;
  final String Function(BuildContext) title;
  final String Function(BuildContext)? subtitle;
  final String route;
}

final extraMoreEntriesProvider = Provider<List<MoreEntry>>((ref) => const []);

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final extra = ref.watch(extraMoreEntriesProvider);
    Widget tile(IconData icon, String title, String route) => ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go(route),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l.navMore)),
      body: ListView(
        children: [
          tile(Icons.album_outlined, l.filaments, Routes.filaments),
          tile(Icons.print_outlined, l.printers, Routes.printers),
          tile(Icons.storefront_outlined, l.channels, Routes.channels),
          for (final e in extra)
            ListTile(
              leading: Icon(e.icon),
              title: Text(e.title(context)),
              subtitle: e.subtitle == null ? null : Text(e.subtitle!(context)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(e.route),
            ),
          tile(Icons.settings_outlined, l.settings, Routes.settings),
          tile(Icons.backup_outlined, l.backup, Routes.backup),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l.about),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: l.appTitle,
              applicationVersion: '0.1.0',
              children: [Text(l.aboutText)],
            ),
          ),
        ],
      ),
    );
  }
}

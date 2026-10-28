import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:go_router/go_router.dart';

import '../../app.dart';
import '../../l10n/generated/app_localizations.dart';
import '../more/more_screen.dart';
import '../providers.dart';
import '../router.dart';
import 'printer_debug_screen.dart';
import 'printer_list_screen.dart';
import 'printer_monitor_screen.dart';
import 'printer_session.dart';
import 'setup_wizard_screen.dart';

abstract final class PrinterRoutes {
  static const list = '${Routes.more}/printer-monitor';
  static const setup = '$list/setup';
  static String monitor(int id) => '$list/$id';
  static String debug(int id) => '$list/$id/debug';
}

final _routes = <RouteBase>[
  GoRoute(
    path: 'printer-monitor',
    builder: (_, _) => const PrinterListScreen(),
    routes: [
      GoRoute(path: 'setup', builder: (_, _) => const SetupWizardScreen()),
      GoRoute(
        path: ':id',
        builder: (_, state) =>
            PrinterMonitorScreen(id: int.parse(state.pathParameters['id']!)),
        routes: [
          GoRoute(
            path: 'debug',
            builder: (_, state) =>
                PrinterDebugScreen(id: int.parse(state.pathParameters['id']!)),
          ),
        ],
      ),
    ],
  ),
];

/// Optional printer module, behind the "printerModuleEnabled" setting
/// (off by default). Routes are always registered; the menu entry and the
/// live connections exist only while the flag is on.
List<Override> printerModuleOverrides() => [
  extraMoreRoutesProvider.overrideWithValue(_routes),
  extraMoreEntriesProvider.overrideWith((ref) {
    final enabled =
        ref.watch(settingsProvider).value?.printerModuleEnabled ?? false;
    if (!enabled) return const [];
    return [
      MoreEntry(
        icon: Icons.sensors,
        title: (c) => AppLocalizations.of(c).pmTitle,
        subtitle: (c) => AppLocalizations.of(c).pmSubtitle,
        route: PrinterRoutes.list,
      ),
    ];
  }),
  appBackgroundWatcherProvider.overrideWith(
    (ref) => ref.watch(printerBackgroundWatcherProvider),
  ),
];

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../l10n/generated/app_localizations.dart';
import 'backup/backup_screen.dart';
import 'calculator/calculator_screen.dart';
import 'channels/channel_form_screen.dart';
import 'channels/channels_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'filaments/filament_form_screen.dart';
import 'filaments/filaments_screen.dart';
import 'history/history_screen.dart';
import 'history/job_detail_screen.dart';
import 'more/more_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'printers/printer_form_screen.dart';
import 'printers/printers_screen.dart';
import 'providers.dart';
import 'settings/settings_screen.dart';

abstract final class Routes {
  static const calculator = '/calculator';
  static const history = '/history';
  static String job(int id) => '/history/$id';
  static const dashboard = '/dashboard';
  static const more = '/more';
  static const filaments = '/more/filaments';
  static const newFilament = '/more/filaments/new';
  static String filament(int id) => '/more/filaments/$id';
  static const printers = '/more/printers';
  static const newPrinter = '/more/printers/new';
  static String printer(int id) => '/more/printers/$id';
  static const channels = '/more/channels';
  static const newChannel = '/more/channels/new';
  static String channel(int id) => '/more/channels/$id';

  /// Channel form that goes back to [back] after saving.
  static String channelThen(int id, String back) =>
      Uri(path: channel(id), queryParameters: {'back': back}).toString();
  static const settings = '/more/settings';
  static const welcome = '/welcome';

  /// New filament form that goes back to [back] after saving.
  static String newFilamentThen(String back) =>
      Uri(path: newFilament, queryParameters: {'back': back}).toString();
  static const backup = '/more/backup';
}

/// Extra routes contributed by optional modules (printer monitor).
final extraMoreRoutesProvider = Provider<List<RouteBase>>((ref) => const []);

final routerProvider = Provider<GoRouter>((ref) {
  final extra = ref.watch(extraMoreRoutesProvider);
  // First-run setup: null while settings load.
  final onboardingDone = ValueNotifier<bool?>(null);
  ref
    ..listen(
      settingsProvider,
      (_, next) => onboardingDone.value = next.value?.onboardingDone,
      fireImmediately: true,
    )
    ..onDispose(onboardingDone.dispose);
  final router = GoRouter(
    initialLocation: Routes.calculator,
    refreshListenable: onboardingDone,
    redirect: (context, state) {
      final done = onboardingDone.value;
      if (done == null) return null;
      final atWelcome = state.matchedLocation == Routes.welcome;
      if (!done && !atWelcome) return Routes.welcome;
      if (done && atWelcome) return Routes.calculator;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.welcome,
        builder: (_, _) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _Shell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.calculator,
                builder: (_, _) => const CalculatorScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.history,
                builder: (_, _) => const HistoryScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, state) => JobDetailScreen(
                      id: int.parse(state.pathParameters['id']!),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.dashboard,
                builder: (_, _) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.more,
                builder: (_, _) => const MoreScreen(),
                routes: [
                  GoRoute(
                    path: 'filaments',
                    builder: (_, _) => const FilamentsScreen(),
                    routes: [
                      GoRoute(
                        path: 'new',
                        builder: (_, state) => FilamentFormScreen(
                          backTo: state.uri.queryParameters['back'],
                        ),
                      ),
                      GoRoute(
                        path: ':id',
                        builder: (_, state) => FilamentFormScreen(
                          id: int.parse(state.pathParameters['id']!),
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'printers',
                    builder: (_, _) => const PrintersScreen(),
                    routes: [
                      GoRoute(
                        path: 'new',
                        builder: (_, _) => const PrinterFormScreen(),
                      ),
                      GoRoute(
                        path: ':id',
                        builder: (_, state) => PrinterFormScreen(
                          id: int.parse(state.pathParameters['id']!),
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'channels',
                    builder: (_, _) => const ChannelsScreen(),
                    routes: [
                      GoRoute(
                        path: 'new',
                        builder: (_, _) => const ChannelFormScreen(),
                      ),
                      GoRoute(
                        path: ':id',
                        builder: (_, state) => ChannelFormScreen(
                          id: int.parse(state.pathParameters['id']!),
                          backTo: state.uri.queryParameters['back'],
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (_, _) => const SettingsScreen(),
                  ),
                  GoRoute(
                    path: 'backup',
                    builder: (_, _) => const BackupScreen(),
                  ),
                  ...extra,
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

class _Shell extends StatelessWidget {
  const _Shell({required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.calculate_outlined),
            selectedIcon: const Icon(Icons.calculate),
            label: l.navCalculator,
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            selectedIcon: const Icon(Icons.receipt_long),
            label: l.navHistory,
          ),
          NavigationDestination(
            icon: const Icon(Icons.insights_outlined),
            selectedIcon: const Icon(Icons.insights),
            label: l.navDashboard,
          ),
          NavigationDestination(icon: const Icon(Icons.menu), label: l.navMore),
        ],
      ),
    );
  }
}

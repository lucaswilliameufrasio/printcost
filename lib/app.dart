import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/generated/app_localizations.dart';
import 'presentation/providers.dart';
import 'presentation/router.dart';
import 'presentation/theme.dart';

/// Hook for optional modules that need to run while the app is open
/// (e.g. the printer monitor). Overridden by the module.
final appBackgroundWatcherProvider = Provider<void>((ref) {});

class PrintCostApp extends ConsumerWidget {
  const PrintCostApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appBackgroundWatcherProvider);
    final settings = ref.watch(settingsProvider).value;
    final router = ref.watch(routerProvider);
    final localeCode = settings?.localeCode;
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: themeModeFromName(settings?.themeMode),
      locale: localeCode == null ? null : Locale(localeCode),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // English only for English devices; Portuguese for everything else.
      localeListResolutionCallback: (locales, supported) {
        if (localeCode != null) return Locale(localeCode);
        final first = locales?.firstOrNull;
        return first?.languageCode == 'en'
            ? const Locale('en')
            : const Locale('pt', 'BR');
      },
      routerConfig: router,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';

import 'app.dart';
import 'presentation/printer_monitor/printer_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(
    ProviderScope(
      overrides: printerModuleOverrides(),
      child: const PrintCostApp(),
    ),
  );
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import 'printer_session.dart';

/// Raw MQTT reports, to check field names against a real printer.
class PrinterDebugScreen extends ConsumerWidget {
  const PrinterDebugScreen({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final session = ref.watch(printerSessionProvider(id));
    const encoder = JsonEncoder.withIndent('  ');
    final merged = encoder.convert(session.merged);
    final mono = Theme.of(context).textTheme.bodySmall
        ?.copyWith(fontFamily: 'monospace');
    Future<void> copy(String text) async {
      await Clipboard.setData(ClipboardData(text: text));
      if (context.mounted) showSnack(context, l.pmCopied);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.pmDebugTitle)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(l.pmDebugHelp),
          const SizedBox(height: 12),
          Card(
            child: ExpansionTile(
              title: Text(l.pmMergedState),
              trailing: IconButton(
                tooltip: l.pmCopy,
                icon: const Icon(Icons.copy),
                onPressed: () => copy(merged),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SelectableText(merged, style: mono),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (session.rawLog.isEmpty) Text(l.pmDebugEmpty),
          for (final raw in session.rawLog)
            Card(
              child: ListTile(
                title: SelectableText(
                  raw.length > 600 ? '${raw.substring(0, 600)}…' : raw,
                  style: mono,
                ),
                trailing: IconButton(
                  tooltip: l.pmCopy,
                  icon: const Icon(Icons.copy),
                  onPressed: () => copy(raw),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

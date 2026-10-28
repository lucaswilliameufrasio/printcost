import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../domain/printer/printer_status.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/formatters.dart';
import 'printer_labels.dart';
import 'printer_session.dart';

class PrinterStatusCard extends ConsumerWidget {
  const PrinterStatusCard({required this.connection, this.onTap, super.key});
  final PrinterConnectionRow connection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    final theme = Theme.of(context);
    final session = ref.watch(printerSessionProvider(connection.id));
    final s = session.status;
    final conn = session.connection;

    final (IconData icon, Color color) = switch (s.state) {
      PrintState.printing ||
      PrintState.preparing => (Icons.print, theme.colorScheme.primary),
      PrintState.paused => (Icons.pause_circle, theme.colorScheme.tertiary),
      PrintState.finished => (Icons.check_circle, theme.colorScheme.primary),
      PrintState.failed => (Icons.error, theme.colorScheme.error),
      _ => (Icons.print_outlined, theme.colorScheme.outline),
    };

    final connectionText = switch (conn) {
      PrinterConnecting() => l.pmConnecting,
      PrinterConnected() => l.pmConnected,
      PrinterDisconnected() => l.pmDisconnected,
      PrinterConnectionFailed(:final error, :final detail) =>
        connectionErrorMessage(l, error, host: connection.host, detail: detail),
    };

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          connection.name,
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          printStateLabel(l, s.state),
                          key: Key('printer.state.${connection.id}'),
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (s.progressPercent != null && s.isActive)
                    Text(
                      '${s.progressPercent}%',
                      style: theme.textTheme.headlineSmall,
                    ),
                ],
              ),
              if (s.isActive && s.progressPercent != null) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: s.progressPercent! / 100,
                  borderRadius: BorderRadius.circular(4),
                ),
                if (s.remainingMinutes != null) ...[
                  const SizedBox(height: 4),
                  Text(l.pmRemaining(fmt.duration(s.remainingMinutes! * 60))),
                ],
              ],
              if (s.taskName != null || s.fileName != null) ...[
                const SizedBox(height: 8),
                Text(
                  l.pmFile(s.taskName ?? s.fileName!),
                  style: theme.textTheme.bodySmall,
                ),
              ],
              if (s.errorCode != null && s.state == PrintState.failed)
                Text(
                  l.pmErrorCode(s.errorCode!.toRadixString(16).toUpperCase()),
                  style: theme.textTheme.bodySmall,
                ),
              const SizedBox(height: 8),
              Text(
                connectionText,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: conn is PrinterConnectionFailed
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

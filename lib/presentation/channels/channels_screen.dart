import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../providers.dart';
import '../router.dart';
import 'channel_labels.dart';

class ChannelsScreen extends ConsumerWidget {
  const ChannelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.channels)),
      floatingActionButton: FloatingActionButton(
        tooltip: l.channelNew,
        onPressed: () => context.go(Routes.newChannel),
        child: const Icon(Icons.add),
      ),
      body: AsyncView(
        value: ref.watch(channelsProvider),
        builder: (channels) => ListView.separated(
          padding: const EdgeInsets.only(bottom: 88),
          itemCount: channels.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final c = channels[i];
            return ListTile(
              leading: const Icon(Icons.storefront_outlined),
              title: Text(c.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tiersSummary(l, fmt, c.tiers)),
                  if (c.isExample)
                    Text(
                      l.channelExampleBadge,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.tertiary,
                      ),
                    ),
                ],
              ),
              isThreeLine: c.tiers.length > 1 || c.isExample,
              onTap: () => context.go(Routes.channel(c.id)),
            );
          },
        ),
      ),
    );
  }
}

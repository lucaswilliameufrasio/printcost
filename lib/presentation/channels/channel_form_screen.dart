import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format/scaled_decimal.dart';
import '../../data/db/app_database.dart';
import '../../domain/pricing/cost_calculator.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../common/help_button.dart';
import '../common/links.dart';
import '../common/number_field.dart';
import '../providers.dart';

class _TierFields {
  _TierFields({String from = '0', String percent = '0', String fixed = '0'})
    : from = TextEditingController(text: from),
      percent = TextEditingController(text: percent),
      fixed = TextEditingController(text: fixed);

  final TextEditingController from;
  final TextEditingController percent;
  final TextEditingController fixed;

  void dispose() {
    from.dispose();
    percent.dispose();
    fixed.dispose();
  }
}

class ChannelFormScreen extends ConsumerStatefulWidget {
  const ChannelFormScreen({this.id, this.backTo, super.key});
  final int? id;

  /// Where to go after saving, when opened from another tab.
  final String? backTo;

  @override
  ConsumerState<ChannelFormScreen> createState() => _ChannelFormState();
}

class _ChannelFormState extends ConsumerState<ChannelFormScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _infoUrl = TextEditingController();
  List<_TierFields> _tiers = [_TierFields()];
  bool _isExample = false;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = widget.id;
    if (id != null) {
      final c = await ref.read(catalogRepositoryProvider).channel(id);
      if (!mounted) return;
      if (c != null) {
        final fmt = Formatters.of(context, ref);
        _name.text = c.name;
        _infoUrl.text = c.infoUrl ?? '';
        _isExample = c.isExample;
        for (final t in _tiers) {
          t.dispose();
        }
        _tiers = [
          for (final t in normalizeTiers(c.tiers))
            _TierFields(
              from: fmt.inputMoney(t.minPriceCents),
              percent: fmt.input(t.feeBp, Scales.percent),
              fixed: fmt.inputMoney(t.fixedCents),
            ),
        ];
      }
    }
    setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _name.dispose();
    _infoUrl.dispose();
    for (final t in _tiers) {
      t.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    final tiers = [
      for (final (i, t) in _tiers.indexed)
        FeeTier(
          minPriceCents: i == 0 ? 0 : fmt.parse(t.from.text, Scales.money)!,
          feeBp: fmt.parse(t.percent.text, Scales.percent) ?? 0,
          fixedCents: fmt.parse(t.fixed.text, Scales.money) ?? 0,
        ),
    ];
    final mins = tiers.map((t) => t.minPriceCents).toSet();
    if (mins.length != tiers.length) {
      showSnack(context, l.channelDuplicateMin);
      return;
    }
    await ref
        .read(catalogRepositoryProvider)
        .saveChannel(
          SalesChannelsCompanion(
            id: widget.id == null ? const Value.absent() : Value(widget.id!),
            name: Value(_name.text.trim()),
            infoUrl: Value(
              _infoUrl.text.trim().isEmpty ? null : _infoUrl.text.trim(),
            ),
            tiers: Value(normalizeTiers(tiers)),
            // Saving means the user reviewed the fees.
            isExample: const Value(false),
          ),
        );
    if (!mounted) return;
    final back = widget.backTo;
    if (back != null && back.startsWith('/')) {
      context.go(back);
    } else {
      context.pop();
    }
  }

  Future<void> _archive() async {
    final l = AppLocalizations.of(context);
    final channels = ref.read(channelsProvider).value ?? const [];
    if (channels.length <= 1) {
      showSnack(context, l.channelKeepOne);
      return;
    }
    if (!await confirm(
      context,
      message: l.archiveChannelConfirm,
      action: l.archive,
    )) {
      return;
    }
    await ref.read(catalogRepositoryProvider).archiveChannel(widget.id!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    final theme = Theme.of(context);
    const gap = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? l.channelNew : l.channelEdit),
        actions: [
          if (widget.id != null)
            IconButton(
              tooltip: l.archive,
              icon: const Icon(Icons.archive_outlined),
              onPressed: _archive,
            ),
        ],
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_isExample) ...[
                    Card(
                      color: theme.colorScheme.tertiaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: theme.colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l.channelExampleWarning,
                                    key: const Key('channel.exampleWarning'),
                                    style: TextStyle(
                                      color:
                                          theme.colorScheme.onTertiaryContainer,
                                    ),
                                  ),
                                  if (isWebLink(_infoUrl.text)) ...[
                                    const SizedBox(height: 12),
                                    FilledButton.tonalIcon(
                                      key: const Key('channel.officialFees'),
                                      onPressed: () =>
                                          openLink(context, _infoUrl.text),
                                      icon: const Icon(Icons.open_in_new),
                                      label: Text(l.channelOfficialFees),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    gap,
                  ],
                  TextFormField(
                    key: const Key('channel.name'),
                    controller: _name,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l.channelName,
                      suffixIcon: HelpButton(
                        title: l.channelName,
                        text: l.helpChannelName,
                      ),
                    ),
                    validator: (v) =>
                        (v ?? '').trim().isEmpty ? l.requiredField : null,
                  ),
                  gap,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l.channelTiers,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      HelpButton(
                        title: l.channelTiers,
                        text: l.helpChannelTiers,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  for (final (i, t) in _tiers.indexed) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: i == 0
                                      ? Text(
                                          '${l.channelTierFrom} '
                                          '${fmt.money(0)}',
                                          style: theme.textTheme.titleSmall,
                                        )
                                      : NumberField(
                                          fieldKey: Key('channel.from.$i'),
                                          controller: t.from,
                                          label: l.channelTierFrom,
                                          prefix: fmt.currencySymbol,
                                          positive: true,
                                          parse: (s) =>
                                              fmt.parse(s, Scales.money),
                                        ),
                                ),
                                if (i > 0)
                                  IconButton(
                                    tooltip: l.delete,
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                    onPressed: () => setState(
                                      () => _tiers.removeAt(i).dispose(),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: NumberField(
                                      fieldKey: Key('channel.percent.$i'),
                                      controller: t.percent,
                                      label: l.channelTierPercent,
                                      help: l.helpChannelPercent,
                                      suffix: '%',
                                      parse: (s) =>
                                          fmt.parse(s, Scales.percent),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: NumberField(
                                      fieldKey: Key('channel.fixed.$i'),
                                      controller: t.fixed,
                                      label: l.channelTierFixed,
                                      help: l.helpChannelFixed,
                                      prefix: fmt.currencySymbol,
                                      parse: (s) => fmt.parse(s, Scales.money),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          setState(() => _tiers.add(_TierFields(from: ''))),
                      icon: const Icon(Icons.add),
                      label: Text(l.channelAddTier),
                    ),
                  ),
                  gap,
                  TextFormField(
                    key: const Key('channel.infoUrl'),
                    controller: _infoUrl,
                    keyboardType: TextInputType.url,
                    autocorrect: false,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: l.channelInfoUrl,
                      hintText: 'https://',
                      suffixIcon: HelpButton(
                        title: l.channelInfoUrl,
                        text: l.helpChannelInfoUrl,
                      ),
                    ),
                    validator: (v) {
                      final text = (v ?? '').trim();
                      if (text.isEmpty || isWebLink(text)) return null;
                      return l.channelInfoUrlInvalid;
                    },
                  ),
                  if (!_isExample && isWebLink(_infoUrl.text))
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => openLink(context, _infoUrl.text),
                        icon: const Icon(Icons.open_in_new),
                        label: Text(l.channelOfficialFees),
                      ),
                    ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    key: const Key('channel.save'),
                    onPressed: _save,
                    icon: const Icon(Icons.check),
                    label: Text(l.save),
                  ),
                ],
              ),
            ),
    );
  }
}

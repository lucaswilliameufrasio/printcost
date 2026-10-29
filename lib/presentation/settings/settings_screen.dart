import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format/scaled_decimal.dart';
import '../../data/db/app_database.dart';
import '../../domain/pricing/price_rounding.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../common/help_button.dart';
import '../common/number_field.dart';
import '../providers.dart';
import '../router.dart';

String roundingLabel(AppLocalizations l, PriceRounding r) => switch (r) {
  PriceRounding.none => l.roundingNone,
  PriceRounding.endsIn90 => l.rounding90,
  PriceRounding.endsIn99 => l.rounding99,
  PriceRounding.halfUnit => l.roundingHalf,
  PriceRounding.wholeUnit => l.roundingWhole,
};

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: AsyncView(
        value: ref.watch(settingsProvider),
        // Key by locale so number formatting follows a language change.
        builder: (s) => _SettingsForm(
          key: ValueKey(Localizations.localeOf(context)),
          initial: s,
        ),
      ),
    );
  }
}

class _SettingsForm extends ConsumerStatefulWidget {
  const _SettingsForm({required this.initial, super.key});
  final SettingsRow initial;

  @override
  ConsumerState<_SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<_SettingsForm> {
  final _form = GlobalKey<FormState>();
  late final Formatters _fmt = Formatters.of(context, ref);
  late final _kwh = TextEditingController(
    text: _fmt.inputMoney(widget.initial.kwhPrice, Scales.kwhPrice),
  );
  late final _labor = TextEditingController(
    text: _fmt.inputMoney(widget.initial.laborHourCents),
  );
  late final _packaging = TextEditingController(
    text: _fmt.inputMoney(widget.initial.packagingCents),
  );
  late final _tax = TextEditingController(
    text: _fmt.input(widget.initial.taxBp, Scales.percent),
  );
  late final _margin = TextEditingController(
    text: _fmt.input(widget.initial.defaultMarginBp, Scales.percent),
  );
  late final _waste = TextEditingController(
    text: _fmt.input(widget.initial.defaultWasteBp, Scales.percent),
  );
  late final _failure = TextEditingController(
    text: _fmt.input(widget.initial.defaultFailureBp, Scales.percent),
  );
  late final _shopName = TextEditingController(text: widget.initial.shopName);
  late final _shopContact = TextEditingController(
    text: widget.initial.shopContact,
  );

  @override
  void dispose() {
    for (final c in [
      _kwh,
      _labor,
      _packaging,
      _tax,
      _margin,
      _waste,
      _failure,
      _shopName,
      _shopContact,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  CatalogUpdate get _repo => ref.read(catalogRepositoryProvider).updateSettings;

  Future<void> _saveNumbers() async {
    if (!_form.currentState!.validate()) return;
    final l = AppLocalizations.of(context);
    int p(TextEditingController c, int scale) => _fmt.parse(c.text, scale) ?? 0;
    await _repo(
      AppSettingsCompanion(
        kwhPrice: Value(p(_kwh, Scales.kwhPrice)),
        laborHourCents: Value(p(_labor, Scales.money)),
        packagingCents: Value(p(_packaging, Scales.money)),
        taxBp: Value(p(_tax, Scales.percent)),
        defaultMarginBp: Value(p(_margin, Scales.percent)),
        defaultWasteBp: Value(p(_waste, Scales.percent)),
        defaultFailureBp: Value(p(_failure, Scales.percent)),
        shopName: Value(_shopName.text.trim()),
        shopContact: Value(_shopContact.text.trim()),
      ),
    );
    if (mounted) showSnack(context, l.settingsSaved);
  }

  Future<void> _pickLogo() async {
    final file = await FilePicker.pickFile(type: FileType.image);
    if (file == null) return;
    final Uint8List bytes = await file.xFile.readAsBytes();
    await _repo(AppSettingsCompanion(shopLogo: Value(bytes)));
  }

  String? _percentValidator(String? text) {
    final l = AppLocalizations.of(context);
    final v = _fmt.parse(text ?? '', Scales.percent);
    if (v == null) return l.invalidNumber;
    if (v >= 10000) return '< 100%';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(settingsProvider).value ?? widget.initial;
    final channels = ref.watch(channelsProvider).value ?? const [];
    const gap = SizedBox(height: 16);
    Widget withHelp(Widget field, String title, String help) => Row(
      children: [
        Expanded(child: field),
        HelpButton(title: title, text: help),
      ],
    );
    Widget header(String text) => Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
    Widget money(TextEditingController c, String label, String help) =>
        NumberField(
          controller: c,
          label: label,
          help: help,
          prefix: _fmt.currencySymbol,
          parse: (t) => _fmt.parse(t, Scales.money),
        );
    Widget pct(TextEditingController c, String label, String help) =>
        TextFormField(
          controller: c,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: label,
            suffixText: '%',
            suffixIcon: HelpButton(title: label, text: help),
          ),
          validator: _percentValidator,
        );

    // Number fields are saved with the button; dropdowns and switches apply
    // right away. The button stays visible while scrolling.
    return Form(
      key: _form,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                header(l.sectionCosts),
                NumberField(
                  controller: _kwh,
                  label: l.settingsKwh,
                  help: l.helpKwh,
                  prefix: _fmt.currencySymbol,
                  parse: (t) => _fmt.parse(t, Scales.kwhPrice),
                ),
                gap,
                money(_labor, l.settingsLaborHour, l.helpLabor),
                gap,
                money(_packaging, l.settingsPackaging, l.helpPackaging),
                gap,
                pct(_waste, l.settingsWaste, l.helpWaste),
                gap,
                pct(_failure, l.settingsFailure, l.helpFailure),
                gap,
                header(l.sectionPricing),
                pct(_margin, l.settingsMargin, l.helpMargin),
                gap,
                withHelp(
                  DropdownButtonFormField<int>(
                    key: const Key('settings.channel'),
                    isExpanded: true,
                    initialValue:
                        channels.any((c) => c.id == s.defaultChannelId)
                        ? s.defaultChannelId
                        : null,
                    decoration: InputDecoration(
                      labelText: l.settingsDefaultChannel,
                    ),
                    items: [
                      for (final c in channels)
                        DropdownMenuItem(value: c.id, child: Text(c.name)),
                    ],
                    onChanged: (id) => _repo(
                      AppSettingsCompanion(defaultChannelId: Value(id)),
                    ),
                  ),
                  l.settingsDefaultChannel,
                  l.helpDefaultChannel,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.storefront_outlined),
                  title: Text(l.channels),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go(Routes.channels),
                ),
                gap,
                pct(_tax, l.settingsTax, l.helpTax),
                gap,
                withHelp(
                  DropdownButtonFormField<PriceRounding>(
                    initialValue: s.priceRounding,
                    decoration: InputDecoration(labelText: l.settingsRounding),
                    items: [
                      for (final r in PriceRounding.values)
                        DropdownMenuItem(
                          value: r,
                          child: Text(roundingLabel(l, r)),
                        ),
                    ],
                    onChanged: (r) =>
                        _repo(AppSettingsCompanion(priceRounding: Value(r!))),
                  ),
                  l.settingsRounding,
                  l.helpRounding,
                ),
                gap,
                header(l.sectionShop),
                TextFormField(
                  controller: _shopName,
                  decoration: InputDecoration(labelText: l.shopName),
                ),
                gap,
                TextFormField(
                  controller: _shopContact,
                  decoration: InputDecoration(labelText: l.shopContact),
                ),
                gap,
                Row(
                  children: [
                    if (s.shopLogo != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.memory(s.shopLogo!, height: 56),
                      ),
                    OutlinedButton.icon(
                      onPressed: _pickLogo,
                      icon: const Icon(Icons.image_outlined),
                      label: Text(l.chooseLogo),
                    ),
                    if (s.shopLogo != null)
                      IconButton(
                        tooltip: l.removeLogo,
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _repo(
                          const AppSettingsCompanion(shopLogo: Value(null)),
                        ),
                      ),
                  ],
                ),
                const Divider(height: 48),
                header(l.sectionAppearance),
                withHelp(
                  DropdownButtonFormField<String>(
                    initialValue: s.currencyCode,
                    decoration: InputDecoration(labelText: l.settingsCurrency),
                    items: [
                      for (final c in supportedCurrencies)
                        DropdownMenuItem(value: c, child: Text(c)),
                    ],
                    onChanged: (c) =>
                        _repo(AppSettingsCompanion(currencyCode: Value(c!))),
                  ),
                  l.settingsCurrency,
                  l.helpCurrency,
                ),
                gap,
                DropdownButtonFormField<String?>(
                  initialValue: s.localeCode,
                  decoration: InputDecoration(labelText: l.settingsLanguage),
                  items: [
                    DropdownMenuItem(child: Text(l.languageSystem)),
                    const DropdownMenuItem(
                      value: 'pt',
                      child: Text('Português'),
                    ),
                    const DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                  onChanged: (c) =>
                      _repo(AppSettingsCompanion(localeCode: Value(c))),
                ),
                gap,
                SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(value: 'system', label: Text(l.themeSystem)),
                    ButtonSegment(value: 'light', label: Text(l.themeLight)),
                    ButtonSegment(value: 'dark', label: Text(l.themeDark)),
                  ],
                  selected: {s.themeMode},
                  onSelectionChanged: (v) =>
                      _repo(AppSettingsCompanion(themeMode: Value(v.first))),
                ),
                const Divider(height: 48),
                header(l.sectionModules),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.printerModuleTitle),
                  subtitle: Text(l.printerModuleSubtitle),
                  value: s.printerModuleEnabled,
                  onChanged: (v) => _repo(
                    AppSettingsCompanion(printerModuleEnabled: Value(v)),
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    key: const Key('settings.save'),
                    onPressed: _saveNumbers,
                    icon: const Icon(Icons.check),
                    label: Text(l.save),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef CatalogUpdate = Future<void> Function(AppSettingsCompanion data);

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/scaled_decimal.dart';
import '../../data/db/app_database.dart';
import '../../l10n/generated/app_localizations.dart';
import '../channels/channel_labels.dart';
import '../common/formatters.dart';
import '../common/help_button.dart';
import '../common/number_field.dart';
import '../filaments/filament_form_screen.dart';
import '../providers.dart';

/// First-run setup: costs, first filament, printer (optional) and the
/// usual sales channel. The router leaves this screen once it is saved.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _steps = 4;
  final _forms = List.generate(_steps, (_) => GlobalKey<FormState>());
  int _step = 0;
  bool _prefilled = false;
  bool _saving = false;

  final _kwh = TextEditingController();
  final _labor = TextEditingController();
  final _packaging = TextEditingController();
  final _tax = TextEditingController();

  String _material = filamentMaterials.first;
  final _brand = TextEditingController();
  final _rollPrice = TextEditingController();
  final _rollWeight = TextEditingController(text: '1000');

  bool _skipPrinter = false;
  final _printerName = TextEditingController();
  final _power = TextEditingController(text: '110');
  final _machineValue = TextEditingController();
  final _lifespan = TextEditingController(text: '5000');

  int? _channelId;

  List<TextEditingController> get _controllers => [
    _kwh,
    _labor,
    _packaging,
    _tax,
    _brand,
    _rollPrice,
    _rollWeight,
    _printerName,
    _power,
    _machineValue,
    _lifespan,
  ];

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _prefill(SettingsRow s, Formatters fmt) {
    _kwh.text = fmt.inputMoney(s.kwhPrice, Scales.kwhPrice);
    _labor.text = fmt.inputMoney(s.laborHourCents);
    _packaging.text = fmt.inputMoney(s.packagingCents);
    _tax.text = fmt.input(s.taxBp, Scales.percent);
    _channelId = s.defaultChannelId;
    _prefilled = true;
  }

  void _next({bool skip = false}) {
    if (_step == 2) _skipPrinter = skip;
    if (!skip && !(_forms[_step].currentState?.validate() ?? true)) return;
    if (_step < _steps - 1) {
      setState(() => _step++);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final fmt = Formatters.of(context, ref);
    setState(() => _saving = true);
    final grams = int.parse(_rollWeight.text.trim());
    await ref
        .read(catalogRepositoryProvider)
        .completeOnboarding(
          settings: AppSettingsCompanion(
            kwhPrice: Value(fmt.parse(_kwh.text, Scales.kwhPrice)!),
            laborHourCents: Value(fmt.parse(_labor.text, Scales.money)!),
            packagingCents: Value(fmt.parse(_packaging.text, Scales.money)!),
            taxBp: Value(fmt.parse(_tax.text, Scales.percent)!),
            defaultChannelId: Value(_channelId),
          ),
          filament: FilamentsCompanion.insert(
            brand: _brand.text.trim(),
            material: _material,
            rollPriceCents: fmt.parse(_rollPrice.text, Scales.money)!,
            rollWeightGrams: Value(grams),
            stockMg: grams * 1000,
          ),
          printer: _skipPrinter
              ? null
              : PrintersCompanion.insert(
                  name: _printerName.text.trim(),
                  powerWatts: int.parse(_power.text.trim()),
                  machineValueCents: fmt.parse(
                    _machineValue.text,
                    Scales.money,
                  )!,
                  lifespanHours: int.parse(_lifespan.text.trim()),
                ),
        );
    // The router redirects to the calculator when settings update.
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider).value;
    final channels = ref.watch(channelsProvider).value;
    if (settings != null && !_prefilled) _prefill(settings, fmt);

    final (title, text) = switch (_step) {
      0 => (l.obCostsTitle, l.obCostsText),
      1 => (l.obFilamentTitle, l.obFilamentText),
      2 => (l.obPrinterTitle, l.obPrinterText),
      _ => (l.obChannelTitle, l.obChannelText),
    };

    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _step > 0) setState(() => _step--);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.obWelcomeTitle),
          leading: _step == 0
              ? null
              : IconButton(
                  tooltip: l.back,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => setState(() => _step--),
                ),
          automaticallyImplyLeading: false,
        ),
        body: settings == null
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LinearProgressIndicator(value: (_step + 1) / _steps),
                    Expanded(
                      child: ListView(
                        key: ValueKey(_step),
                        padding: const EdgeInsets.all(16),
                        children: [
                          Text(
                            l.obStep(_step + 1, _steps),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(title, style: theme.textTheme.headlineSmall),
                          const SizedBox(height: 8),
                          Text(text),
                          const SizedBox(height: 24),
                          Form(
                            key: _forms[_step],
                            child: switch (_step) {
                              0 => _costs(l, fmt),
                              1 => _filament(l, fmt),
                              2 => _printer(l, fmt),
                              _ => _channels(l, fmt, channels ?? const []),
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(
                        children: [
                          if (_step == 2)
                            TextButton(
                              key: const Key('ob.skip'),
                              onPressed: () => _next(skip: true),
                              child: Text(l.obSkip),
                            ),
                          const Spacer(),
                          FilledButton(
                            key: const Key('ob.next'),
                            onPressed: _saving ? null : _next,
                            child: Text(
                              _step == _steps - 1 ? l.obFinish : l.next,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  static const _gap = SizedBox(height: 16);

  Widget _costs(AppLocalizations l, Formatters fmt) => Column(
    children: [
      NumberField(
        fieldKey: const Key('ob.kwh'),
        controller: _kwh,
        label: l.settingsKwh,
        help: l.helpKwh,
        prefix: fmt.currencySymbol,
        parse: (t) => fmt.parse(t, Scales.kwhPrice),
      ),
      _gap,
      NumberField(
        fieldKey: const Key('ob.labor'),
        controller: _labor,
        label: l.settingsLaborHour,
        help: l.helpLabor,
        prefix: fmt.currencySymbol,
        parse: (t) => fmt.parse(t, Scales.money),
      ),
      _gap,
      NumberField(
        controller: _packaging,
        label: l.settingsPackaging,
        help: l.helpPackaging,
        prefix: fmt.currencySymbol,
        parse: (t) => fmt.parse(t, Scales.money),
      ),
      _gap,
      NumberField(
        controller: _tax,
        label: l.settingsTax,
        help: l.helpTax,
        suffix: '%',
        parse: (t) => fmt.parse(t, Scales.percent),
      ),
    ],
  );

  Widget _filament(AppLocalizations l, Formatters fmt) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              initialValue: _material,
              decoration: InputDecoration(labelText: l.filamentMaterial),
              items: [
                for (final m in filamentMaterials)
                  DropdownMenuItem(value: m, child: Text(m)),
              ],
              onChanged: (v) => setState(() => _material = v!),
            ),
          ),
          HelpButton(title: l.filamentMaterial, text: l.helpMaterial),
        ],
      ),
      _gap,
      TextFormField(
        key: const Key('ob.brand'),
        controller: _brand,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: l.filamentBrand,
          suffixIcon: HelpButton(title: l.filamentBrand, text: l.helpBrand),
        ),
        validator: (v) => (v ?? '').trim().isEmpty ? l.requiredField : null,
      ),
      _gap,
      NumberField(
        fieldKey: const Key('ob.rollPrice'),
        controller: _rollPrice,
        label: l.filamentRollPrice,
        help: l.helpRollPrice,
        prefix: fmt.currencySymbol,
        positive: true,
        parse: (t) => fmt.parse(t, Scales.money),
      ),
      _gap,
      NumberField(
        controller: _rollWeight,
        label: l.filamentRollWeight,
        help: l.helpRollWeight,
        suffix: 'g',
        decimal: false,
        positive: true,
        parse: (t) => int.tryParse(t.trim()),
      ),
    ],
  );

  Widget _printer(AppLocalizations l, Formatters fmt) => Column(
    children: [
      TextFormField(
        key: const Key('ob.printerName'),
        controller: _printerName,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: l.printerName,
          hintText: l.obPrinterNameHint,
          suffixIcon: HelpButton(title: l.printerName, text: l.helpPrinterName),
        ),
        validator: (v) => (v ?? '').trim().isEmpty ? l.requiredField : null,
      ),
      _gap,
      NumberField(
        controller: _power,
        label: l.printerPower,
        help: l.helpPower,
        suffix: 'W',
        decimal: false,
        parse: (t) => int.tryParse(t.trim()),
      ),
      _gap,
      NumberField(
        fieldKey: const Key('ob.machineValue'),
        controller: _machineValue,
        label: l.printerValue,
        help: l.helpMachineValue,
        prefix: fmt.currencySymbol,
        parse: (t) => fmt.parse(t, Scales.money),
      ),
      _gap,
      NumberField(
        controller: _lifespan,
        label: l.printerLifespan,
        help: l.helpLifespan,
        suffix: 'h',
        decimal: false,
        positive: true,
        parse: (t) => int.tryParse(t.trim()),
      ),
    ],
  );

  Widget _channels(
    AppLocalizations l,
    Formatters fmt,
    List<SalesChannelRow> channels,
  ) {
    final theme = Theme.of(context);
    return RadioGroup<int>(
      groupValue: _channelId,
      onChanged: (v) => setState(() => _channelId = v),
      child: Column(
        children: [
          for (final c in channels)
            RadioListTile<int>(
              key: Key('ob.channel.${c.id}'),
              value: c.id,
              contentPadding: EdgeInsets.zero,
              title: Text(c.name),
              subtitle: Text(
                [
                  tiersSummary(l, fmt, c.tiers),
                  if (c.isExample) l.channelExampleBadge,
                ].join('\n'),
                style: theme.textTheme.bodySmall,
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format/scaled_decimal.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/job_repository.dart';
import '../../domain/models/job_status.dart';
import '../../domain/pricing/cost_calculator.dart';
import '../../domain/pricing/price_rounding.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../common/help_button.dart';
import '../common/number_field.dart';
import '../filaments/filaments_screen.dart';
import '../providers.dart';
import '../router.dart';
import '../settings/settings_screen.dart';
import '../slicer/import_slice.dart';
import 'breakdown_chart.dart';
import 'calculator_prefill.dart';
import 'save_job_sheet.dart';

/// Action behind "Importar do arquivo"; overridable in tests.
typedef SliceImportAction = Future<void> Function(BuildContext, WidgetRef);
final sliceImportActionProvider = Provider<SliceImportAction?>(
  (ref) => importSliceFile,
);

/// Roll data kept from history when the filament no longer exists.
class _Snapshot {
  const _Snapshot(this.label, this.rollPriceCents, this.rollWeightGrams);
  final String label;
  final int rollPriceCents;
  final int rollWeightGrams;
}

class _Line {
  _Line({this.filamentId, String grams = '', this.hint, this.snapshot})
    : grams = TextEditingController(text: grams);
  int? filamentId;
  final TextEditingController grams;

  /// Text shown when the line came from a file and needs a filament.
  final String? hint;
  final _Snapshot? snapshot;
}

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  List<_Line> _lines = [_Line()];
  int? _printerId;
  bool _printerTouched = false;
  final _hours = TextEditingController();
  final _minutes = TextEditingController();
  final _post = TextEditingController(text: '0');
  final _waste = TextEditingController();
  final _failure = TextEditingController();
  final _margin = TextEditingController();
  final _kwh = TextEditingController();
  final _labor = TextEditingController();
  final _packaging = TextEditingController();
  final _marketplace = TextEditingController();
  final _tax = TextEditingController();
  PriceRounding _rounding = PriceRounding.none;
  bool _defaultsApplied = false;
  JobWithFilaments? _editing;
  String? _sourceFile;
  String? _suggestedName;

  /// Bumped when values change programmatically so dropdowns rebuild.
  int _generation = 0;

  List<TextEditingController> get _controllers => [
    _hours,
    _minutes,
    _post,
    _waste,
    _failure,
    _margin,
    _kwh,
    _labor,
    _packaging,
    _marketplace,
    _tax,
  ];

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final l in _lines) {
      l.grams.dispose();
    }
    super.dispose();
  }

  void _applyDefaults(SettingsRow s, Formatters fmt) {
    _waste.text = fmt.input(s.defaultWasteBp, Scales.percent);
    _failure.text = fmt.input(s.defaultFailureBp, Scales.percent);
    _margin.text = fmt.input(s.defaultMarginBp, Scales.percent);
    _kwh.text = fmt.input(s.kwhPrice, Scales.kwhPrice);
    _labor.text = fmt.input(s.laborHourCents, Scales.money);
    _packaging.text = fmt.input(s.packagingCents, Scales.money);
    _marketplace.text = fmt.input(s.marketplaceFeeBp, Scales.percent);
    _tax.text = fmt.input(s.taxBp, Scales.percent);
    _rounding = s.priceRounding;
    _defaultsApplied = true;
    _generation++;
  }

  void _replaceLines(List<_Line> lines) {
    for (final l in _lines) {
      l.grams.dispose();
    }
    _lines = lines.isEmpty ? [_Line()] : lines;
    _generation++;
  }

  void _setTime(int seconds) {
    _hours.text = '${seconds ~/ 3600}';
    _minutes.text = '${(seconds % 3600 / 60).round()}';
  }

  void _clear(SettingsRow s, Formatters fmt) {
    setState(() {
      _replaceLines([]);
      _hours.clear();
      _minutes.clear();
      _post.text = '0';
      _printerId = null;
      _printerTouched = false;
      _editing = null;
      _sourceFile = null;
      _suggestedName = null;
      _applyDefaults(s, fmt);
    });
  }

  void _applyPrefill(CalculatorPrefill p, SettingsRow s, Formatters fmt) {
    final job = p.job;
    setState(() {
      if (job != null) {
        final j = job.job;
        _editing = job;
        _sourceFile = j.sourceFile;
        _replaceLines([
          for (final f in job.filaments)
            _Line(
              filamentId: f.filamentId,
              grams: fmt.input(f.weightMg, Scales.grams),
              snapshot: _Snapshot(f.label, f.rollPriceCents, f.rollWeightGrams),
            ),
        ]);
        _setTime(j.printSeconds);
        _post.text = '${j.postProcessMinutes}';
        _printerId = j.printerId;
        _printerTouched = true;
        _waste.text = fmt.input(j.wasteBp, Scales.percent);
        _failure.text = fmt.input(j.failureBp, Scales.percent);
        _margin.text = fmt.input(j.marginBp, Scales.percent);
        _kwh.text = fmt.input(j.kwhPrice, Scales.kwhPrice);
        _labor.text = fmt.input(j.laborHourCents, Scales.money);
        _packaging.text = fmt.input(j.packagingCents, Scales.money);
        _marketplace.text = fmt.input(j.marketplaceFeeBp, Scales.percent);
        _tax.text = fmt.input(j.taxBp, Scales.percent);
        _rounding = j.priceRounding;
        _defaultsApplied = true;
        return;
      }
      if (!_defaultsApplied) _applyDefaults(s, fmt);
      _editing = null;
      _sourceFile = p.sourceFile ?? _sourceFile;
      _suggestedName = p.suggestedName ?? _suggestedName;
      if (p.filaments.isNotEmpty) {
        _replaceLines([
          for (final f in p.filaments)
            _Line(
              filamentId: f.filamentId,
              grams: fmt.input(f.weightMg, Scales.grams),
              hint: f.filamentId == null ? f.label : null,
            ),
        ]);
      }
      if (p.printSeconds != null) _setTime(p.printSeconds!);
      if (p.printerId != null) {
        _printerId = p.printerId;
        _printerTouched = true;
      }
      _generation++;
    });
  }

  int? _effectiveFilamentId(_Line line, List<FilamentRow> filaments) {
    if (line.filamentId != null &&
        filaments.any((f) => f.id == line.filamentId)) {
      return line.filamentId;
    }
    if (line.filamentId == null && line.hint == null && line.snapshot == null) {
      return filaments.firstOrNull?.id;
    }
    return null;
  }

  int? _effectivePrinterId(List<PrinterRow> printers) {
    if (_printerTouched) {
      return printers.any((p) => p.id == _printerId) ? _printerId : null;
    }
    return printers.firstOrNull?.id;
  }

  MachineProfile? _machine(List<PrinterRow> printers) {
    final id = _effectivePrinterId(printers);
    final p = printers.where((p) => p.id == id).firstOrNull;
    if (p != null) {
      return MachineProfile(
        powerWatts: p.powerWatts,
        machineValueCents: p.machineValueCents,
        lifespanHours: p.lifespanHours,
        maintenancePerHourCents: p.maintenancePerHourCents,
      );
    }
    // Editing a job whose printer was archived: keep its snapshot.
    final j = _editing?.job;
    if (j != null && j.printerId != null && _printerId == j.printerId) {
      return MachineProfile(
        powerWatts: j.powerWatts,
        machineValueCents: j.machineValueCents,
        lifespanHours: j.lifespanHours,
        maintenancePerHourCents: j.maintenancePerHourCents,
      );
    }
    return null;
  }

  /// Builds the pure input from the form, or null when something is missing.
  PricingInput? _buildInput(
    List<FilamentRow> filaments,
    List<PrinterRow> printers,
    Formatters fmt,
  ) {
    final usages = <FilamentUsage>[];
    var totalMg = 0;
    for (final line in _lines) {
      final mg = fmt.parse(line.grams.text, Scales.grams);
      if (mg == null) return null;
      final id = _effectiveFilamentId(line, filaments);
      final f = filaments.where((f) => f.id == id).firstOrNull;
      if (f != null) {
        usages.add(
          FilamentUsage(
            weightMg: mg,
            rollPriceCents: f.rollPriceCents,
            rollWeightGrams: f.rollWeightGrams,
          ),
        );
      } else if (line.snapshot case final s?) {
        usages.add(
          FilamentUsage(
            weightMg: mg,
            rollPriceCents: s.rollPriceCents,
            rollWeightGrams: s.rollWeightGrams,
          ),
        );
      } else {
        return null;
      }
      totalMg += mg;
    }
    if (totalMg == 0) return null;

    int? intOr0(TextEditingController c) =>
        c.text.trim().isEmpty ? 0 : int.tryParse(c.text.trim());
    final hours = intOr0(_hours);
    final minutes = intOr0(_minutes);
    final post = intOr0(_post);
    final values = [
      fmt.parse(_waste.text, Scales.percent),
      fmt.parse(_failure.text, Scales.percent),
      fmt.parse(_margin.text, Scales.percent),
      fmt.parse(_kwh.text, Scales.kwhPrice),
      fmt.parse(_labor.text, Scales.money),
      fmt.parse(_packaging.text, Scales.money),
      fmt.parse(_marketplace.text, Scales.percent),
      fmt.parse(_tax.text, Scales.percent),
    ];
    if (hours == null || minutes == null || post == null) return null;
    if (values.any((v) => v == null)) return null;
    final v = values.cast<int>();
    return PricingInput(
      filaments: usages,
      printSeconds: hours * 3600 + minutes * 60,
      machine: _machine(printers),
      wasteBp: v[0],
      failureBp: v[1],
      marginBp: v[2],
      kwhPrice: v[3],
      laborHourCents: v[4],
      packagingCents: v[5],
      marketplaceFeeBp: v[6],
      taxBp: v[7],
      postProcessMinutes: post,
      rounding: _rounding,
    );
  }

  Future<void> _save(
    PricingInput input,
    CostBreakdown b,
    List<FilamentRow> filaments,
    List<PrinterRow> printers,
    Formatters fmt,
  ) async {
    final l = AppLocalizations.of(context);
    final editing = _editing?.job;
    final meta = await showSaveJobSheet(
      context,
      JobMeta(
        name: editing?.name ?? _suggestedName ?? '',
        customer: editing?.customer,
        quantity: editing?.quantity ?? 1,
        status: editing?.status ?? JobStatus.quote,
        notes: editing?.notes,
        photoPath: editing?.photoPath,
      ),
    );
    if (meta == null || !mounted) return;

    final printerId =
        _effectivePrinterId(printers) ??
        (input.machine != null ? editing?.printerId : null);
    final printer = printers.where((p) => p.id == printerId).firstOrNull;
    final m = input.machine;
    final job = JobsCompanion(
      id: editing == null ? const Value.absent() : Value(editing.id),
      name: Value(meta.name),
      customer: Value(meta.customer),
      notes: Value(meta.notes),
      photoPath: Value(meta.photoPath),
      status: Value(meta.status),
      quantity: Value(meta.quantity),
      printerId: Value(m == null ? null : printerId),
      printerName: Value(
        m == null ? null : (printer?.name ?? editing?.printerName),
      ),
      powerWatts: Value(m?.powerWatts ?? 0),
      machineValueCents: Value(m?.machineValueCents ?? 0),
      lifespanHours: Value(m?.lifespanHours ?? 0),
      maintenancePerHourCents: Value(m?.maintenancePerHourCents ?? 0),
      printSeconds: Value(input.printSeconds),
      postProcessMinutes: Value(input.postProcessMinutes),
      kwhPrice: Value(input.kwhPrice),
      laborHourCents: Value(input.laborHourCents),
      packagingCents: Value(input.packagingCents),
      wasteBp: Value(input.wasteBp),
      failureBp: Value(input.failureBp),
      marginBp: Value(input.marginBp),
      marketplaceFeeBp: Value(input.marketplaceFeeBp),
      taxBp: Value(input.taxBp),
      priceRounding: Value(input.rounding),
      costCents: Value(b.totalCostCents),
      priceCents: Value(b.priceCents),
      profitCents: Value(b.netProfitCents),
      sourceFile: Value(_sourceFile),
    );
    final lines = <JobFilamentsCompanion>[];
    for (final line in _lines) {
      final id = _effectiveFilamentId(line, filaments);
      final f = filaments.where((f) => f.id == id).firstOrNull;
      final mg = fmt.parse(line.grams.text, Scales.grams)!;
      lines.add(
        JobFilamentsCompanion.insert(
          jobId: 0,
          filamentId: Value(f?.id ?? line.filamentId),
          label: f == null ? line.snapshot!.label : filamentLabel(f),
          weightMg: mg,
          rollPriceCents: f?.rollPriceCents ?? line.snapshot!.rollPriceCents,
          rollWeightGrams: f?.rollWeightGrams ?? line.snapshot!.rollWeightGrams,
        ),
      );
    }
    final id = await ref.read(jobRepositoryProvider).saveJob(job, lines);
    if (!mounted) return;
    final settings = ref.read(settingsProvider).value;
    if (settings != null) _clear(settings, fmt);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l.jobSaved),
        action: SnackBarAction(
          label: l.jobDetails,
          onPressed: () => context.go(Routes.job(id)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    final settingsAsync = ref.watch(settingsProvider);
    final filaments = ref.watch(filamentsProvider).value;
    final printers = ref.watch(printersProvider).value;
    final settings = settingsAsync.value;

    if (settings != null && !_defaultsApplied) _applyDefaults(settings, fmt);
    final pending = ref.watch(calculatorPrefillProvider);
    if (pending != null && settings != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final p = ref.read(calculatorPrefillProvider.notifier).take();
        if (p != null && mounted) _applyPrefill(p, settings, fmt);
      });
    }

    final importAction = ref.watch(sliceImportActionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editing == null
              ? l.navCalculator
              : l.calcEditing(_editing!.job.name),
        ),
        actions: [
          if (settings != null)
            IconButton(
              tooltip: l.calcClear,
              icon: const Icon(Icons.restart_alt),
              onPressed: () => _clear(settings, fmt),
            ),
        ],
      ),
      body: settings == null || filaments == null || printers == null
          ? AsyncView(value: settingsAsync, builder: (_) => const SizedBox())
          : filaments.isEmpty && _lines.every((l) => l.snapshot == null)
          ? _NeedFilament()
          : _buildForm(
              context,
              settings,
              filaments,
              printers,
              fmt,
              importAction,
            ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    SettingsRow settings,
    List<FilamentRow> filaments,
    List<PrinterRow> printers,
    Formatters fmt,
    SliceImportAction? importAction,
  ) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final input = _buildInput(filaments, printers, fmt);
    final result = input == null ? null : calculatePrice(input);
    const gap = SizedBox(height: 12);
    void changed([Object? _]) => setState(() {});

    Widget section(String title, List<Widget> children, {Widget? trailing}) =>
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title, style: theme.textTheme.titleMedium),
                    ),
                    ?trailing,
                  ],
                ),
                gap,
                ...children,
              ],
            ),
          ),
        );

    Widget pct(
      TextEditingController c,
      String label,
      String help,
      String key,
    ) => NumberField(
      fieldKey: Key(key),
      controller: c,
      label: label,
      help: help,
      suffix: '%',
      parse: (t) => fmt.parse(t, Scales.percent),
      onChanged: changed,
    );
    Widget money(
      TextEditingController c,
      String label,
      String help,
      int scale,
    ) => NumberField(
      controller: c,
      label: label,
      help: help,
      prefix: fmt.currencySymbol,
      parse: (t) => fmt.parse(t, scale),
      onChanged: changed,
    );

    final printerValue = _effectivePrinterId(printers);
    return Form(
      key: _formKey,
      child: ListView(
        key: ValueKey(_generation),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
        children: [
          section(l.calcFilamentsSection, [
            for (final (i, line) in _lines.indexed) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<int>(
                      key: Key('calc.filament.$i'),
                      isExpanded: true,
                      initialValue: _effectiveFilamentId(line, filaments),
                      hint: Text(
                        line.snapshot?.label ??
                            line.hint ??
                            l.calcSelectFilament,
                        overflow: TextOverflow.ellipsis,
                      ),
                      decoration: InputDecoration(
                        labelText: l.calcSelectFilament,
                      ),
                      items: [
                        for (final f in filaments)
                          DropdownMenuItem(
                            value: f.id,
                            child: Row(
                              children: [
                                ColorDot(argb: f.colorArgb, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    filamentLabel(f),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (v) => setState(() => line.filamentId = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: NumberField(
                      fieldKey: Key('calc.grams.$i'),
                      controller: line.grams,
                      label: l.calcGrams,
                      suffix: 'g',
                      help: i == 0 ? l.helpGrams : null,
                      parse: (t) => fmt.parse(t, Scales.grams),
                      onChanged: changed,
                    ),
                  ),
                  if (_lines.length > 1)
                    IconButton(
                      tooltip: l.delete,
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => setState(() {
                        _lines.removeAt(i).grams.dispose();
                        _generation++;
                      }),
                    ),
                ],
              ),
              gap,
            ],
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => setState(
                    () => _lines.add(
                      _Line(filamentId: filaments.firstOrNull?.id),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: Text(l.calcAddFilament),
                ),
                if (importAction != null)
                  FilledButton.tonalIcon(
                    key: const Key('calc.import'),
                    onPressed: () => importAction(context, ref),
                    icon: const Icon(Icons.file_open_outlined),
                    label: Text(l.calcImport3mf),
                  ),
              ],
            ),
          ]),
          gap,
          section(l.calcPrinterSection, [
            DropdownButtonFormField<int?>(
              key: const Key('calc.printer'),
              isExpanded: true,
              initialValue: printerValue,
              decoration: InputDecoration(
                labelText: l.calcPrinter,
                suffixIcon: HelpButton(
                  title: l.calcPrinter,
                  text: l.helpPrinterField,
                ),
              ),
              items: [
                for (final p in printers)
                  DropdownMenuItem(value: p.id, child: Text(p.name)),
                DropdownMenuItem(child: Text(l.calcNoPrinter)),
              ],
              onChanged: (v) => setState(() {
                _printerId = v;
                _printerTouched = true;
              }),
            ),
            gap,
            Row(
              children: [
                Expanded(
                  child: NumberField(
                    fieldKey: const Key('calc.hours'),
                    controller: _hours,
                    label: l.calcHours,
                    decimal: false,
                    required: false,
                    parse: (t) => int.tryParse(t.trim()),
                    onChanged: changed,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: NumberField(
                    fieldKey: const Key('calc.minutes'),
                    controller: _minutes,
                    label: l.calcMinutes,
                    decimal: false,
                    required: false,
                    help: l.helpPrintTime,
                    parse: (t) => int.tryParse(t.trim()),
                    onChanged: changed,
                  ),
                ),
              ],
            ),
            gap,
            NumberField(
              fieldKey: const Key('calc.post'),
              controller: _post,
              label: l.calcPostProcess,
              decimal: false,
              required: false,
              help: l.helpPostProcess,
              parse: (t) => int.tryParse(t.trim()),
              onChanged: changed,
            ),
          ]),
          gap,
          section(l.calcPercentsSection, [
            pct(_margin, l.calcMargin, l.helpMargin, 'calc.margin'),
            gap,
            pct(_waste, l.calcWaste, l.helpWaste, 'calc.waste'),
            gap,
            pct(_failure, l.calcFailure, l.helpFailure, 'calc.failure'),
            gap,
            DropdownButtonFormField<PriceRounding>(
              key: const Key('calc.rounding'),
              initialValue: _rounding,
              decoration: InputDecoration(
                labelText: l.settingsRounding,
                suffixIcon: HelpButton(
                  title: l.settingsRounding,
                  text: l.helpRounding,
                ),
              ),
              items: [
                for (final r in PriceRounding.values)
                  DropdownMenuItem(value: r, child: Text(roundingLabel(l, r))),
              ],
              onChanged: (r) => setState(() => _rounding = r!),
            ),
          ]),
          gap,
          Card(
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              title: Text(l.calcAdvanced),
              subtitle: Text(l.calcAdvancedSubtitle),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                money(_kwh, l.settingsKwh, l.helpKwh, Scales.kwhPrice),
                gap,
                money(_labor, l.settingsLaborHour, l.helpLabor, Scales.money),
                gap,
                money(
                  _packaging,
                  l.settingsPackaging,
                  l.helpPackaging,
                  Scales.money,
                ),
                gap,
                pct(
                  _marketplace,
                  l.settingsMarketplace,
                  l.helpMarketplace,
                  'calc.marketplace',
                ),
                gap,
                pct(_tax, l.settingsTax, l.helpTax, 'calc.tax'),
              ],
            ),
          ),
          gap,
          _ResultCard(
            result: result,
            fmt: fmt,
            editing: _editing != null,
            onSave: switch (result) {
              PricingSuccess(:final breakdown) => () => _save(
                input!,
                breakdown,
                filaments,
                printers,
                fmt,
              ),
              _ => null,
            },
          ),
        ],
      ),
    );
  }
}

class _NeedFilament extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.circle_outlined, size: 48),
            const SizedBox(height: 16),
            Text(l.calcNeedFilament, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go(Routes.newFilament),
              child: Text(l.calcGoToFilaments),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.result,
    required this.fmt,
    required this.editing,
    required this.onSave,
  });

  final PricingResult? result;
  final Formatters fmt;
  final bool editing;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final r = result;
    if (r == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(l.calcFillToSee, textAlign: TextAlign.center),
        ),
      );
    }
    if (r is PricingFailure) {
      final message = switch (r.error) {
        PricingError.deductionsTooHigh => l.errDeductionsTooHigh(
          fmt.percent(r.deductionsBp ?? 0),
        ),
        PricingError.negativeValue => l.errNegative,
        PricingError.invalidRollWeight => l.errRollWeight,
      };
      return Card(
        key: const Key('calc.error'),
        color: theme.colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: theme.colorScheme.onErrorContainer),
                ),
              ),
            ],
          ),
        ),
      );
    }
    final b = (r as PricingSuccess).breakdown;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l.calcResultPrice, style: theme.textTheme.titleSmall),
            Text(
              fmt.money(b.priceCents),
              key: const Key('calc.price'),
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            if (b.unroundedPriceCents != b.priceCents)
              Text(
                l.calcPriceBeforeRounding(fmt.money(b.unroundedPriceCents)),
                style: theme.textTheme.bodySmall,
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: l.calcResultCost,
                    value: fmt.money(b.totalCostCents),
                    valueKey: const Key('calc.cost'),
                  ),
                ),
                Expanded(
                  child: _Metric(
                    label: l.calcResultProfit,
                    value: fmt.money(b.netProfitCents),
                    detail: l.profitPercentOfPrice(fmt.percent(b.netMarginBp)),
                    valueKey: const Key('calc.profit'),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(l.calcBreakdown, style: theme.textTheme.titleSmall),
            const SizedBox(height: 12),
            BreakdownChart(breakdown: b, fmt: fmt),
            const SizedBox(height: 16),
            FilledButton.icon(
              key: const Key('calc.save'),
              onPressed: onSave,
              icon: const Icon(Icons.save_outlined),
              label: Text(editing ? l.calcUpdate : l.calcSave),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    this.detail,
    this.valueKey,
  });
  final String label;
  final String value;
  final String? detail;
  final Key? valueKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        Text(value, key: valueKey, style: theme.textTheme.titleLarge),
        if (detail != null) Text(detail!, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

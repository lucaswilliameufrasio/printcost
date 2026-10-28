import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/format/scaled_decimal.dart';
import '../../data/db/app_database.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../common/help_button.dart';
import '../common/number_field.dart';
import '../providers.dart';
import 'filaments_screen.dart';

const filamentMaterials = [
  'PLA',
  'PLA+',
  'PLA Silk',
  'PLA Matte',
  'PETG',
  'ABS',
  'ASA',
  'TPU',
  'PA/Nylon',
  'PC',
  'PLA-CF',
  'PETG-CF',
  'PVA',
  'HIPS',
];

const swatches = <int>[
  0xFFFFFFFF,
  0xFF000000,
  0xFF9E9E9E,
  0xFFD32F2F,
  0xFFF57C00,
  0xFFFBC02D,
  0xFF388E3C,
  0xFF1976D2,
  0xFF7B1FA2,
  0xFFE91E63,
  0xFF795548,
  0xFF00BCD4,
  0xFFCDDC39,
  0xFFFFD700,
  0xFFC0C0C0,
  0xFFF5F5DC,
];

class FilamentFormScreen extends ConsumerStatefulWidget {
  const FilamentFormScreen({this.id, super.key});
  final int? id;

  @override
  ConsumerState<FilamentFormScreen> createState() => _FilamentFormState();
}

class _FilamentFormState extends ConsumerState<FilamentFormScreen> {
  final _form = GlobalKey<FormState>();
  final _brand = TextEditingController();
  final _material = TextEditingController(text: 'PLA');
  final _color = TextEditingController();
  final _price = TextEditingController();
  final _rollWeight = TextEditingController(text: '1000');
  final _stock = TextEditingController(text: '1000');
  final _lowStock = TextEditingController(text: '100');
  int? _argb;
  bool _loaded = false;
  bool _stockEdited = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = widget.id;
    if (id == null) {
      setState(() => _loaded = true);
      return;
    }
    final f = await ref.read(catalogRepositoryProvider).filament(id);
    if (!mounted || f == null) return;
    final fmt = Formatters.of(context, ref);
    _brand.text = f.brand;
    _material.text = f.material;
    _color.text = f.colorName;
    _argb = f.colorArgb;
    _price.text = fmt.input(f.rollPriceCents, Scales.money);
    _rollWeight.text = '${f.rollWeightGrams}';
    _stock.text = fmt.input(f.stockMg, Scales.grams);
    _lowStock.text = fmt.input(f.lowStockAlertMg, Scales.grams);
    _stockEdited = true;
    setState(() => _loaded = true);
  }

  @override
  void dispose() {
    for (final c in [
      _brand,
      _material,
      _color,
      _price,
      _rollWeight,
      _stock,
      _lowStock,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    if (_material.text.trim().isEmpty) _material.text = 'PLA';
    final fmt = Formatters.of(context, ref);
    final data = FilamentsCompanion(
      id: widget.id == null ? const Value.absent() : Value(widget.id!),
      brand: Value(_brand.text.trim()),
      material: Value(_material.text.trim()),
      colorName: Value(_color.text.trim()),
      colorArgb: Value(_argb),
      rollPriceCents: Value(fmt.parse(_price.text, Scales.money)!),
      rollWeightGrams: Value(int.parse(_rollWeight.text.trim())),
      stockMg: Value(fmt.parse(_stock.text, Scales.grams)!),
      lowStockAlertMg: Value(fmt.parse(_lowStock.text, Scales.grams)!),
    );
    await ref.read(catalogRepositoryProvider).saveFilament(data);
    if (mounted) context.pop();
  }

  Future<void> _archive() async {
    final l = AppLocalizations.of(context);
    if (!await confirm(
      context,
      message: l.archiveFilamentConfirm,
      action: l.archive,
    )) {
      return;
    }
    await ref.read(catalogRepositoryProvider).archiveFilament(widget.id!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    const gap = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? l.newFilament : l.editFilament),
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
                  TextFormField(
                    controller: _brand,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l.filamentBrand,
                      suffixIcon: HelpButton(
                        title: l.filamentBrand,
                        text: l.helpBrand,
                      ),
                    ),
                    validator: (v) =>
                        (v ?? '').trim().isEmpty ? l.requiredField : null,
                  ),
                  gap,
                  Row(
                    children: [
                      Expanded(
                        child: DropdownMenu<String>(
                          controller: _material,
                          expandedInsets: EdgeInsets.zero,
                          requestFocusOnTap: true,
                          enableFilter: true,
                          label: Text(l.filamentMaterial),
                          dropdownMenuEntries: [
                            for (final m in filamentMaterials)
                              DropdownMenuEntry(value: m, label: m),
                          ],
                        ),
                      ),
                      HelpButton(
                        title: l.filamentMaterial,
                        text: l.helpMaterial,
                      ),
                    ],
                  ),
                  gap,
                  TextFormField(
                    controller: _color,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l.filamentColor,
                      suffixIcon: HelpButton(
                        title: l.filamentColor,
                        text: l.helpColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final c in swatches)
                        InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => setState(() => _argb = c),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ColorDot(argb: c),
                              if (_argb == c)
                                Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Color(c).computeLuminance() > 0.5
                                      ? Colors.black
                                      : Colors.white,
                                ),
                            ],
                          ),
                        ),
                      ActionChip(
                        label: Text(l.noColor),
                        onPressed: () => setState(() => _argb = null),
                      ),
                    ],
                  ),
                  gap,
                  NumberField(
                    controller: _price,
                    label: l.filamentRollPrice,
                    help: l.helpRollPrice,
                    prefix: fmt.currencySymbol,
                    positive: true,
                    parse: (t) => fmt.parse(t, Scales.money),
                  ),
                  gap,
                  NumberField(
                    controller: _rollWeight,
                    label: l.filamentRollWeight,
                    help: l.helpRollWeight,
                    decimal: false,
                    positive: true,
                    parse: (t) => int.tryParse(t.trim()),
                    onChanged: (v) {
                      if (!_stockEdited) _stock.text = v;
                    },
                  ),
                  gap,
                  NumberField(
                    controller: _stock,
                    label: l.filamentStock,
                    help: l.helpStock,
                    parse: (t) => fmt.parse(t, Scales.grams),
                    onChanged: (_) => _stockEdited = true,
                  ),
                  gap,
                  NumberField(
                    controller: _lowStock,
                    label: l.filamentLowStock,
                    help: l.helpLowStock,
                    parse: (t) => fmt.parse(t, Scales.grams),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
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

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

class PrinterFormScreen extends ConsumerStatefulWidget {
  const PrinterFormScreen({this.id, super.key});
  final int? id;

  @override
  ConsumerState<PrinterFormScreen> createState() => _PrinterFormState();
}

class _PrinterFormState extends ConsumerState<PrinterFormScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _power = TextEditingController(text: '110');
  final _value = TextEditingController();
  final _life = TextEditingController(text: '5000');
  final _maintenance = TextEditingController(text: '0');
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = widget.id;
    if (id != null) {
      final printers = await ref
          .read(catalogRepositoryProvider)
          .watchPrinters()
          .first;
      final p = printers.where((p) => p.id == id).firstOrNull;
      if (!mounted) return;
      if (p != null) {
        final fmt = Formatters.of(context, ref);
        _name.text = p.name;
        _power.text = '${p.powerWatts}';
        _value.text = fmt.inputMoney(p.machineValueCents);
        _life.text = '${p.lifespanHours}';
        _maintenance.text = fmt.inputMoney(p.maintenancePerHourCents);
      }
    }
    setState(() => _loaded = true);
  }

  @override
  void dispose() {
    for (final c in [_name, _power, _value, _life, _maintenance]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final fmt = Formatters.of(context, ref);
    await ref
        .read(catalogRepositoryProvider)
        .savePrinter(
          PrintersCompanion(
            id: widget.id == null ? const Value.absent() : Value(widget.id!),
            name: Value(_name.text.trim()),
            powerWatts: Value(int.parse(_power.text.trim())),
            machineValueCents: Value(fmt.parse(_value.text, Scales.money)!),
            lifespanHours: Value(int.parse(_life.text.trim())),
            maintenancePerHourCents: Value(
              fmt.parse(_maintenance.text, Scales.money) ?? 0,
            ),
          ),
        );
    if (mounted) context.pop();
  }

  Future<void> _archive() async {
    final l = AppLocalizations.of(context);
    if (!await confirm(
      context,
      message: l.archivePrinterConfirm,
      action: l.archive,
    )) {
      return;
    }
    await ref.read(catalogRepositoryProvider).archivePrinter(widget.id!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Formatters.of(context, ref);
    const gap = SizedBox(height: 16);
    int? intParse(String t) => int.tryParse(t.trim());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? l.newPrinter : l.editPrinter),
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
                    controller: _name,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l.printerName,
                      suffixIcon: HelpButton(
                        title: l.printerName,
                        text: l.helpPrinterName,
                      ),
                    ),
                    validator: (v) =>
                        (v ?? '').trim().isEmpty ? l.requiredField : null,
                  ),
                  gap,
                  NumberField(
                    controller: _power,
                    label: l.printerPower,
                    help: l.helpPower,
                    suffix: 'W',
                    decimal: false,
                    parse: intParse,
                  ),
                  gap,
                  NumberField(
                    controller: _value,
                    label: l.printerValue,
                    help: l.helpMachineValue,
                    prefix: fmt.currencySymbol,
                    parse: (t) => fmt.parse(t, Scales.money),
                  ),
                  gap,
                  NumberField(
                    controller: _life,
                    label: l.printerLifespan,
                    help: l.helpLifespan,
                    suffix: 'h',
                    decimal: false,
                    positive: true,
                    parse: intParse,
                  ),
                  gap,
                  NumberField(
                    controller: _maintenance,
                    label: l.printerMaintenance,
                    help: l.helpMaintenance,
                    prefix: fmt.currencySymbol,
                    required: false,
                    parse: (t) => fmt.parse(t, Scales.money),
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

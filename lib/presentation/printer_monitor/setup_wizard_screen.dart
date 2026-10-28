import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/printer/bambu_lan_adapter.dart';
import '../../domain/printer/printer_adapter.dart';
import '../../domain/printer/printer_status.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/help_button.dart';
import '../providers.dart';
import 'printer_labels.dart';
import 'printer_session.dart';

/// Guided setup: LAN mode -> Developer Mode -> IP/serial/code -> test.
class SetupWizardScreen extends ConsumerStatefulWidget {
  const SetupWizardScreen({super.key});

  @override
  ConsumerState<SetupWizardScreen> createState() => _SetupWizardState();
}

sealed class _TestResult {
  const _TestResult();
}

class _Testing extends _TestResult {
  const _Testing();
}

class _TestOk extends _TestResult {
  const _TestOk(this.status, this.certSha256);
  final PrinterStatus status;
  final String? certSha256;
}

class _TestFailed extends _TestResult {
  const _TestFailed(this.error, this.detail);
  final PrinterConnectionError error;
  final String? detail;
}

class _SetupWizardState extends ConsumerState<SetupWizardScreen> {
  int _step = 0;
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController(text: 'Bambu');
  final _ip = TextEditingController();
  final _serial = TextEditingController();
  final _code = TextEditingController();
  int? _printerId;
  bool _printerTouched = false;
  bool _showCode = false;
  _TestResult? _result;

  @override
  void dispose() {
    for (final c in [_name, _ip, _serial, _code]) {
      c.dispose();
    }
    super.dispose();
  }

  BambuLanConfig get _config => BambuLanConfig(
    host: _ip.text.trim(),
    serial: _serial.text.trim(),
    accessCode: _code.text.trim(),
  );

  Future<void> _test() async {
    setState(() => _result = const _Testing());
    final adapter = ref.read(adapterFactoryProvider)(_config, (_) {});
    _TestResult result;
    try {
      final status = await adapter.testConnection();
      result = _TestOk(status, adapter.observedCertSha256);
    } on PrinterAdapterException catch (e) {
      result = _TestFailed(e.error, e.detail);
    } finally {
      await adapter.disconnect();
    }
    if (mounted) setState(() => _result = result);
  }

  Future<void> _save(_TestOk ok) async {
    final repo = ref.read(printerConnectionRepositoryProvider);
    final printers = ref.read(printersProvider).value ?? const [];
    await repo.add(
      name: _name.text.trim().isEmpty ? 'Bambu' : _name.text.trim(),
      host: _config.host,
      serial: _config.serial,
      accessCode: _config.accessCode,
      printerId: _printerTouched ? _printerId : printers.firstOrNull?.id,
      certSha256: ok.certSha256,
    );
    await ref.read(printNotifierProvider).requestPermission();
    if (mounted) context.pop();
  }

  void _next() {
    if (_step == 2 && !_form.currentState!.validate()) return;
    setState(() {
      _step++;
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final (title, text, illustration) = switch (_step) {
      0 => (l.wz1Title, l.wz1Text, const _PrinterScreenArt(step: 0)),
      1 => (l.wz2Title, l.wz2Text, const _PrinterScreenArt(step: 1)),
      2 => (l.wz3Title, l.wz3Text, const _PrinterScreenArt(step: 2)),
      _ => (l.wz4Title, l.wz4Text, const _NetworkArt()),
    };
    return Scaffold(
      appBar: AppBar(title: Text(l.wzTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l.wzStep(_step + 1), style: theme.textTheme.labelLarge),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: (_step + 1) / 4),
          const SizedBox(height: 16),
          Center(child: illustration),
          const SizedBox(height: 16),
          Text(title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(text),
          const SizedBox(height: 16),
          if (_step == 2) _fields(l),
          if (_step == 3) _testPanel(l, theme),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (_step > 0)
                TextButton(
                  onPressed: () => setState(() {
                    _step--;
                    _result = null;
                  }),
                  child: Text(l.back),
                ),
              const Spacer(),
              if (_step < 3)
                FilledButton(
                  key: const Key('wizard.next'),
                  onPressed: _next,
                  child: Text(l.next),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fields(AppLocalizations l) {
    final printers = ref.watch(printersProvider).value ?? const [];
    const gap = SizedBox(height: 12);
    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            controller: _name,
            decoration: InputDecoration(labelText: l.wzName),
          ),
          gap,
          TextFormField(
            key: const Key('wizard.ip'),
            controller: _ip,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l.wzIp,
              hintText: '192.168.0.50',
              suffixIcon: HelpButton(title: l.wzIp, text: l.wzHelpIp),
            ),
            validator: (v) {
              final a = InternetAddress.tryParse((v ?? '').trim());
              return a == null ? l.wzInvalidIp : null;
            },
          ),
          gap,
          TextFormField(
            key: const Key('wizard.serial'),
            controller: _serial,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: l.wzSerial,
              suffixIcon: HelpButton(title: l.wzSerial, text: l.wzHelpSerial),
            ),
            validator: (v) =>
                (v ?? '').trim().length < 6 ? l.requiredField : null,
          ),
          gap,
          TextFormField(
            key: const Key('wizard.code'),
            controller: _code,
            obscureText: !_showCode,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              labelText: l.wzCode,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: l.wzShowCode,
                    icon: Icon(
                      _showCode ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => _showCode = !_showCode),
                  ),
                  HelpButton(title: l.wzCode, text: l.wzHelpCode),
                ],
              ),
            ),
            validator: (v) =>
                RegExp(r'^[A-Za-z0-9]{8}$').hasMatch((v ?? '').trim())
                ? null
                : l.wzInvalidCode,
          ),
          gap,
          DropdownButtonFormField<int?>(
            initialValue: _printerId ?? printers.firstOrNull?.id,
            isExpanded: true,
            decoration: InputDecoration(labelText: l.wzLinkedPrinter),
            items: [
              for (final p in printers)
                DropdownMenuItem(value: p.id, child: Text(p.name)),
              DropdownMenuItem(child: Text(l.wzLinkedNone)),
            ],
            onChanged: (v) {
              _printerId = v;
              _printerTouched = true;
            },
          ),
        ],
      ),
    );
  }

  Widget _testPanel(AppLocalizations l, ThemeData theme) {
    final r = _result;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.tonalIcon(
          key: const Key('wizard.test'),
          onPressed: r is _Testing ? null : _test,
          icon: r is _Testing
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.wifi_find),
          label: Text(r is _Testing ? l.wzTesting : l.wzTest),
        ),
        const SizedBox(height: 16),
        switch (r) {
          _TestOk(:final status) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: theme.colorScheme.primaryContainer,
                child: ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text(
                    l.wzSuccess(printStateLabel(l, status.state)),
                    key: const Key('wizard.success'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                key: const Key('wizard.save'),
                onPressed: () => _save(r),
                child: Text(l.wzSave),
              ),
            ],
          ),
          _TestFailed(:final error, :final detail) => Card(
            key: const Key('wizard.error'),
            color: theme.colorScheme.errorContainer,
            child: ListTile(
              leading: const Icon(Icons.error_outline),
              title: Text(
                connectionErrorMessage(
                  l,
                  error,
                  host: _config.host,
                  detail: detail,
                ),
              ),
            ),
          ),
          _ => const SizedBox(),
        },
      ],
    );
  }
}

/// Stylized printer touch screen highlighting what to tap at each step.
class _PrinterScreenArt extends StatelessWidget {
  const _PrinterScreenArt({required this.step});
  final int step;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;
    Widget row(
      IconData icon,
      String label, {
      Widget? trailing,
      bool hi = false,
    }) => Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: hi ? accent.withValues(alpha: 0.25) : Colors.white10,
        borderRadius: BorderRadius.circular(6),
        border: hi ? Border.all(color: accent, width: 2) : null,
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          ?trailing,
        ],
      ),
    );
    Widget toggle(bool on) => Icon(
      on ? Icons.toggle_on : Icons.toggle_off,
      color: on ? const Color(0xFF00C853) : Colors.white38,
      size: 28,
    );
    Widget value(String v) => Text(
      v,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'monospace',
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );

    final rows = switch (step) {
      0 => [
        row(Icons.wifi, 'WLAN'),
        row(
          Icons.lan_outlined,
          'LAN Only Mode',
          trailing: toggle(true),
          hi: true,
        ),
        row(Icons.developer_mode, 'Developer Mode', trailing: toggle(false)),
      ],
      1 => [
        row(Icons.lan_outlined, 'LAN Only Mode', trailing: toggle(true)),
        row(
          Icons.developer_mode,
          'Developer Mode',
          trailing: toggle(true),
          hi: true,
        ),
      ],
      _ => [
        row(
          Icons.router_outlined,
          'IP',
          trailing: value('192.168.0.50'),
          hi: true,
        ),
        row(Icons.key, 'Access Code', trailing: value('1a2b3c4d'), hi: true),
        row(Icons.qr_code, 'SN', trailing: value('01P00A…'), hi: true),
      ],
    };
    return Semantics(
      image: true,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2328),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF3A3F45), width: 6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.settings, size: 16, color: Colors.white70),
                const SizedBox(width: 6),
                Text(
                  step == 2 ? 'Network' : 'Settings › WLAN',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...rows,
          ],
        ),
      ),
    );
  }
}

/// Phone and printer on the same Wi-Fi.
class _NetworkArt extends StatelessWidget {
  const _NetworkArt();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return Semantics(
      image: true,
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.smartphone, size: 56, color: c.primary),
            const SizedBox(width: 12),
            Icon(Icons.more_horiz, color: c.outline),
            Icon(Icons.wifi, size: 48, color: c.tertiary),
            Icon(Icons.more_horiz, color: c.outline),
            const SizedBox(width: 12),
            Icon(Icons.print, size: 56, color: c.primary),
          ],
        ),
      ),
    );
  }
}

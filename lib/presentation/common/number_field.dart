import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import 'help_button.dart';

/// Numeric text field with a "?" help button and forgiving decimal parsing.
class NumberField extends StatelessWidget {
  const NumberField({
    required this.controller,
    required this.label,
    required this.parse,
    this.help,
    this.prefix,
    this.suffix,
    this.required = true,
    this.positive = false,
    this.decimal = true,
    this.onChanged,
    this.fieldKey,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? help;
  final String? prefix;
  final String? suffix;

  /// Returns the parsed scaled integer or null when invalid.
  final int? Function(String) parse;
  final bool required;
  final bool positive;
  final bool decimal;
  final ValueChanged<String>? onChanged;
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return TextFormField(
      key: fieldKey,
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefix == null ? null : '$prefix ',
        suffixText: suffix,
        suffixIcon: help == null ? null : HelpButton(title: label, text: help!),
      ),
      validator: (text) {
        final t = text?.trim() ?? '';
        if (t.isEmpty) return required ? l.requiredField : null;
        final v = parse(t);
        if (v == null) return l.invalidNumber;
        if (positive && v <= 0) return l.mustBePositive;
        return null;
      },
    );
  }
}

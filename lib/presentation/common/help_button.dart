import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';

/// Small "?" that explains a field in plain words.
class HelpButton extends StatelessWidget {
  const HelpButton({required this.title, required this.text, super.key});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return IconButton(
      icon: const Icon(Icons.help_outline),
      tooltip: '${l.help}: $title',
      visualDensity: VisualDensity.compact,
      onPressed: () {
        // Otherwise the field regains focus and reopens the keyboard.
        FocusManager.instance.primaryFocus?.unfocus();
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l.ok),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/generated/app_localizations.dart';
import 'async_view.dart';

/// Whether [text] is a web link the app is willing to open.
bool isWebLink(String text) {
  final uri = Uri.tryParse(text.trim());
  return uri != null && uri.scheme == 'https' && uri.host.isNotEmpty;
}

/// Opens [url] in the browser, or tells the user it could not.
Future<void> openLink(BuildContext context, String url) async {
  var opened = false;
  if (isWebLink(url)) {
    try {
      opened = await launchUrl(
        Uri.parse(url.trim()),
        mode: LaunchMode.externalApplication,
      );
    } on Exception {
      opened = false;
    }
  }
  if (!opened && context.mounted) {
    showSnack(context, AppLocalizations.of(context).openLinkFailed);
  }
}

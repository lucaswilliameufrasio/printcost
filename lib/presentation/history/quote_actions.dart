import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../data/pdf/quote_pdf.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/formatters.dart';
import '../common/share.dart';
import '../providers.dart';

/// Asks for the customer name, builds the quote PDF and shares it.
Future<void> shareQuotePdf(
  BuildContext context,
  WidgetRef ref,
  List<JobRow> jobs,
) async {
  if (jobs.isEmpty) return;
  final l = AppLocalizations.of(context);
  final fmt = Formatters.of(context, ref);
  final controller = TextEditingController(
    text: jobs.map((j) => j.customer).whereType<String>().firstOrNull ?? '',
  );
  final customer = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l.generatePdf),
      content: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(labelText: l.pdfCustomerPrompt),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: Text(l.createQuote),
        ),
      ],
    ),
  );
  controller.dispose();
  if (customer == null) return;

  try {
    final settings = await ref.read(catalogRepositoryProvider).settings();
    final now = DateTime.now();
    final bytes = await buildQuotePdf(
      QuoteData(
        shopName: settings.shopName,
        shopContact: settings.shopContact,
        logo: settings.shopLogo,
        customer: customer,
        dateText: fmt.date(now),
        items: [
          for (final j in jobs)
            QuoteItem(
              name: j.name,
              quantity: j.quantity,
              unitPriceCents: j.priceCents,
            ),
        ],
      ),
      QuoteLabels(
        title: l.pdfQuoteTitle,
        item: l.pdfItem,
        qty: l.pdfQty,
        unit: l.pdfUnit,
        subtotal: l.pdfSubtotal,
        total: l.pdfTotal,
        customer: l.pdfCustomer,
        date: l.pdfDate,
        validity: l.pdfValidity,
      ),
      fmt.money,
    );
    final safeCustomer = customer.replaceAll(RegExp(r'[^\w\- ]'), '').trim();
    await shareBytes(
      bytes,
      fileName:
          '${l.pdfQuoteTitle}${safeCustomer.isEmpty ? '' : ' - $safeCustomer'}.pdf',
      mimeType: 'application/pdf',
    );
  } on Exception catch (e) {
    if (context.mounted) showSnack(context, l.unexpectedError('$e'));
  }
}

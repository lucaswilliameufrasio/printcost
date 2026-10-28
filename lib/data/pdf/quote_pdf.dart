import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class QuoteItem {
  const QuoteItem({
    required this.name,
    required this.quantity,
    required this.unitPriceCents,
  });
  final String name;
  final int quantity;
  final int unitPriceCents;
  int get totalCents => unitPriceCents * quantity;
}

/// Already-translated labels, so the PDF code has no Flutter dependency.
class QuoteLabels {
  const QuoteLabels({
    required this.title,
    required this.item,
    required this.qty,
    required this.unit,
    required this.subtotal,
    required this.total,
    required this.customer,
    required this.date,
    required this.validity,
  });
  final String title;
  final String item;
  final String qty;
  final String unit;
  final String subtotal;
  final String total;
  final String customer;
  final String date;
  final String validity;
}

class QuoteData {
  const QuoteData({
    required this.shopName,
    required this.items,
    required this.dateText,
    this.shopContact = '',
    this.customer,
    this.logo,
  });
  final String shopName;
  final String shopContact;
  final Uint8List? logo;
  final String? customer;
  final String dateText;
  final List<QuoteItem> items;
  int get totalCents => items.fold(0, (s, i) => s + i.totalCents);
}

/// Builds the quote PDF. [money] formats cents for display.
Future<Uint8List> buildQuotePdf(
  QuoteData data,
  QuoteLabels labels,
  String Function(int cents) money,
) {
  final doc = pw.Document(title: labels.title, creator: 'PrintCost');
  const accent = PdfColor.fromInt(0xFF00796B);
  final logo = data.logo == null ? null : pw.MemoryImage(data.logo!);

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (context) => [
        pw.Row(
          children: [
            if (logo != null)
              pw.Padding(
                padding: const pw.EdgeInsets.only(right: 16),
                child: pw.Image(logo, height: 56),
              ),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (data.shopName.isNotEmpty)
                    pw.Text(
                      data.shopName,
                      style: const pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  if (data.shopContact.isNotEmpty) pw.Text(data.shopContact),
                ],
              ),
            ),
            pw.Text(
              labels.title,
              style: const pw.TextStyle(
                fontSize: 24,
                color: accent,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 24),
        if (data.customer != null && data.customer!.isNotEmpty)
          pw.Text('${labels.customer}: ${data.customer}'),
        pw.Text('${labels.date}: ${data.dateText}'),
        pw.SizedBox(height: 16),
        pw.TableHelper.fromTextArray(
          headers: [labels.item, labels.qty, labels.unit, labels.subtotal],
          data: [
            for (final i in data.items)
              [
                i.name,
                '${i.quantity}',
                money(i.unitPriceCents),
                money(i.totalCents),
              ],
          ],
          headerDecoration: const pw.BoxDecoration(color: accent),
          headerStyle: const pw.TextStyle(
            color: PdfColors.white,
            fontWeight: pw.FontWeight.bold,
          ),
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.center,
            2: pw.Alignment.centerRight,
            3: pw.Alignment.centerRight,
          },
          columnWidths: {
            0: const pw.FlexColumnWidth(4),
            1: const pw.FlexColumnWidth(),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
          },
        ),
        pw.SizedBox(height: 12),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            '${labels.total}: ${money(data.totalCents)}',
            style: const pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.SizedBox(height: 32),
        pw.Text(
          labels.validity,
          style: const pw.TextStyle(color: PdfColors.grey700),
        ),
      ],
    ),
  );
  return doc.save();
}

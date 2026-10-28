import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/data/pdf/quote_pdf.dart';

void main() {
  test('builds a PDF with accented labels', () async {
    final bytes = await buildQuotePdf(
      const QuoteData(
        shopName: 'Ateliê da Impressão',
        shopContact: '@atelie',
        customer: 'João',
        dateText: '28/10/2026',
        items: [
          QuoteItem(name: 'Vaso espiral', quantity: 2, unitPriceCents: 4390),
          QuoteItem(name: 'Chaveiro', quantity: 10, unitPriceCents: 590),
        ],
      ),
      const QuoteLabels(
        title: 'Orçamento',
        item: 'Item',
        qty: 'Qtd.',
        unit: 'Unitário',
        subtotal: 'Subtotal',
        total: 'Total',
        customer: 'Cliente',
        date: 'Data',
        validity: 'Orçamento válido por 7 dias.',
      ),
      (c) => 'R\$ ${c ~/ 100},${(c % 100).toString().padLeft(2, '0')}',
    );
    expect(String.fromCharCodes(bytes.sublist(0, 5)), '%PDF-');
    expect(bytes.length, greaterThan(1000));
  });

  test('total sums quantity × unit price', () {
    const data = QuoteData(
      shopName: '',
      dateText: '',
      items: [
        QuoteItem(name: 'a', quantity: 2, unitPriceCents: 4390),
        QuoteItem(name: 'b', quantity: 10, unitPriceCents: 590),
      ],
    );
    expect(data.totalCents, 8780 + 5900);
  });
}

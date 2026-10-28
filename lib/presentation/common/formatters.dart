import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/format/scaled_decimal.dart';
import '../providers.dart';

const supportedCurrencies = ['BRL', 'USD', 'EUR', 'GBP', 'ARS', 'MXN', 'CLP'];

/// Display formatting. Money stays an integer of cents all the way: the
/// integer part is grouped with intl and the cents appended as text, so no
/// `double` is involved.
class Formatters {
  Formatters({required this.locale, required this.currencyCode})
    : _symbols = NumberFormat.decimalPattern(locale),
      _currencySymbol = NumberFormat.simpleCurrency(
        locale: locale,
        name: currencyCode,
      ).currencySymbol;

  factory Formatters.of(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(settingsProvider).value?.currencyCode ?? 'BRL';
    return Formatters(
      locale: Localizations.localeOf(context).toLanguageTag(),
      currencyCode: currency,
    );
  }

  final String locale;
  final String currencyCode;
  final NumberFormat _symbols;
  final String _currencySymbol;

  String get decimalSeparator => _symbols.symbols.DECIMAL_SEP;
  String get currencySymbol => _currencySymbol;

  String _grouped(int value) => _symbols.format(value);

  /// `1234567` -> `R$ 12.345,67` / `$12,345.67`.
  String money(int cents) {
    final negative = cents < 0;
    final abs = cents.abs();
    final body =
        '${_grouped(abs ~/ 100)}$decimalSeparator${(abs % 100).toString().padLeft(2, '0')}';
    final space = decimalSeparator == ',' ? ' ' : '';
    return '${negative ? '-' : ''}$_currencySymbol$space$body';
  }

  /// Basis points -> `30%`, `12,5%`.
  String percent(int bp) =>
      '${formatScaled(bp, scale: Scales.percent, decimalSeparator: decimalSeparator, trimZeros: true)}%';

  /// Milligrams -> `12,34 g` or `1,2 kg`.
  String weight(int mg) {
    if (mg.abs() >= 1000000) {
      return '${formatScaled(_roundDiv(mg, 1000), scale: 3, decimalSeparator: decimalSeparator, trimZeros: true)} kg';
    }
    // grams with up to 2 decimals
    final centigrams = _roundDiv(mg, 10);
    return '${formatScaled(centigrams, scale: 2, decimalSeparator: decimalSeparator, trimZeros: true)} g';
  }

  static int _roundDiv(int v, int d) =>
      v >= 0 ? (v + d ~/ 2) ~/ d : -((-v + d ~/ 2) ~/ d);

  String duration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h == 0) return '${m}min';
    return '${h}h ${m.toString().padLeft(2, '0')}min';
  }

  String date(DateTime d) => DateFormat.yMd(locale).format(d);

  String monthShort(int year, int month) =>
      DateFormat('MMM/yy', locale).format(DateTime(year, month));

  /// For prefilling input fields.
  String input(int value, int scale) => formatScaled(
    value,
    scale: scale,
    decimalSeparator: decimalSeparator,
    trimZeros: true,
  );

  int? parse(String text, int scale) =>
      parseScaled(text, scale: scale, decimalSeparator: decimalSeparator);
}

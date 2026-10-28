/// Parsing and formatting of decimal numbers stored as scaled integers.
///
/// Money is stored in cents (scale 2), percentages in basis points
/// (scale 2 of a percent), weights in milligrams (scale 3 of a gram) and the
/// kWh price in ten-thousandths (scale 4). This keeps every stored value an
/// exact integer.
library;

/// Scale constants for the stored units.
abstract final class Scales {
  static const money = 2;
  static const percent = 2;
  static const grams = 3;
  static const kwhPrice = 4;
}

int pow10(int exp) {
  var r = 1;
  for (var i = 0; i < exp; i++) {
    r *= 10;
  }
  return r;
}

/// Parses user input such as `1.234,56`, `1234.56`, `R$ 12,9` or `0,5` into
/// an integer with [scale] decimal places (e.g. scale 2: `12,9` -> `1290`).
///
/// Accepts both `,` and `.` as decimal separator so it is forgiving with
/// different keyboards:
/// * when both appear, the last one is the decimal separator;
/// * a separator that appears more than once is a grouping separator;
/// * a single [decimalSeparator] is the decimal separator;
/// * a single other separator followed by exactly three digits is treated as
///   grouping (`1.234` in pt-BR), otherwise as decimal (`0.5`).
///
/// Extra decimal places beyond [scale] are rounded half-up.
/// Returns `null` when the text is not a number.
int? parseScaled(
  String text, {
  required int scale,
  String decimalSeparator = ',',
  bool allowNegative = false,
}) {
  var s = text.trim().replaceAll(RegExp(r'[^0-9,.\-]'), '');
  if (s.isEmpty) return null;
  var negative = false;
  if (s.startsWith('-')) {
    if (!allowNegative) return null;
    negative = true;
    s = s.substring(1);
  }
  if (s.contains('-') || s.isEmpty) return null;

  final commas = ','.allMatches(s).length;
  final dots = '.'.allMatches(s).length;
  String? decimalSep;
  if (commas > 0 && dots > 0) {
    decimalSep = s.lastIndexOf(',') > s.lastIndexOf('.') ? ',' : '.';
    final groupingSep = decimalSep == ',' ? '.' : ',';
    if (decimalSep.allMatches(s).length > 1) return null;
    final intWithGroups = s.substring(0, s.lastIndexOf(decimalSep));
    if (!_validGrouping(intWithGroups, groupingSep)) return null;
    s = s.replaceAll(groupingSep, '');
  } else if (commas + dots == 1) {
    final sep = commas == 1 ? ',' : '.';
    final digitsAfter = s.length - s.indexOf(sep) - 1;
    if (sep != decimalSeparator && digitsAfter == 3) {
      s = s.replaceAll(sep, '');
    } else {
      decimalSep = sep;
    }
  } else if (commas + dots > 1) {
    // Only one kind of separator, repeated: grouping (e.g. 1.234.567).
    if (!_validGrouping(s, commas > 0 ? ',' : '.')) return null;
    s = s.replaceAll(RegExp('[,.]'), '');
  }

  var intPart = s;
  var fracPart = '';
  if (decimalSep != null) {
    final idx = s.indexOf(decimalSep);
    intPart = s.substring(0, idx);
    fracPart = s.substring(idx + 1);
  }
  if (intPart.isEmpty) intPart = '0';
  if (!RegExp(r'^\d+$').hasMatch(intPart) ||
      (fracPart.isNotEmpty && !RegExp(r'^\d+$').hasMatch(fracPart))) {
    return null;
  }
  if (intPart.length > 15) return null;

  var roundUp = false;
  if (fracPart.length > scale) {
    roundUp = fracPart.codeUnitAt(scale) >= '5'.codeUnitAt(0);
    fracPart = fracPart.substring(0, scale);
  }
  fracPart = fracPart.padRight(scale, '0');
  var value =
      int.parse(intPart) * pow10(scale) +
      (fracPart.isEmpty ? 0 : int.parse(fracPart));
  if (roundUp) value += 1;
  return negative ? -value : value;
}

bool _validGrouping(String intPart, String sep) =>
    RegExp('^\\d{1,3}(${RegExp.escape(sep)}\\d{3})*\$').hasMatch(intPart);

/// Formats a scaled integer for an input field (no grouping), e.g.
/// `formatScaled(1290, scale: 2)` -> `12,90`.
///
/// With [trimZeros], trailing fractional zeros are removed (`12,5`, `12`).
String formatScaled(
  int value, {
  required int scale,
  String decimalSeparator = ',',
  bool trimZeros = false,
}) {
  final negative = value < 0;
  final abs = value.abs();
  final factor = pow10(scale);
  final intPart = abs ~/ factor;
  var frac = scale == 0 ? '' : (abs % factor).toString().padLeft(scale, '0');
  if (trimZeros) frac = frac.replaceFirst(RegExp(r'0+$'), '');
  final sign = negative ? '-' : '';
  return frac.isEmpty ? '$sign$intPart' : '$sign$intPart$decimalSeparator$frac';
}

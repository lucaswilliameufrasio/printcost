import 'dart:convert';
import 'dart:typed_data';

/// Encodes rows as CSV (RFC 4180 quoting) with a UTF-8 BOM so spreadsheet
/// apps detect the encoding. Use `;` where the decimal separator is a comma.
Uint8List encodeCsv(List<List<String>> rows, {String separator = ','}) {
  String cell(String v) {
    final needsQuotes =
        v.contains(separator) ||
        v.contains('"') ||
        v.contains('\n') ||
        v.contains('\r');
    return needsQuotes ? '"${v.replaceAll('"', '""')}"' : v;
  }

  final text = rows.map((r) => r.map(cell).join(separator)).join('\r\n');
  return Uint8List.fromList([0xEF, 0xBB, 0xBF, ...utf8.encode('$text\r\n')]);
}

/// Free text typed by the user (names, customers). A leading `=`, `+`, `-`
/// or `@` would run as a formula in spreadsheet apps, so it is escaped.
String csvText(String v) =>
    v.isNotEmpty && '=+-@\t\r'.contains(v[0]) ? "'$v" : v;

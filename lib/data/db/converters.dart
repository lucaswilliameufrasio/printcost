import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/pricing/cost_calculator.dart';

/// Stores fee tiers as `[{"min":0,"bp":2000,"fixed":450}, ...]`.
class FeeTiersConverter extends TypeConverter<List<FeeTier>, String> {
  const FeeTiersConverter();

  @override
  List<FeeTier> fromSql(String fromDb) {
    final list = jsonDecode(fromDb) as List<Object?>;
    return normalizeTiers([
      for (final item in list.whereType<Map<String, Object?>>())
        FeeTier(
          minPriceCents: (item['min'] as int?) ?? 0,
          feeBp: (item['bp'] as int?) ?? 0,
          fixedCents: (item['fixed'] as int?) ?? 0,
        ),
    ]);
  }

  @override
  String toSql(List<FeeTier> value) => jsonEncode([
    for (final t in normalizeTiers(value))
      {'min': t.minPriceCents, 'bp': t.feeBp, 'fixed': t.fixedCents},
  ]);
}

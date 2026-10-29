// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FilamentsTable extends Filaments
    with TableInfo<$FilamentsTable, FilamentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilamentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materialMeta = const VerificationMeta(
    'material',
  );
  @override
  late final GeneratedColumn<String> material = GeneratedColumn<String>(
    'material',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorNameMeta = const VerificationMeta(
    'colorName',
  );
  @override
  late final GeneratedColumn<String> colorName = GeneratedColumn<String>(
    'color_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _colorArgbMeta = const VerificationMeta(
    'colorArgb',
  );
  @override
  late final GeneratedColumn<int> colorArgb = GeneratedColumn<int>(
    'color_argb',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rollPriceCentsMeta = const VerificationMeta(
    'rollPriceCents',
  );
  @override
  late final GeneratedColumn<int> rollPriceCents = GeneratedColumn<int>(
    'roll_price_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rollWeightGramsMeta = const VerificationMeta(
    'rollWeightGrams',
  );
  @override
  late final GeneratedColumn<int> rollWeightGrams = GeneratedColumn<int>(
    'roll_weight_grams',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1000),
  );
  static const VerificationMeta _stockMgMeta = const VerificationMeta(
    'stockMg',
  );
  @override
  late final GeneratedColumn<int> stockMg = GeneratedColumn<int>(
    'stock_mg',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lowStockAlertMgMeta = const VerificationMeta(
    'lowStockAlertMg',
  );
  @override
  late final GeneratedColumn<int> lowStockAlertMg = GeneratedColumn<int>(
    'low_stock_alert_mg',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100000),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brand,
    material,
    colorName,
    colorArgb,
    rollPriceCents,
    rollWeightGrams,
    stockMg,
    lowStockAlertMg,
    archived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'filaments';
  @override
  VerificationContext validateIntegrity(
    Insertable<FilamentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('material')) {
      context.handle(
        _materialMeta,
        material.isAcceptableOrUnknown(data['material']!, _materialMeta),
      );
    } else if (isInserting) {
      context.missing(_materialMeta);
    }
    if (data.containsKey('color_name')) {
      context.handle(
        _colorNameMeta,
        colorName.isAcceptableOrUnknown(data['color_name']!, _colorNameMeta),
      );
    }
    if (data.containsKey('color_argb')) {
      context.handle(
        _colorArgbMeta,
        colorArgb.isAcceptableOrUnknown(data['color_argb']!, _colorArgbMeta),
      );
    }
    if (data.containsKey('roll_price_cents')) {
      context.handle(
        _rollPriceCentsMeta,
        rollPriceCents.isAcceptableOrUnknown(
          data['roll_price_cents']!,
          _rollPriceCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rollPriceCentsMeta);
    }
    if (data.containsKey('roll_weight_grams')) {
      context.handle(
        _rollWeightGramsMeta,
        rollWeightGrams.isAcceptableOrUnknown(
          data['roll_weight_grams']!,
          _rollWeightGramsMeta,
        ),
      );
    }
    if (data.containsKey('stock_mg')) {
      context.handle(
        _stockMgMeta,
        stockMg.isAcceptableOrUnknown(data['stock_mg']!, _stockMgMeta),
      );
    } else if (isInserting) {
      context.missing(_stockMgMeta);
    }
    if (data.containsKey('low_stock_alert_mg')) {
      context.handle(
        _lowStockAlertMgMeta,
        lowStockAlertMg.isAcceptableOrUnknown(
          data['low_stock_alert_mg']!,
          _lowStockAlertMgMeta,
        ),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FilamentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilamentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      material: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material'],
      )!,
      colorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_name'],
      )!,
      colorArgb: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_argb'],
      ),
      rollPriceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}roll_price_cents'],
      )!,
      rollWeightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}roll_weight_grams'],
      )!,
      stockMg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_mg'],
      )!,
      lowStockAlertMg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}low_stock_alert_mg'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FilamentsTable createAlias(String alias) {
    return $FilamentsTable(attachedDatabase, alias);
  }
}

class FilamentRow extends DataClass implements Insertable<FilamentRow> {
  final int id;
  final String brand;
  final String material;
  final String colorName;

  /// ARGB color for the swatch, optional.
  final int? colorArgb;
  final int rollPriceCents;
  final int rollWeightGrams;
  final int stockMg;
  final int lowStockAlertMg;
  final bool archived;
  final DateTime createdAt;
  const FilamentRow({
    required this.id,
    required this.brand,
    required this.material,
    required this.colorName,
    this.colorArgb,
    required this.rollPriceCents,
    required this.rollWeightGrams,
    required this.stockMg,
    required this.lowStockAlertMg,
    required this.archived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brand'] = Variable<String>(brand);
    map['material'] = Variable<String>(material);
    map['color_name'] = Variable<String>(colorName);
    if (!nullToAbsent || colorArgb != null) {
      map['color_argb'] = Variable<int>(colorArgb);
    }
    map['roll_price_cents'] = Variable<int>(rollPriceCents);
    map['roll_weight_grams'] = Variable<int>(rollWeightGrams);
    map['stock_mg'] = Variable<int>(stockMg);
    map['low_stock_alert_mg'] = Variable<int>(lowStockAlertMg);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FilamentsCompanion toCompanion(bool nullToAbsent) {
    return FilamentsCompanion(
      id: Value(id),
      brand: Value(brand),
      material: Value(material),
      colorName: Value(colorName),
      colorArgb: colorArgb == null && nullToAbsent
          ? const Value.absent()
          : Value(colorArgb),
      rollPriceCents: Value(rollPriceCents),
      rollWeightGrams: Value(rollWeightGrams),
      stockMg: Value(stockMg),
      lowStockAlertMg: Value(lowStockAlertMg),
      archived: Value(archived),
      createdAt: Value(createdAt),
    );
  }

  factory FilamentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilamentRow(
      id: serializer.fromJson<int>(json['id']),
      brand: serializer.fromJson<String>(json['brand']),
      material: serializer.fromJson<String>(json['material']),
      colorName: serializer.fromJson<String>(json['colorName']),
      colorArgb: serializer.fromJson<int?>(json['colorArgb']),
      rollPriceCents: serializer.fromJson<int>(json['rollPriceCents']),
      rollWeightGrams: serializer.fromJson<int>(json['rollWeightGrams']),
      stockMg: serializer.fromJson<int>(json['stockMg']),
      lowStockAlertMg: serializer.fromJson<int>(json['lowStockAlertMg']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brand': serializer.toJson<String>(brand),
      'material': serializer.toJson<String>(material),
      'colorName': serializer.toJson<String>(colorName),
      'colorArgb': serializer.toJson<int?>(colorArgb),
      'rollPriceCents': serializer.toJson<int>(rollPriceCents),
      'rollWeightGrams': serializer.toJson<int>(rollWeightGrams),
      'stockMg': serializer.toJson<int>(stockMg),
      'lowStockAlertMg': serializer.toJson<int>(lowStockAlertMg),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FilamentRow copyWith({
    int? id,
    String? brand,
    String? material,
    String? colorName,
    Value<int?> colorArgb = const Value.absent(),
    int? rollPriceCents,
    int? rollWeightGrams,
    int? stockMg,
    int? lowStockAlertMg,
    bool? archived,
    DateTime? createdAt,
  }) => FilamentRow(
    id: id ?? this.id,
    brand: brand ?? this.brand,
    material: material ?? this.material,
    colorName: colorName ?? this.colorName,
    colorArgb: colorArgb.present ? colorArgb.value : this.colorArgb,
    rollPriceCents: rollPriceCents ?? this.rollPriceCents,
    rollWeightGrams: rollWeightGrams ?? this.rollWeightGrams,
    stockMg: stockMg ?? this.stockMg,
    lowStockAlertMg: lowStockAlertMg ?? this.lowStockAlertMg,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
  );
  FilamentRow copyWithCompanion(FilamentsCompanion data) {
    return FilamentRow(
      id: data.id.present ? data.id.value : this.id,
      brand: data.brand.present ? data.brand.value : this.brand,
      material: data.material.present ? data.material.value : this.material,
      colorName: data.colorName.present ? data.colorName.value : this.colorName,
      colorArgb: data.colorArgb.present ? data.colorArgb.value : this.colorArgb,
      rollPriceCents: data.rollPriceCents.present
          ? data.rollPriceCents.value
          : this.rollPriceCents,
      rollWeightGrams: data.rollWeightGrams.present
          ? data.rollWeightGrams.value
          : this.rollWeightGrams,
      stockMg: data.stockMg.present ? data.stockMg.value : this.stockMg,
      lowStockAlertMg: data.lowStockAlertMg.present
          ? data.lowStockAlertMg.value
          : this.lowStockAlertMg,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilamentRow(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('material: $material, ')
          ..write('colorName: $colorName, ')
          ..write('colorArgb: $colorArgb, ')
          ..write('rollPriceCents: $rollPriceCents, ')
          ..write('rollWeightGrams: $rollWeightGrams, ')
          ..write('stockMg: $stockMg, ')
          ..write('lowStockAlertMg: $lowStockAlertMg, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    brand,
    material,
    colorName,
    colorArgb,
    rollPriceCents,
    rollWeightGrams,
    stockMg,
    lowStockAlertMg,
    archived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilamentRow &&
          other.id == this.id &&
          other.brand == this.brand &&
          other.material == this.material &&
          other.colorName == this.colorName &&
          other.colorArgb == this.colorArgb &&
          other.rollPriceCents == this.rollPriceCents &&
          other.rollWeightGrams == this.rollWeightGrams &&
          other.stockMg == this.stockMg &&
          other.lowStockAlertMg == this.lowStockAlertMg &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt);
}

class FilamentsCompanion extends UpdateCompanion<FilamentRow> {
  final Value<int> id;
  final Value<String> brand;
  final Value<String> material;
  final Value<String> colorName;
  final Value<int?> colorArgb;
  final Value<int> rollPriceCents;
  final Value<int> rollWeightGrams;
  final Value<int> stockMg;
  final Value<int> lowStockAlertMg;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  const FilamentsCompanion({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    this.material = const Value.absent(),
    this.colorName = const Value.absent(),
    this.colorArgb = const Value.absent(),
    this.rollPriceCents = const Value.absent(),
    this.rollWeightGrams = const Value.absent(),
    this.stockMg = const Value.absent(),
    this.lowStockAlertMg = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FilamentsCompanion.insert({
    this.id = const Value.absent(),
    required String brand,
    required String material,
    this.colorName = const Value.absent(),
    this.colorArgb = const Value.absent(),
    required int rollPriceCents,
    this.rollWeightGrams = const Value.absent(),
    required int stockMg,
    this.lowStockAlertMg = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : brand = Value(brand),
       material = Value(material),
       rollPriceCents = Value(rollPriceCents),
       stockMg = Value(stockMg);
  static Insertable<FilamentRow> custom({
    Expression<int>? id,
    Expression<String>? brand,
    Expression<String>? material,
    Expression<String>? colorName,
    Expression<int>? colorArgb,
    Expression<int>? rollPriceCents,
    Expression<int>? rollWeightGrams,
    Expression<int>? stockMg,
    Expression<int>? lowStockAlertMg,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brand != null) 'brand': brand,
      if (material != null) 'material': material,
      if (colorName != null) 'color_name': colorName,
      if (colorArgb != null) 'color_argb': colorArgb,
      if (rollPriceCents != null) 'roll_price_cents': rollPriceCents,
      if (rollWeightGrams != null) 'roll_weight_grams': rollWeightGrams,
      if (stockMg != null) 'stock_mg': stockMg,
      if (lowStockAlertMg != null) 'low_stock_alert_mg': lowStockAlertMg,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FilamentsCompanion copyWith({
    Value<int>? id,
    Value<String>? brand,
    Value<String>? material,
    Value<String>? colorName,
    Value<int?>? colorArgb,
    Value<int>? rollPriceCents,
    Value<int>? rollWeightGrams,
    Value<int>? stockMg,
    Value<int>? lowStockAlertMg,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
  }) {
    return FilamentsCompanion(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      material: material ?? this.material,
      colorName: colorName ?? this.colorName,
      colorArgb: colorArgb ?? this.colorArgb,
      rollPriceCents: rollPriceCents ?? this.rollPriceCents,
      rollWeightGrams: rollWeightGrams ?? this.rollWeightGrams,
      stockMg: stockMg ?? this.stockMg,
      lowStockAlertMg: lowStockAlertMg ?? this.lowStockAlertMg,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (colorName.present) {
      map['color_name'] = Variable<String>(colorName.value);
    }
    if (colorArgb.present) {
      map['color_argb'] = Variable<int>(colorArgb.value);
    }
    if (rollPriceCents.present) {
      map['roll_price_cents'] = Variable<int>(rollPriceCents.value);
    }
    if (rollWeightGrams.present) {
      map['roll_weight_grams'] = Variable<int>(rollWeightGrams.value);
    }
    if (stockMg.present) {
      map['stock_mg'] = Variable<int>(stockMg.value);
    }
    if (lowStockAlertMg.present) {
      map['low_stock_alert_mg'] = Variable<int>(lowStockAlertMg.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilamentsCompanion(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('material: $material, ')
          ..write('colorName: $colorName, ')
          ..write('colorArgb: $colorArgb, ')
          ..write('rollPriceCents: $rollPriceCents, ')
          ..write('rollWeightGrams: $rollWeightGrams, ')
          ..write('stockMg: $stockMg, ')
          ..write('lowStockAlertMg: $lowStockAlertMg, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PrintersTable extends Printers
    with TableInfo<$PrintersTable, PrinterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrintersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _powerWattsMeta = const VerificationMeta(
    'powerWatts',
  );
  @override
  late final GeneratedColumn<int> powerWatts = GeneratedColumn<int>(
    'power_watts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _machineValueCentsMeta = const VerificationMeta(
    'machineValueCents',
  );
  @override
  late final GeneratedColumn<int> machineValueCents = GeneratedColumn<int>(
    'machine_value_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lifespanHoursMeta = const VerificationMeta(
    'lifespanHours',
  );
  @override
  late final GeneratedColumn<int> lifespanHours = GeneratedColumn<int>(
    'lifespan_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maintenancePerHourCentsMeta =
      const VerificationMeta('maintenancePerHourCents');
  @override
  late final GeneratedColumn<int> maintenancePerHourCents =
      GeneratedColumn<int>(
        'maintenance_per_hour_cents',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    powerWatts,
    machineValueCents,
    lifespanHours,
    maintenancePerHourCents,
    archived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'printers';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrinterRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('power_watts')) {
      context.handle(
        _powerWattsMeta,
        powerWatts.isAcceptableOrUnknown(data['power_watts']!, _powerWattsMeta),
      );
    } else if (isInserting) {
      context.missing(_powerWattsMeta);
    }
    if (data.containsKey('machine_value_cents')) {
      context.handle(
        _machineValueCentsMeta,
        machineValueCents.isAcceptableOrUnknown(
          data['machine_value_cents']!,
          _machineValueCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_machineValueCentsMeta);
    }
    if (data.containsKey('lifespan_hours')) {
      context.handle(
        _lifespanHoursMeta,
        lifespanHours.isAcceptableOrUnknown(
          data['lifespan_hours']!,
          _lifespanHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lifespanHoursMeta);
    }
    if (data.containsKey('maintenance_per_hour_cents')) {
      context.handle(
        _maintenancePerHourCentsMeta,
        maintenancePerHourCents.isAcceptableOrUnknown(
          data['maintenance_per_hour_cents']!,
          _maintenancePerHourCentsMeta,
        ),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrinterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrinterRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      powerWatts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}power_watts'],
      )!,
      machineValueCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}machine_value_cents'],
      )!,
      lifespanHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifespan_hours'],
      )!,
      maintenancePerHourCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maintenance_per_hour_cents'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PrintersTable createAlias(String alias) {
    return $PrintersTable(attachedDatabase, alias);
  }
}

class PrinterRow extends DataClass implements Insertable<PrinterRow> {
  final int id;
  final String name;
  final int powerWatts;
  final int machineValueCents;
  final int lifespanHours;
  final int maintenancePerHourCents;
  final bool archived;
  final DateTime createdAt;
  const PrinterRow({
    required this.id,
    required this.name,
    required this.powerWatts,
    required this.machineValueCents,
    required this.lifespanHours,
    required this.maintenancePerHourCents,
    required this.archived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['power_watts'] = Variable<int>(powerWatts);
    map['machine_value_cents'] = Variable<int>(machineValueCents);
    map['lifespan_hours'] = Variable<int>(lifespanHours);
    map['maintenance_per_hour_cents'] = Variable<int>(maintenancePerHourCents);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PrintersCompanion toCompanion(bool nullToAbsent) {
    return PrintersCompanion(
      id: Value(id),
      name: Value(name),
      powerWatts: Value(powerWatts),
      machineValueCents: Value(machineValueCents),
      lifespanHours: Value(lifespanHours),
      maintenancePerHourCents: Value(maintenancePerHourCents),
      archived: Value(archived),
      createdAt: Value(createdAt),
    );
  }

  factory PrinterRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrinterRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      powerWatts: serializer.fromJson<int>(json['powerWatts']),
      machineValueCents: serializer.fromJson<int>(json['machineValueCents']),
      lifespanHours: serializer.fromJson<int>(json['lifespanHours']),
      maintenancePerHourCents: serializer.fromJson<int>(
        json['maintenancePerHourCents'],
      ),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'powerWatts': serializer.toJson<int>(powerWatts),
      'machineValueCents': serializer.toJson<int>(machineValueCents),
      'lifespanHours': serializer.toJson<int>(lifespanHours),
      'maintenancePerHourCents': serializer.toJson<int>(
        maintenancePerHourCents,
      ),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PrinterRow copyWith({
    int? id,
    String? name,
    int? powerWatts,
    int? machineValueCents,
    int? lifespanHours,
    int? maintenancePerHourCents,
    bool? archived,
    DateTime? createdAt,
  }) => PrinterRow(
    id: id ?? this.id,
    name: name ?? this.name,
    powerWatts: powerWatts ?? this.powerWatts,
    machineValueCents: machineValueCents ?? this.machineValueCents,
    lifespanHours: lifespanHours ?? this.lifespanHours,
    maintenancePerHourCents:
        maintenancePerHourCents ?? this.maintenancePerHourCents,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
  );
  PrinterRow copyWithCompanion(PrintersCompanion data) {
    return PrinterRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      powerWatts: data.powerWatts.present
          ? data.powerWatts.value
          : this.powerWatts,
      machineValueCents: data.machineValueCents.present
          ? data.machineValueCents.value
          : this.machineValueCents,
      lifespanHours: data.lifespanHours.present
          ? data.lifespanHours.value
          : this.lifespanHours,
      maintenancePerHourCents: data.maintenancePerHourCents.present
          ? data.maintenancePerHourCents.value
          : this.maintenancePerHourCents,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrinterRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('powerWatts: $powerWatts, ')
          ..write('machineValueCents: $machineValueCents, ')
          ..write('lifespanHours: $lifespanHours, ')
          ..write('maintenancePerHourCents: $maintenancePerHourCents, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    powerWatts,
    machineValueCents,
    lifespanHours,
    maintenancePerHourCents,
    archived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrinterRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.powerWatts == this.powerWatts &&
          other.machineValueCents == this.machineValueCents &&
          other.lifespanHours == this.lifespanHours &&
          other.maintenancePerHourCents == this.maintenancePerHourCents &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt);
}

class PrintersCompanion extends UpdateCompanion<PrinterRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> powerWatts;
  final Value<int> machineValueCents;
  final Value<int> lifespanHours;
  final Value<int> maintenancePerHourCents;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  const PrintersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.powerWatts = const Value.absent(),
    this.machineValueCents = const Value.absent(),
    this.lifespanHours = const Value.absent(),
    this.maintenancePerHourCents = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PrintersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int powerWatts,
    required int machineValueCents,
    required int lifespanHours,
    this.maintenancePerHourCents = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       powerWatts = Value(powerWatts),
       machineValueCents = Value(machineValueCents),
       lifespanHours = Value(lifespanHours);
  static Insertable<PrinterRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? powerWatts,
    Expression<int>? machineValueCents,
    Expression<int>? lifespanHours,
    Expression<int>? maintenancePerHourCents,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (powerWatts != null) 'power_watts': powerWatts,
      if (machineValueCents != null) 'machine_value_cents': machineValueCents,
      if (lifespanHours != null) 'lifespan_hours': lifespanHours,
      if (maintenancePerHourCents != null)
        'maintenance_per_hour_cents': maintenancePerHourCents,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PrintersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? powerWatts,
    Value<int>? machineValueCents,
    Value<int>? lifespanHours,
    Value<int>? maintenancePerHourCents,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
  }) {
    return PrintersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      powerWatts: powerWatts ?? this.powerWatts,
      machineValueCents: machineValueCents ?? this.machineValueCents,
      lifespanHours: lifespanHours ?? this.lifespanHours,
      maintenancePerHourCents:
          maintenancePerHourCents ?? this.maintenancePerHourCents,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (powerWatts.present) {
      map['power_watts'] = Variable<int>(powerWatts.value);
    }
    if (machineValueCents.present) {
      map['machine_value_cents'] = Variable<int>(machineValueCents.value);
    }
    if (lifespanHours.present) {
      map['lifespan_hours'] = Variable<int>(lifespanHours.value);
    }
    if (maintenancePerHourCents.present) {
      map['maintenance_per_hour_cents'] = Variable<int>(
        maintenancePerHourCents.value,
      );
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrintersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('powerWatts: $powerWatts, ')
          ..write('machineValueCents: $machineValueCents, ')
          ..write('lifespanHours: $lifespanHours, ')
          ..write('maintenancePerHourCents: $maintenancePerHourCents, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('BRL'),
  );
  static const VerificationMeta _localeCodeMeta = const VerificationMeta(
    'localeCode',
  );
  @override
  late final GeneratedColumn<String> localeCode = GeneratedColumn<String>(
    'locale_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _kwhPriceMeta = const VerificationMeta(
    'kwhPrice',
  );
  @override
  late final GeneratedColumn<int> kwhPrice = GeneratedColumn<int>(
    'kwh_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9000),
  );
  static const VerificationMeta _laborHourCentsMeta = const VerificationMeta(
    'laborHourCents',
  );
  @override
  late final GeneratedColumn<int> laborHourCents = GeneratedColumn<int>(
    'labor_hour_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2500),
  );
  static const VerificationMeta _marketplaceFeeBpMeta = const VerificationMeta(
    'marketplaceFeeBp',
  );
  @override
  late final GeneratedColumn<int> marketplaceFeeBp = GeneratedColumn<int>(
    'marketplace_fee_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _taxBpMeta = const VerificationMeta('taxBp');
  @override
  late final GeneratedColumn<int> taxBp = GeneratedColumn<int>(
    'tax_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _defaultMarginBpMeta = const VerificationMeta(
    'defaultMarginBp',
  );
  @override
  late final GeneratedColumn<int> defaultMarginBp = GeneratedColumn<int>(
    'default_margin_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3000),
  );
  static const VerificationMeta _packagingCentsMeta = const VerificationMeta(
    'packagingCents',
  );
  @override
  late final GeneratedColumn<int> packagingCents = GeneratedColumn<int>(
    'packaging_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _defaultWasteBpMeta = const VerificationMeta(
    'defaultWasteBp',
  );
  @override
  late final GeneratedColumn<int> defaultWasteBp = GeneratedColumn<int>(
    'default_waste_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(500),
  );
  static const VerificationMeta _defaultFailureBpMeta = const VerificationMeta(
    'defaultFailureBp',
  );
  @override
  late final GeneratedColumn<int> defaultFailureBp = GeneratedColumn<int>(
    'default_failure_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(500),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PriceRounding, String>
  priceRounding = GeneratedColumn<String>(
    'price_rounding',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(PriceRounding.none.name),
  ).withConverter<PriceRounding>($AppSettingsTable.$converterpriceRounding);
  static const VerificationMeta _shopNameMeta = const VerificationMeta(
    'shopName',
  );
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
    'shop_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _shopContactMeta = const VerificationMeta(
    'shopContact',
  );
  @override
  late final GeneratedColumn<String> shopContact = GeneratedColumn<String>(
    'shop_contact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _shopLogoMeta = const VerificationMeta(
    'shopLogo',
  );
  @override
  late final GeneratedColumn<Uint8List> shopLogo = GeneratedColumn<Uint8List>(
    'shop_logo',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _printerModuleEnabledMeta =
      const VerificationMeta('printerModuleEnabled');
  @override
  late final GeneratedColumn<bool> printerModuleEnabled = GeneratedColumn<bool>(
    'printer_module_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("printer_module_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _onboardingDoneMeta = const VerificationMeta(
    'onboardingDone',
  );
  @override
  late final GeneratedColumn<bool> onboardingDone = GeneratedColumn<bool>(
    'onboarding_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _defaultChannelIdMeta = const VerificationMeta(
    'defaultChannelId',
  );
  @override
  late final GeneratedColumn<int> defaultChannelId = GeneratedColumn<int>(
    'default_channel_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currencyCode,
    localeCode,
    themeMode,
    kwhPrice,
    laborHourCents,
    marketplaceFeeBp,
    taxBp,
    defaultMarginBp,
    packagingCents,
    defaultWasteBp,
    defaultFailureBp,
    priceRounding,
    shopName,
    shopContact,
    shopLogo,
    printerModuleEnabled,
    onboardingDone,
    defaultChannelId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('locale_code')) {
      context.handle(
        _localeCodeMeta,
        localeCode.isAcceptableOrUnknown(data['locale_code']!, _localeCodeMeta),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('kwh_price')) {
      context.handle(
        _kwhPriceMeta,
        kwhPrice.isAcceptableOrUnknown(data['kwh_price']!, _kwhPriceMeta),
      );
    }
    if (data.containsKey('labor_hour_cents')) {
      context.handle(
        _laborHourCentsMeta,
        laborHourCents.isAcceptableOrUnknown(
          data['labor_hour_cents']!,
          _laborHourCentsMeta,
        ),
      );
    }
    if (data.containsKey('marketplace_fee_bp')) {
      context.handle(
        _marketplaceFeeBpMeta,
        marketplaceFeeBp.isAcceptableOrUnknown(
          data['marketplace_fee_bp']!,
          _marketplaceFeeBpMeta,
        ),
      );
    }
    if (data.containsKey('tax_bp')) {
      context.handle(
        _taxBpMeta,
        taxBp.isAcceptableOrUnknown(data['tax_bp']!, _taxBpMeta),
      );
    }
    if (data.containsKey('default_margin_bp')) {
      context.handle(
        _defaultMarginBpMeta,
        defaultMarginBp.isAcceptableOrUnknown(
          data['default_margin_bp']!,
          _defaultMarginBpMeta,
        ),
      );
    }
    if (data.containsKey('packaging_cents')) {
      context.handle(
        _packagingCentsMeta,
        packagingCents.isAcceptableOrUnknown(
          data['packaging_cents']!,
          _packagingCentsMeta,
        ),
      );
    }
    if (data.containsKey('default_waste_bp')) {
      context.handle(
        _defaultWasteBpMeta,
        defaultWasteBp.isAcceptableOrUnknown(
          data['default_waste_bp']!,
          _defaultWasteBpMeta,
        ),
      );
    }
    if (data.containsKey('default_failure_bp')) {
      context.handle(
        _defaultFailureBpMeta,
        defaultFailureBp.isAcceptableOrUnknown(
          data['default_failure_bp']!,
          _defaultFailureBpMeta,
        ),
      );
    }
    if (data.containsKey('shop_name')) {
      context.handle(
        _shopNameMeta,
        shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta),
      );
    }
    if (data.containsKey('shop_contact')) {
      context.handle(
        _shopContactMeta,
        shopContact.isAcceptableOrUnknown(
          data['shop_contact']!,
          _shopContactMeta,
        ),
      );
    }
    if (data.containsKey('shop_logo')) {
      context.handle(
        _shopLogoMeta,
        shopLogo.isAcceptableOrUnknown(data['shop_logo']!, _shopLogoMeta),
      );
    }
    if (data.containsKey('printer_module_enabled')) {
      context.handle(
        _printerModuleEnabledMeta,
        printerModuleEnabled.isAcceptableOrUnknown(
          data['printer_module_enabled']!,
          _printerModuleEnabledMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_done')) {
      context.handle(
        _onboardingDoneMeta,
        onboardingDone.isAcceptableOrUnknown(
          data['onboarding_done']!,
          _onboardingDoneMeta,
        ),
      );
    }
    if (data.containsKey('default_channel_id')) {
      context.handle(
        _defaultChannelIdMeta,
        defaultChannelId.isAcceptableOrUnknown(
          data['default_channel_id']!,
          _defaultChannelIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      localeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_code'],
      ),
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      kwhPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kwh_price'],
      )!,
      laborHourCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}labor_hour_cents'],
      )!,
      marketplaceFeeBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}marketplace_fee_bp'],
      )!,
      taxBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_bp'],
      )!,
      defaultMarginBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_margin_bp'],
      )!,
      packagingCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}packaging_cents'],
      )!,
      defaultWasteBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_waste_bp'],
      )!,
      defaultFailureBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_failure_bp'],
      )!,
      priceRounding: $AppSettingsTable.$converterpriceRounding.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}price_rounding'],
        )!,
      ),
      shopName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_name'],
      )!,
      shopContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_contact'],
      )!,
      shopLogo: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}shop_logo'],
      ),
      printerModuleEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}printer_module_enabled'],
      )!,
      onboardingDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_done'],
      )!,
      defaultChannelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_channel_id'],
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PriceRounding, String, String>
  $converterpriceRounding = const EnumNameConverter<PriceRounding>(
    PriceRounding.values,
  );
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final int id;
  final String currencyCode;

  /// `null` follows the device language.
  final String? localeCode;

  /// system | light | dark
  final String themeMode;
  final int kwhPrice;
  final int laborHourCents;
  final int marketplaceFeeBp;
  final int taxBp;
  final int defaultMarginBp;
  final int packagingCents;
  final int defaultWasteBp;
  final int defaultFailureBp;
  final PriceRounding priceRounding;
  final String shopName;
  final String shopContact;
  final Uint8List? shopLogo;
  final bool printerModuleEnabled;

  /// v3: first-run setup finished.
  final bool onboardingDone;

  /// v3: channel preselected in the calculator.
  final int? defaultChannelId;
  const SettingsRow({
    required this.id,
    required this.currencyCode,
    this.localeCode,
    required this.themeMode,
    required this.kwhPrice,
    required this.laborHourCents,
    required this.marketplaceFeeBp,
    required this.taxBp,
    required this.defaultMarginBp,
    required this.packagingCents,
    required this.defaultWasteBp,
    required this.defaultFailureBp,
    required this.priceRounding,
    required this.shopName,
    required this.shopContact,
    this.shopLogo,
    required this.printerModuleEnabled,
    required this.onboardingDone,
    this.defaultChannelId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency_code'] = Variable<String>(currencyCode);
    if (!nullToAbsent || localeCode != null) {
      map['locale_code'] = Variable<String>(localeCode);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    map['kwh_price'] = Variable<int>(kwhPrice);
    map['labor_hour_cents'] = Variable<int>(laborHourCents);
    map['marketplace_fee_bp'] = Variable<int>(marketplaceFeeBp);
    map['tax_bp'] = Variable<int>(taxBp);
    map['default_margin_bp'] = Variable<int>(defaultMarginBp);
    map['packaging_cents'] = Variable<int>(packagingCents);
    map['default_waste_bp'] = Variable<int>(defaultWasteBp);
    map['default_failure_bp'] = Variable<int>(defaultFailureBp);
    {
      map['price_rounding'] = Variable<String>(
        $AppSettingsTable.$converterpriceRounding.toSql(priceRounding),
      );
    }
    map['shop_name'] = Variable<String>(shopName);
    map['shop_contact'] = Variable<String>(shopContact);
    if (!nullToAbsent || shopLogo != null) {
      map['shop_logo'] = Variable<Uint8List>(shopLogo);
    }
    map['printer_module_enabled'] = Variable<bool>(printerModuleEnabled);
    map['onboarding_done'] = Variable<bool>(onboardingDone);
    if (!nullToAbsent || defaultChannelId != null) {
      map['default_channel_id'] = Variable<int>(defaultChannelId);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      currencyCode: Value(currencyCode),
      localeCode: localeCode == null && nullToAbsent
          ? const Value.absent()
          : Value(localeCode),
      themeMode: Value(themeMode),
      kwhPrice: Value(kwhPrice),
      laborHourCents: Value(laborHourCents),
      marketplaceFeeBp: Value(marketplaceFeeBp),
      taxBp: Value(taxBp),
      defaultMarginBp: Value(defaultMarginBp),
      packagingCents: Value(packagingCents),
      defaultWasteBp: Value(defaultWasteBp),
      defaultFailureBp: Value(defaultFailureBp),
      priceRounding: Value(priceRounding),
      shopName: Value(shopName),
      shopContact: Value(shopContact),
      shopLogo: shopLogo == null && nullToAbsent
          ? const Value.absent()
          : Value(shopLogo),
      printerModuleEnabled: Value(printerModuleEnabled),
      onboardingDone: Value(onboardingDone),
      defaultChannelId: defaultChannelId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultChannelId),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<int>(json['id']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      localeCode: serializer.fromJson<String?>(json['localeCode']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      kwhPrice: serializer.fromJson<int>(json['kwhPrice']),
      laborHourCents: serializer.fromJson<int>(json['laborHourCents']),
      marketplaceFeeBp: serializer.fromJson<int>(json['marketplaceFeeBp']),
      taxBp: serializer.fromJson<int>(json['taxBp']),
      defaultMarginBp: serializer.fromJson<int>(json['defaultMarginBp']),
      packagingCents: serializer.fromJson<int>(json['packagingCents']),
      defaultWasteBp: serializer.fromJson<int>(json['defaultWasteBp']),
      defaultFailureBp: serializer.fromJson<int>(json['defaultFailureBp']),
      priceRounding: $AppSettingsTable.$converterpriceRounding.fromJson(
        serializer.fromJson<String>(json['priceRounding']),
      ),
      shopName: serializer.fromJson<String>(json['shopName']),
      shopContact: serializer.fromJson<String>(json['shopContact']),
      shopLogo: serializer.fromJson<Uint8List?>(json['shopLogo']),
      printerModuleEnabled: serializer.fromJson<bool>(
        json['printerModuleEnabled'],
      ),
      onboardingDone: serializer.fromJson<bool>(json['onboardingDone']),
      defaultChannelId: serializer.fromJson<int?>(json['defaultChannelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'localeCode': serializer.toJson<String?>(localeCode),
      'themeMode': serializer.toJson<String>(themeMode),
      'kwhPrice': serializer.toJson<int>(kwhPrice),
      'laborHourCents': serializer.toJson<int>(laborHourCents),
      'marketplaceFeeBp': serializer.toJson<int>(marketplaceFeeBp),
      'taxBp': serializer.toJson<int>(taxBp),
      'defaultMarginBp': serializer.toJson<int>(defaultMarginBp),
      'packagingCents': serializer.toJson<int>(packagingCents),
      'defaultWasteBp': serializer.toJson<int>(defaultWasteBp),
      'defaultFailureBp': serializer.toJson<int>(defaultFailureBp),
      'priceRounding': serializer.toJson<String>(
        $AppSettingsTable.$converterpriceRounding.toJson(priceRounding),
      ),
      'shopName': serializer.toJson<String>(shopName),
      'shopContact': serializer.toJson<String>(shopContact),
      'shopLogo': serializer.toJson<Uint8List?>(shopLogo),
      'printerModuleEnabled': serializer.toJson<bool>(printerModuleEnabled),
      'onboardingDone': serializer.toJson<bool>(onboardingDone),
      'defaultChannelId': serializer.toJson<int?>(defaultChannelId),
    };
  }

  SettingsRow copyWith({
    int? id,
    String? currencyCode,
    Value<String?> localeCode = const Value.absent(),
    String? themeMode,
    int? kwhPrice,
    int? laborHourCents,
    int? marketplaceFeeBp,
    int? taxBp,
    int? defaultMarginBp,
    int? packagingCents,
    int? defaultWasteBp,
    int? defaultFailureBp,
    PriceRounding? priceRounding,
    String? shopName,
    String? shopContact,
    Value<Uint8List?> shopLogo = const Value.absent(),
    bool? printerModuleEnabled,
    bool? onboardingDone,
    Value<int?> defaultChannelId = const Value.absent(),
  }) => SettingsRow(
    id: id ?? this.id,
    currencyCode: currencyCode ?? this.currencyCode,
    localeCode: localeCode.present ? localeCode.value : this.localeCode,
    themeMode: themeMode ?? this.themeMode,
    kwhPrice: kwhPrice ?? this.kwhPrice,
    laborHourCents: laborHourCents ?? this.laborHourCents,
    marketplaceFeeBp: marketplaceFeeBp ?? this.marketplaceFeeBp,
    taxBp: taxBp ?? this.taxBp,
    defaultMarginBp: defaultMarginBp ?? this.defaultMarginBp,
    packagingCents: packagingCents ?? this.packagingCents,
    defaultWasteBp: defaultWasteBp ?? this.defaultWasteBp,
    defaultFailureBp: defaultFailureBp ?? this.defaultFailureBp,
    priceRounding: priceRounding ?? this.priceRounding,
    shopName: shopName ?? this.shopName,
    shopContact: shopContact ?? this.shopContact,
    shopLogo: shopLogo.present ? shopLogo.value : this.shopLogo,
    printerModuleEnabled: printerModuleEnabled ?? this.printerModuleEnabled,
    onboardingDone: onboardingDone ?? this.onboardingDone,
    defaultChannelId: defaultChannelId.present
        ? defaultChannelId.value
        : this.defaultChannelId,
  );
  SettingsRow copyWithCompanion(AppSettingsCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      localeCode: data.localeCode.present
          ? data.localeCode.value
          : this.localeCode,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      kwhPrice: data.kwhPrice.present ? data.kwhPrice.value : this.kwhPrice,
      laborHourCents: data.laborHourCents.present
          ? data.laborHourCents.value
          : this.laborHourCents,
      marketplaceFeeBp: data.marketplaceFeeBp.present
          ? data.marketplaceFeeBp.value
          : this.marketplaceFeeBp,
      taxBp: data.taxBp.present ? data.taxBp.value : this.taxBp,
      defaultMarginBp: data.defaultMarginBp.present
          ? data.defaultMarginBp.value
          : this.defaultMarginBp,
      packagingCents: data.packagingCents.present
          ? data.packagingCents.value
          : this.packagingCents,
      defaultWasteBp: data.defaultWasteBp.present
          ? data.defaultWasteBp.value
          : this.defaultWasteBp,
      defaultFailureBp: data.defaultFailureBp.present
          ? data.defaultFailureBp.value
          : this.defaultFailureBp,
      priceRounding: data.priceRounding.present
          ? data.priceRounding.value
          : this.priceRounding,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      shopContact: data.shopContact.present
          ? data.shopContact.value
          : this.shopContact,
      shopLogo: data.shopLogo.present ? data.shopLogo.value : this.shopLogo,
      printerModuleEnabled: data.printerModuleEnabled.present
          ? data.printerModuleEnabled.value
          : this.printerModuleEnabled,
      onboardingDone: data.onboardingDone.present
          ? data.onboardingDone.value
          : this.onboardingDone,
      defaultChannelId: data.defaultChannelId.present
          ? data.defaultChannelId.value
          : this.defaultChannelId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('localeCode: $localeCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('kwhPrice: $kwhPrice, ')
          ..write('laborHourCents: $laborHourCents, ')
          ..write('marketplaceFeeBp: $marketplaceFeeBp, ')
          ..write('taxBp: $taxBp, ')
          ..write('defaultMarginBp: $defaultMarginBp, ')
          ..write('packagingCents: $packagingCents, ')
          ..write('defaultWasteBp: $defaultWasteBp, ')
          ..write('defaultFailureBp: $defaultFailureBp, ')
          ..write('priceRounding: $priceRounding, ')
          ..write('shopName: $shopName, ')
          ..write('shopContact: $shopContact, ')
          ..write('shopLogo: $shopLogo, ')
          ..write('printerModuleEnabled: $printerModuleEnabled, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('defaultChannelId: $defaultChannelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currencyCode,
    localeCode,
    themeMode,
    kwhPrice,
    laborHourCents,
    marketplaceFeeBp,
    taxBp,
    defaultMarginBp,
    packagingCents,
    defaultWasteBp,
    defaultFailureBp,
    priceRounding,
    shopName,
    shopContact,
    $driftBlobEquality.hash(shopLogo),
    printerModuleEnabled,
    onboardingDone,
    defaultChannelId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.currencyCode == this.currencyCode &&
          other.localeCode == this.localeCode &&
          other.themeMode == this.themeMode &&
          other.kwhPrice == this.kwhPrice &&
          other.laborHourCents == this.laborHourCents &&
          other.marketplaceFeeBp == this.marketplaceFeeBp &&
          other.taxBp == this.taxBp &&
          other.defaultMarginBp == this.defaultMarginBp &&
          other.packagingCents == this.packagingCents &&
          other.defaultWasteBp == this.defaultWasteBp &&
          other.defaultFailureBp == this.defaultFailureBp &&
          other.priceRounding == this.priceRounding &&
          other.shopName == this.shopName &&
          other.shopContact == this.shopContact &&
          $driftBlobEquality.equals(other.shopLogo, this.shopLogo) &&
          other.printerModuleEnabled == this.printerModuleEnabled &&
          other.onboardingDone == this.onboardingDone &&
          other.defaultChannelId == this.defaultChannelId);
}

class AppSettingsCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<String> currencyCode;
  final Value<String?> localeCode;
  final Value<String> themeMode;
  final Value<int> kwhPrice;
  final Value<int> laborHourCents;
  final Value<int> marketplaceFeeBp;
  final Value<int> taxBp;
  final Value<int> defaultMarginBp;
  final Value<int> packagingCents;
  final Value<int> defaultWasteBp;
  final Value<int> defaultFailureBp;
  final Value<PriceRounding> priceRounding;
  final Value<String> shopName;
  final Value<String> shopContact;
  final Value<Uint8List?> shopLogo;
  final Value<bool> printerModuleEnabled;
  final Value<bool> onboardingDone;
  final Value<int?> defaultChannelId;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.kwhPrice = const Value.absent(),
    this.laborHourCents = const Value.absent(),
    this.marketplaceFeeBp = const Value.absent(),
    this.taxBp = const Value.absent(),
    this.defaultMarginBp = const Value.absent(),
    this.packagingCents = const Value.absent(),
    this.defaultWasteBp = const Value.absent(),
    this.defaultFailureBp = const Value.absent(),
    this.priceRounding = const Value.absent(),
    this.shopName = const Value.absent(),
    this.shopContact = const Value.absent(),
    this.shopLogo = const Value.absent(),
    this.printerModuleEnabled = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.defaultChannelId = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.kwhPrice = const Value.absent(),
    this.laborHourCents = const Value.absent(),
    this.marketplaceFeeBp = const Value.absent(),
    this.taxBp = const Value.absent(),
    this.defaultMarginBp = const Value.absent(),
    this.packagingCents = const Value.absent(),
    this.defaultWasteBp = const Value.absent(),
    this.defaultFailureBp = const Value.absent(),
    this.priceRounding = const Value.absent(),
    this.shopName = const Value.absent(),
    this.shopContact = const Value.absent(),
    this.shopLogo = const Value.absent(),
    this.printerModuleEnabled = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.defaultChannelId = const Value.absent(),
  });
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<String>? currencyCode,
    Expression<String>? localeCode,
    Expression<String>? themeMode,
    Expression<int>? kwhPrice,
    Expression<int>? laborHourCents,
    Expression<int>? marketplaceFeeBp,
    Expression<int>? taxBp,
    Expression<int>? defaultMarginBp,
    Expression<int>? packagingCents,
    Expression<int>? defaultWasteBp,
    Expression<int>? defaultFailureBp,
    Expression<String>? priceRounding,
    Expression<String>? shopName,
    Expression<String>? shopContact,
    Expression<Uint8List>? shopLogo,
    Expression<bool>? printerModuleEnabled,
    Expression<bool>? onboardingDone,
    Expression<int>? defaultChannelId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (localeCode != null) 'locale_code': localeCode,
      if (themeMode != null) 'theme_mode': themeMode,
      if (kwhPrice != null) 'kwh_price': kwhPrice,
      if (laborHourCents != null) 'labor_hour_cents': laborHourCents,
      if (marketplaceFeeBp != null) 'marketplace_fee_bp': marketplaceFeeBp,
      if (taxBp != null) 'tax_bp': taxBp,
      if (defaultMarginBp != null) 'default_margin_bp': defaultMarginBp,
      if (packagingCents != null) 'packaging_cents': packagingCents,
      if (defaultWasteBp != null) 'default_waste_bp': defaultWasteBp,
      if (defaultFailureBp != null) 'default_failure_bp': defaultFailureBp,
      if (priceRounding != null) 'price_rounding': priceRounding,
      if (shopName != null) 'shop_name': shopName,
      if (shopContact != null) 'shop_contact': shopContact,
      if (shopLogo != null) 'shop_logo': shopLogo,
      if (printerModuleEnabled != null)
        'printer_module_enabled': printerModuleEnabled,
      if (onboardingDone != null) 'onboarding_done': onboardingDone,
      if (defaultChannelId != null) 'default_channel_id': defaultChannelId,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? currencyCode,
    Value<String?>? localeCode,
    Value<String>? themeMode,
    Value<int>? kwhPrice,
    Value<int>? laborHourCents,
    Value<int>? marketplaceFeeBp,
    Value<int>? taxBp,
    Value<int>? defaultMarginBp,
    Value<int>? packagingCents,
    Value<int>? defaultWasteBp,
    Value<int>? defaultFailureBp,
    Value<PriceRounding>? priceRounding,
    Value<String>? shopName,
    Value<String>? shopContact,
    Value<Uint8List?>? shopLogo,
    Value<bool>? printerModuleEnabled,
    Value<bool>? onboardingDone,
    Value<int?>? defaultChannelId,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      currencyCode: currencyCode ?? this.currencyCode,
      localeCode: localeCode ?? this.localeCode,
      themeMode: themeMode ?? this.themeMode,
      kwhPrice: kwhPrice ?? this.kwhPrice,
      laborHourCents: laborHourCents ?? this.laborHourCents,
      marketplaceFeeBp: marketplaceFeeBp ?? this.marketplaceFeeBp,
      taxBp: taxBp ?? this.taxBp,
      defaultMarginBp: defaultMarginBp ?? this.defaultMarginBp,
      packagingCents: packagingCents ?? this.packagingCents,
      defaultWasteBp: defaultWasteBp ?? this.defaultWasteBp,
      defaultFailureBp: defaultFailureBp ?? this.defaultFailureBp,
      priceRounding: priceRounding ?? this.priceRounding,
      shopName: shopName ?? this.shopName,
      shopContact: shopContact ?? this.shopContact,
      shopLogo: shopLogo ?? this.shopLogo,
      printerModuleEnabled: printerModuleEnabled ?? this.printerModuleEnabled,
      onboardingDone: onboardingDone ?? this.onboardingDone,
      defaultChannelId: defaultChannelId ?? this.defaultChannelId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (localeCode.present) {
      map['locale_code'] = Variable<String>(localeCode.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (kwhPrice.present) {
      map['kwh_price'] = Variable<int>(kwhPrice.value);
    }
    if (laborHourCents.present) {
      map['labor_hour_cents'] = Variable<int>(laborHourCents.value);
    }
    if (marketplaceFeeBp.present) {
      map['marketplace_fee_bp'] = Variable<int>(marketplaceFeeBp.value);
    }
    if (taxBp.present) {
      map['tax_bp'] = Variable<int>(taxBp.value);
    }
    if (defaultMarginBp.present) {
      map['default_margin_bp'] = Variable<int>(defaultMarginBp.value);
    }
    if (packagingCents.present) {
      map['packaging_cents'] = Variable<int>(packagingCents.value);
    }
    if (defaultWasteBp.present) {
      map['default_waste_bp'] = Variable<int>(defaultWasteBp.value);
    }
    if (defaultFailureBp.present) {
      map['default_failure_bp'] = Variable<int>(defaultFailureBp.value);
    }
    if (priceRounding.present) {
      map['price_rounding'] = Variable<String>(
        $AppSettingsTable.$converterpriceRounding.toSql(priceRounding.value),
      );
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (shopContact.present) {
      map['shop_contact'] = Variable<String>(shopContact.value);
    }
    if (shopLogo.present) {
      map['shop_logo'] = Variable<Uint8List>(shopLogo.value);
    }
    if (printerModuleEnabled.present) {
      map['printer_module_enabled'] = Variable<bool>(
        printerModuleEnabled.value,
      );
    }
    if (onboardingDone.present) {
      map['onboarding_done'] = Variable<bool>(onboardingDone.value);
    }
    if (defaultChannelId.present) {
      map['default_channel_id'] = Variable<int>(defaultChannelId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('localeCode: $localeCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('kwhPrice: $kwhPrice, ')
          ..write('laborHourCents: $laborHourCents, ')
          ..write('marketplaceFeeBp: $marketplaceFeeBp, ')
          ..write('taxBp: $taxBp, ')
          ..write('defaultMarginBp: $defaultMarginBp, ')
          ..write('packagingCents: $packagingCents, ')
          ..write('defaultWasteBp: $defaultWasteBp, ')
          ..write('defaultFailureBp: $defaultFailureBp, ')
          ..write('priceRounding: $priceRounding, ')
          ..write('shopName: $shopName, ')
          ..write('shopContact: $shopContact, ')
          ..write('shopLogo: $shopLogo, ')
          ..write('printerModuleEnabled: $printerModuleEnabled, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('defaultChannelId: $defaultChannelId')
          ..write(')'))
        .toString();
  }
}

class $SalesChannelsTable extends SalesChannels
    with TableInfo<$SalesChannelsTable, SalesChannelRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesChannelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<FeeTier>, String> tiers =
      GeneratedColumn<String>(
        'tiers',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<FeeTier>>($SalesChannelsTable.$convertertiers);
  static const VerificationMeta _isExampleMeta = const VerificationMeta(
    'isExample',
  );
  @override
  late final GeneratedColumn<bool> isExample = GeneratedColumn<bool>(
    'is_example',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_example" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _infoUrlMeta = const VerificationMeta(
    'infoUrl',
  );
  @override
  late final GeneratedColumn<String> infoUrl = GeneratedColumn<String>(
    'info_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    tiers,
    isExample,
    infoUrl,
    sortOrder,
    archived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_channels';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesChannelRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_example')) {
      context.handle(
        _isExampleMeta,
        isExample.isAcceptableOrUnknown(data['is_example']!, _isExampleMeta),
      );
    }
    if (data.containsKey('info_url')) {
      context.handle(
        _infoUrlMeta,
        infoUrl.isAcceptableOrUnknown(data['info_url']!, _infoUrlMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesChannelRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesChannelRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      tiers: $SalesChannelsTable.$convertertiers.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tiers'],
        )!,
      ),
      isExample: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_example'],
      )!,
      infoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}info_url'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SalesChannelsTable createAlias(String alias) {
    return $SalesChannelsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<FeeTier>, String> $convertertiers =
      const FeeTiersConverter();
}

class SalesChannelRow extends DataClass implements Insertable<SalesChannelRow> {
  final int id;
  final String name;

  /// Fee tiers by price, as JSON.
  final List<FeeTier> tiers;

  /// Seeded with example fees that the user should check.
  final bool isExample;

  /// Page where the marketplace publishes its current fees.
  final String? infoUrl;
  final int sortOrder;
  final bool archived;
  final DateTime createdAt;
  const SalesChannelRow({
    required this.id,
    required this.name,
    required this.tiers,
    required this.isExample,
    this.infoUrl,
    required this.sortOrder,
    required this.archived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['tiers'] = Variable<String>(
        $SalesChannelsTable.$convertertiers.toSql(tiers),
      );
    }
    map['is_example'] = Variable<bool>(isExample);
    if (!nullToAbsent || infoUrl != null) {
      map['info_url'] = Variable<String>(infoUrl);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SalesChannelsCompanion toCompanion(bool nullToAbsent) {
    return SalesChannelsCompanion(
      id: Value(id),
      name: Value(name),
      tiers: Value(tiers),
      isExample: Value(isExample),
      infoUrl: infoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(infoUrl),
      sortOrder: Value(sortOrder),
      archived: Value(archived),
      createdAt: Value(createdAt),
    );
  }

  factory SalesChannelRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesChannelRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      tiers: serializer.fromJson<List<FeeTier>>(json['tiers']),
      isExample: serializer.fromJson<bool>(json['isExample']),
      infoUrl: serializer.fromJson<String?>(json['infoUrl']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'tiers': serializer.toJson<List<FeeTier>>(tiers),
      'isExample': serializer.toJson<bool>(isExample),
      'infoUrl': serializer.toJson<String?>(infoUrl),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SalesChannelRow copyWith({
    int? id,
    String? name,
    List<FeeTier>? tiers,
    bool? isExample,
    Value<String?> infoUrl = const Value.absent(),
    int? sortOrder,
    bool? archived,
    DateTime? createdAt,
  }) => SalesChannelRow(
    id: id ?? this.id,
    name: name ?? this.name,
    tiers: tiers ?? this.tiers,
    isExample: isExample ?? this.isExample,
    infoUrl: infoUrl.present ? infoUrl.value : this.infoUrl,
    sortOrder: sortOrder ?? this.sortOrder,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
  );
  SalesChannelRow copyWithCompanion(SalesChannelsCompanion data) {
    return SalesChannelRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      tiers: data.tiers.present ? data.tiers.value : this.tiers,
      isExample: data.isExample.present ? data.isExample.value : this.isExample,
      infoUrl: data.infoUrl.present ? data.infoUrl.value : this.infoUrl,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesChannelRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tiers: $tiers, ')
          ..write('isExample: $isExample, ')
          ..write('infoUrl: $infoUrl, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    tiers,
    isExample,
    infoUrl,
    sortOrder,
    archived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesChannelRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.tiers == this.tiers &&
          other.isExample == this.isExample &&
          other.infoUrl == this.infoUrl &&
          other.sortOrder == this.sortOrder &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt);
}

class SalesChannelsCompanion extends UpdateCompanion<SalesChannelRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<List<FeeTier>> tiers;
  final Value<bool> isExample;
  final Value<String?> infoUrl;
  final Value<int> sortOrder;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  const SalesChannelsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.tiers = const Value.absent(),
    this.isExample = const Value.absent(),
    this.infoUrl = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SalesChannelsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required List<FeeTier> tiers,
    this.isExample = const Value.absent(),
    this.infoUrl = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       tiers = Value(tiers);
  static Insertable<SalesChannelRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? tiers,
    Expression<bool>? isExample,
    Expression<String>? infoUrl,
    Expression<int>? sortOrder,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (tiers != null) 'tiers': tiers,
      if (isExample != null) 'is_example': isExample,
      if (infoUrl != null) 'info_url': infoUrl,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SalesChannelsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<List<FeeTier>>? tiers,
    Value<bool>? isExample,
    Value<String?>? infoUrl,
    Value<int>? sortOrder,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
  }) {
    return SalesChannelsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      tiers: tiers ?? this.tiers,
      isExample: isExample ?? this.isExample,
      infoUrl: infoUrl ?? this.infoUrl,
      sortOrder: sortOrder ?? this.sortOrder,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tiers.present) {
      map['tiers'] = Variable<String>(
        $SalesChannelsTable.$convertertiers.toSql(tiers.value),
      );
    }
    if (isExample.present) {
      map['is_example'] = Variable<bool>(isExample.value);
    }
    if (infoUrl.present) {
      map['info_url'] = Variable<String>(infoUrl.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesChannelsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tiers: $tiers, ')
          ..write('isExample: $isExample, ')
          ..write('infoUrl: $infoUrl, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $JobsTable extends Jobs with TableInfo<$JobsTable, JobRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerMeta = const VerificationMeta(
    'customer',
  );
  @override
  late final GeneratedColumn<String> customer = GeneratedColumn<String>(
    'customer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<JobStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<JobStatus>($JobsTable.$converterstatus);
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _printerIdMeta = const VerificationMeta(
    'printerId',
  );
  @override
  late final GeneratedColumn<int> printerId = GeneratedColumn<int>(
    'printer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES printers (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _printerNameMeta = const VerificationMeta(
    'printerName',
  );
  @override
  late final GeneratedColumn<String> printerName = GeneratedColumn<String>(
    'printer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _powerWattsMeta = const VerificationMeta(
    'powerWatts',
  );
  @override
  late final GeneratedColumn<int> powerWatts = GeneratedColumn<int>(
    'power_watts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _machineValueCentsMeta = const VerificationMeta(
    'machineValueCents',
  );
  @override
  late final GeneratedColumn<int> machineValueCents = GeneratedColumn<int>(
    'machine_value_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lifespanHoursMeta = const VerificationMeta(
    'lifespanHours',
  );
  @override
  late final GeneratedColumn<int> lifespanHours = GeneratedColumn<int>(
    'lifespan_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _maintenancePerHourCentsMeta =
      const VerificationMeta('maintenancePerHourCents');
  @override
  late final GeneratedColumn<int> maintenancePerHourCents =
      GeneratedColumn<int>(
        'maintenance_per_hour_cents',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _printSecondsMeta = const VerificationMeta(
    'printSeconds',
  );
  @override
  late final GeneratedColumn<int> printSeconds = GeneratedColumn<int>(
    'print_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postProcessMinutesMeta =
      const VerificationMeta('postProcessMinutes');
  @override
  late final GeneratedColumn<int> postProcessMinutes = GeneratedColumn<int>(
    'post_process_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kwhPriceMeta = const VerificationMeta(
    'kwhPrice',
  );
  @override
  late final GeneratedColumn<int> kwhPrice = GeneratedColumn<int>(
    'kwh_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _laborHourCentsMeta = const VerificationMeta(
    'laborHourCents',
  );
  @override
  late final GeneratedColumn<int> laborHourCents = GeneratedColumn<int>(
    'labor_hour_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packagingCentsMeta = const VerificationMeta(
    'packagingCents',
  );
  @override
  late final GeneratedColumn<int> packagingCents = GeneratedColumn<int>(
    'packaging_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wasteBpMeta = const VerificationMeta(
    'wasteBp',
  );
  @override
  late final GeneratedColumn<int> wasteBp = GeneratedColumn<int>(
    'waste_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _failureBpMeta = const VerificationMeta(
    'failureBp',
  );
  @override
  late final GeneratedColumn<int> failureBp = GeneratedColumn<int>(
    'failure_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marginBpMeta = const VerificationMeta(
    'marginBp',
  );
  @override
  late final GeneratedColumn<int> marginBp = GeneratedColumn<int>(
    'margin_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketplaceFeeBpMeta = const VerificationMeta(
    'marketplaceFeeBp',
  );
  @override
  late final GeneratedColumn<int> marketplaceFeeBp = GeneratedColumn<int>(
    'marketplace_fee_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxBpMeta = const VerificationMeta('taxBp');
  @override
  late final GeneratedColumn<int> taxBp = GeneratedColumn<int>(
    'tax_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PriceRounding, String>
  priceRounding = GeneratedColumn<String>(
    'price_rounding',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<PriceRounding>($JobsTable.$converterpriceRounding);
  static const VerificationMeta _channelIdMeta = const VerificationMeta(
    'channelId',
  );
  @override
  late final GeneratedColumn<int> channelId = GeneratedColumn<int>(
    'channel_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales_channels (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _channelNameMeta = const VerificationMeta(
    'channelName',
  );
  @override
  late final GeneratedColumn<String> channelName = GeneratedColumn<String>(
    'channel_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _marketplaceFixedCentsMeta =
      const VerificationMeta('marketplaceFixedCents');
  @override
  late final GeneratedColumn<int> marketplaceFixedCents = GeneratedColumn<int>(
    'marketplace_fixed_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unitsPerPrintMeta = const VerificationMeta(
    'unitsPerPrint',
  );
  @override
  late final GeneratedColumn<int> unitsPerPrint = GeneratedColumn<int>(
    'units_per_print',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _costCentsMeta = const VerificationMeta(
    'costCents',
  );
  @override
  late final GeneratedColumn<int> costCents = GeneratedColumn<int>(
    'cost_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceCentsMeta = const VerificationMeta(
    'priceCents',
  );
  @override
  late final GeneratedColumn<int> priceCents = GeneratedColumn<int>(
    'price_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profitCentsMeta = const VerificationMeta(
    'profitCents',
  );
  @override
  late final GeneratedColumn<int> profitCents = GeneratedColumn<int>(
    'profit_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceFileMeta = const VerificationMeta(
    'sourceFile',
  );
  @override
  late final GeneratedColumn<String> sourceFile = GeneratedColumn<String>(
    'source_file',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockDeductedMeta = const VerificationMeta(
    'stockDeducted',
  );
  @override
  late final GeneratedColumn<bool> stockDeducted = GeneratedColumn<bool>(
    'stock_deducted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("stock_deducted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _printedAtMeta = const VerificationMeta(
    'printedAt',
  );
  @override
  late final GeneratedColumn<DateTime> printedAt = GeneratedColumn<DateTime>(
    'printed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    customer,
    photoPath,
    notes,
    status,
    quantity,
    printerId,
    printerName,
    powerWatts,
    machineValueCents,
    lifespanHours,
    maintenancePerHourCents,
    printSeconds,
    postProcessMinutes,
    kwhPrice,
    laborHourCents,
    packagingCents,
    wasteBp,
    failureBp,
    marginBp,
    marketplaceFeeBp,
    taxBp,
    priceRounding,
    channelId,
    channelName,
    marketplaceFixedCents,
    unitsPerPrint,
    costCents,
    priceCents,
    profitCents,
    sourceFile,
    stockDeducted,
    printedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('customer')) {
      context.handle(
        _customerMeta,
        customer.isAcceptableOrUnknown(data['customer']!, _customerMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('printer_id')) {
      context.handle(
        _printerIdMeta,
        printerId.isAcceptableOrUnknown(data['printer_id']!, _printerIdMeta),
      );
    }
    if (data.containsKey('printer_name')) {
      context.handle(
        _printerNameMeta,
        printerName.isAcceptableOrUnknown(
          data['printer_name']!,
          _printerNameMeta,
        ),
      );
    }
    if (data.containsKey('power_watts')) {
      context.handle(
        _powerWattsMeta,
        powerWatts.isAcceptableOrUnknown(data['power_watts']!, _powerWattsMeta),
      );
    }
    if (data.containsKey('machine_value_cents')) {
      context.handle(
        _machineValueCentsMeta,
        machineValueCents.isAcceptableOrUnknown(
          data['machine_value_cents']!,
          _machineValueCentsMeta,
        ),
      );
    }
    if (data.containsKey('lifespan_hours')) {
      context.handle(
        _lifespanHoursMeta,
        lifespanHours.isAcceptableOrUnknown(
          data['lifespan_hours']!,
          _lifespanHoursMeta,
        ),
      );
    }
    if (data.containsKey('maintenance_per_hour_cents')) {
      context.handle(
        _maintenancePerHourCentsMeta,
        maintenancePerHourCents.isAcceptableOrUnknown(
          data['maintenance_per_hour_cents']!,
          _maintenancePerHourCentsMeta,
        ),
      );
    }
    if (data.containsKey('print_seconds')) {
      context.handle(
        _printSecondsMeta,
        printSeconds.isAcceptableOrUnknown(
          data['print_seconds']!,
          _printSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_printSecondsMeta);
    }
    if (data.containsKey('post_process_minutes')) {
      context.handle(
        _postProcessMinutesMeta,
        postProcessMinutes.isAcceptableOrUnknown(
          data['post_process_minutes']!,
          _postProcessMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_postProcessMinutesMeta);
    }
    if (data.containsKey('kwh_price')) {
      context.handle(
        _kwhPriceMeta,
        kwhPrice.isAcceptableOrUnknown(data['kwh_price']!, _kwhPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_kwhPriceMeta);
    }
    if (data.containsKey('labor_hour_cents')) {
      context.handle(
        _laborHourCentsMeta,
        laborHourCents.isAcceptableOrUnknown(
          data['labor_hour_cents']!,
          _laborHourCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_laborHourCentsMeta);
    }
    if (data.containsKey('packaging_cents')) {
      context.handle(
        _packagingCentsMeta,
        packagingCents.isAcceptableOrUnknown(
          data['packaging_cents']!,
          _packagingCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packagingCentsMeta);
    }
    if (data.containsKey('waste_bp')) {
      context.handle(
        _wasteBpMeta,
        wasteBp.isAcceptableOrUnknown(data['waste_bp']!, _wasteBpMeta),
      );
    } else if (isInserting) {
      context.missing(_wasteBpMeta);
    }
    if (data.containsKey('failure_bp')) {
      context.handle(
        _failureBpMeta,
        failureBp.isAcceptableOrUnknown(data['failure_bp']!, _failureBpMeta),
      );
    } else if (isInserting) {
      context.missing(_failureBpMeta);
    }
    if (data.containsKey('margin_bp')) {
      context.handle(
        _marginBpMeta,
        marginBp.isAcceptableOrUnknown(data['margin_bp']!, _marginBpMeta),
      );
    } else if (isInserting) {
      context.missing(_marginBpMeta);
    }
    if (data.containsKey('marketplace_fee_bp')) {
      context.handle(
        _marketplaceFeeBpMeta,
        marketplaceFeeBp.isAcceptableOrUnknown(
          data['marketplace_fee_bp']!,
          _marketplaceFeeBpMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_marketplaceFeeBpMeta);
    }
    if (data.containsKey('tax_bp')) {
      context.handle(
        _taxBpMeta,
        taxBp.isAcceptableOrUnknown(data['tax_bp']!, _taxBpMeta),
      );
    } else if (isInserting) {
      context.missing(_taxBpMeta);
    }
    if (data.containsKey('channel_id')) {
      context.handle(
        _channelIdMeta,
        channelId.isAcceptableOrUnknown(data['channel_id']!, _channelIdMeta),
      );
    }
    if (data.containsKey('channel_name')) {
      context.handle(
        _channelNameMeta,
        channelName.isAcceptableOrUnknown(
          data['channel_name']!,
          _channelNameMeta,
        ),
      );
    }
    if (data.containsKey('marketplace_fixed_cents')) {
      context.handle(
        _marketplaceFixedCentsMeta,
        marketplaceFixedCents.isAcceptableOrUnknown(
          data['marketplace_fixed_cents']!,
          _marketplaceFixedCentsMeta,
        ),
      );
    }
    if (data.containsKey('units_per_print')) {
      context.handle(
        _unitsPerPrintMeta,
        unitsPerPrint.isAcceptableOrUnknown(
          data['units_per_print']!,
          _unitsPerPrintMeta,
        ),
      );
    }
    if (data.containsKey('cost_cents')) {
      context.handle(
        _costCentsMeta,
        costCents.isAcceptableOrUnknown(data['cost_cents']!, _costCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_costCentsMeta);
    }
    if (data.containsKey('price_cents')) {
      context.handle(
        _priceCentsMeta,
        priceCents.isAcceptableOrUnknown(data['price_cents']!, _priceCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_priceCentsMeta);
    }
    if (data.containsKey('profit_cents')) {
      context.handle(
        _profitCentsMeta,
        profitCents.isAcceptableOrUnknown(
          data['profit_cents']!,
          _profitCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_profitCentsMeta);
    }
    if (data.containsKey('source_file')) {
      context.handle(
        _sourceFileMeta,
        sourceFile.isAcceptableOrUnknown(data['source_file']!, _sourceFileMeta),
      );
    }
    if (data.containsKey('stock_deducted')) {
      context.handle(
        _stockDeductedMeta,
        stockDeducted.isAcceptableOrUnknown(
          data['stock_deducted']!,
          _stockDeductedMeta,
        ),
      );
    }
    if (data.containsKey('printed_at')) {
      context.handle(
        _printedAtMeta,
        printedAt.isAcceptableOrUnknown(data['printed_at']!, _printedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      customer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: $JobsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      printerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}printer_id'],
      ),
      printerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_name'],
      ),
      powerWatts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}power_watts'],
      )!,
      machineValueCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}machine_value_cents'],
      )!,
      lifespanHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifespan_hours'],
      )!,
      maintenancePerHourCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maintenance_per_hour_cents'],
      )!,
      printSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}print_seconds'],
      )!,
      postProcessMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}post_process_minutes'],
      )!,
      kwhPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kwh_price'],
      )!,
      laborHourCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}labor_hour_cents'],
      )!,
      packagingCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}packaging_cents'],
      )!,
      wasteBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}waste_bp'],
      )!,
      failureBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failure_bp'],
      )!,
      marginBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}margin_bp'],
      )!,
      marketplaceFeeBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}marketplace_fee_bp'],
      )!,
      taxBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_bp'],
      )!,
      priceRounding: $JobsTable.$converterpriceRounding.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}price_rounding'],
        )!,
      ),
      channelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}channel_id'],
      ),
      channelName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel_name'],
      ),
      marketplaceFixedCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}marketplace_fixed_cents'],
      )!,
      unitsPerPrint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}units_per_print'],
      )!,
      costCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_cents'],
      )!,
      priceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_cents'],
      )!,
      profitCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profit_cents'],
      )!,
      sourceFile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_file'],
      ),
      stockDeducted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}stock_deducted'],
      )!,
      printedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}printed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $JobsTable createAlias(String alias) {
    return $JobsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<JobStatus, String, String> $converterstatus =
      const EnumNameConverter<JobStatus>(JobStatus.values);
  static JsonTypeConverter2<PriceRounding, String, String>
  $converterpriceRounding = const EnumNameConverter<PriceRounding>(
    PriceRounding.values,
  );
}

class JobRow extends DataClass implements Insertable<JobRow> {
  final int id;
  final String name;
  final String? customer;
  final String? photoPath;
  final String? notes;
  final JobStatus status;
  final int quantity;
  final int? printerId;
  final String? printerName;
  final int powerWatts;
  final int machineValueCents;
  final int lifespanHours;
  final int maintenancePerHourCents;
  final int printSeconds;
  final int postProcessMinutes;
  final int kwhPrice;
  final int laborHourCents;
  final int packagingCents;
  final int wasteBp;
  final int failureBp;
  final int marginBp;
  final int marketplaceFeeBp;
  final int taxBp;
  final PriceRounding priceRounding;

  /// v3: sales channel used for the fees (snapshot of name and fixed fee;
  /// [marketplaceFeeBp] holds the percentage of the tier applied).
  final int? channelId;
  final String? channelName;
  final int marketplaceFixedCents;

  /// v3: parts printed together; filament lines and [printSeconds] are per
  /// part, so `weight × quantity` is what leaves the stock.
  final int unitsPerPrint;

  /// Results per unit.
  final int costCents;
  final int priceCents;
  final int profitCents;

  /// Name of the sliced file this came from (.3mf / printer job), if any.
  final String? sourceFile;
  final bool stockDeducted;
  final DateTime? printedAt;
  final DateTime createdAt;
  const JobRow({
    required this.id,
    required this.name,
    this.customer,
    this.photoPath,
    this.notes,
    required this.status,
    required this.quantity,
    this.printerId,
    this.printerName,
    required this.powerWatts,
    required this.machineValueCents,
    required this.lifespanHours,
    required this.maintenancePerHourCents,
    required this.printSeconds,
    required this.postProcessMinutes,
    required this.kwhPrice,
    required this.laborHourCents,
    required this.packagingCents,
    required this.wasteBp,
    required this.failureBp,
    required this.marginBp,
    required this.marketplaceFeeBp,
    required this.taxBp,
    required this.priceRounding,
    this.channelId,
    this.channelName,
    required this.marketplaceFixedCents,
    required this.unitsPerPrint,
    required this.costCents,
    required this.priceCents,
    required this.profitCents,
    this.sourceFile,
    required this.stockDeducted,
    this.printedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || customer != null) {
      map['customer'] = Variable<String>(customer);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['status'] = Variable<String>(
        $JobsTable.$converterstatus.toSql(status),
      );
    }
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || printerId != null) {
      map['printer_id'] = Variable<int>(printerId);
    }
    if (!nullToAbsent || printerName != null) {
      map['printer_name'] = Variable<String>(printerName);
    }
    map['power_watts'] = Variable<int>(powerWatts);
    map['machine_value_cents'] = Variable<int>(machineValueCents);
    map['lifespan_hours'] = Variable<int>(lifespanHours);
    map['maintenance_per_hour_cents'] = Variable<int>(maintenancePerHourCents);
    map['print_seconds'] = Variable<int>(printSeconds);
    map['post_process_minutes'] = Variable<int>(postProcessMinutes);
    map['kwh_price'] = Variable<int>(kwhPrice);
    map['labor_hour_cents'] = Variable<int>(laborHourCents);
    map['packaging_cents'] = Variable<int>(packagingCents);
    map['waste_bp'] = Variable<int>(wasteBp);
    map['failure_bp'] = Variable<int>(failureBp);
    map['margin_bp'] = Variable<int>(marginBp);
    map['marketplace_fee_bp'] = Variable<int>(marketplaceFeeBp);
    map['tax_bp'] = Variable<int>(taxBp);
    {
      map['price_rounding'] = Variable<String>(
        $JobsTable.$converterpriceRounding.toSql(priceRounding),
      );
    }
    if (!nullToAbsent || channelId != null) {
      map['channel_id'] = Variable<int>(channelId);
    }
    if (!nullToAbsent || channelName != null) {
      map['channel_name'] = Variable<String>(channelName);
    }
    map['marketplace_fixed_cents'] = Variable<int>(marketplaceFixedCents);
    map['units_per_print'] = Variable<int>(unitsPerPrint);
    map['cost_cents'] = Variable<int>(costCents);
    map['price_cents'] = Variable<int>(priceCents);
    map['profit_cents'] = Variable<int>(profitCents);
    if (!nullToAbsent || sourceFile != null) {
      map['source_file'] = Variable<String>(sourceFile);
    }
    map['stock_deducted'] = Variable<bool>(stockDeducted);
    if (!nullToAbsent || printedAt != null) {
      map['printed_at'] = Variable<DateTime>(printedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  JobsCompanion toCompanion(bool nullToAbsent) {
    return JobsCompanion(
      id: Value(id),
      name: Value(name),
      customer: customer == null && nullToAbsent
          ? const Value.absent()
          : Value(customer),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      quantity: Value(quantity),
      printerId: printerId == null && nullToAbsent
          ? const Value.absent()
          : Value(printerId),
      printerName: printerName == null && nullToAbsent
          ? const Value.absent()
          : Value(printerName),
      powerWatts: Value(powerWatts),
      machineValueCents: Value(machineValueCents),
      lifespanHours: Value(lifespanHours),
      maintenancePerHourCents: Value(maintenancePerHourCents),
      printSeconds: Value(printSeconds),
      postProcessMinutes: Value(postProcessMinutes),
      kwhPrice: Value(kwhPrice),
      laborHourCents: Value(laborHourCents),
      packagingCents: Value(packagingCents),
      wasteBp: Value(wasteBp),
      failureBp: Value(failureBp),
      marginBp: Value(marginBp),
      marketplaceFeeBp: Value(marketplaceFeeBp),
      taxBp: Value(taxBp),
      priceRounding: Value(priceRounding),
      channelId: channelId == null && nullToAbsent
          ? const Value.absent()
          : Value(channelId),
      channelName: channelName == null && nullToAbsent
          ? const Value.absent()
          : Value(channelName),
      marketplaceFixedCents: Value(marketplaceFixedCents),
      unitsPerPrint: Value(unitsPerPrint),
      costCents: Value(costCents),
      priceCents: Value(priceCents),
      profitCents: Value(profitCents),
      sourceFile: sourceFile == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceFile),
      stockDeducted: Value(stockDeducted),
      printedAt: printedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(printedAt),
      createdAt: Value(createdAt),
    );
  }

  factory JobRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      customer: serializer.fromJson<String?>(json['customer']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: $JobsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      quantity: serializer.fromJson<int>(json['quantity']),
      printerId: serializer.fromJson<int?>(json['printerId']),
      printerName: serializer.fromJson<String?>(json['printerName']),
      powerWatts: serializer.fromJson<int>(json['powerWatts']),
      machineValueCents: serializer.fromJson<int>(json['machineValueCents']),
      lifespanHours: serializer.fromJson<int>(json['lifespanHours']),
      maintenancePerHourCents: serializer.fromJson<int>(
        json['maintenancePerHourCents'],
      ),
      printSeconds: serializer.fromJson<int>(json['printSeconds']),
      postProcessMinutes: serializer.fromJson<int>(json['postProcessMinutes']),
      kwhPrice: serializer.fromJson<int>(json['kwhPrice']),
      laborHourCents: serializer.fromJson<int>(json['laborHourCents']),
      packagingCents: serializer.fromJson<int>(json['packagingCents']),
      wasteBp: serializer.fromJson<int>(json['wasteBp']),
      failureBp: serializer.fromJson<int>(json['failureBp']),
      marginBp: serializer.fromJson<int>(json['marginBp']),
      marketplaceFeeBp: serializer.fromJson<int>(json['marketplaceFeeBp']),
      taxBp: serializer.fromJson<int>(json['taxBp']),
      priceRounding: $JobsTable.$converterpriceRounding.fromJson(
        serializer.fromJson<String>(json['priceRounding']),
      ),
      channelId: serializer.fromJson<int?>(json['channelId']),
      channelName: serializer.fromJson<String?>(json['channelName']),
      marketplaceFixedCents: serializer.fromJson<int>(
        json['marketplaceFixedCents'],
      ),
      unitsPerPrint: serializer.fromJson<int>(json['unitsPerPrint']),
      costCents: serializer.fromJson<int>(json['costCents']),
      priceCents: serializer.fromJson<int>(json['priceCents']),
      profitCents: serializer.fromJson<int>(json['profitCents']),
      sourceFile: serializer.fromJson<String?>(json['sourceFile']),
      stockDeducted: serializer.fromJson<bool>(json['stockDeducted']),
      printedAt: serializer.fromJson<DateTime?>(json['printedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'customer': serializer.toJson<String?>(customer),
      'photoPath': serializer.toJson<String?>(photoPath),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(
        $JobsTable.$converterstatus.toJson(status),
      ),
      'quantity': serializer.toJson<int>(quantity),
      'printerId': serializer.toJson<int?>(printerId),
      'printerName': serializer.toJson<String?>(printerName),
      'powerWatts': serializer.toJson<int>(powerWatts),
      'machineValueCents': serializer.toJson<int>(machineValueCents),
      'lifespanHours': serializer.toJson<int>(lifespanHours),
      'maintenancePerHourCents': serializer.toJson<int>(
        maintenancePerHourCents,
      ),
      'printSeconds': serializer.toJson<int>(printSeconds),
      'postProcessMinutes': serializer.toJson<int>(postProcessMinutes),
      'kwhPrice': serializer.toJson<int>(kwhPrice),
      'laborHourCents': serializer.toJson<int>(laborHourCents),
      'packagingCents': serializer.toJson<int>(packagingCents),
      'wasteBp': serializer.toJson<int>(wasteBp),
      'failureBp': serializer.toJson<int>(failureBp),
      'marginBp': serializer.toJson<int>(marginBp),
      'marketplaceFeeBp': serializer.toJson<int>(marketplaceFeeBp),
      'taxBp': serializer.toJson<int>(taxBp),
      'priceRounding': serializer.toJson<String>(
        $JobsTable.$converterpriceRounding.toJson(priceRounding),
      ),
      'channelId': serializer.toJson<int?>(channelId),
      'channelName': serializer.toJson<String?>(channelName),
      'marketplaceFixedCents': serializer.toJson<int>(marketplaceFixedCents),
      'unitsPerPrint': serializer.toJson<int>(unitsPerPrint),
      'costCents': serializer.toJson<int>(costCents),
      'priceCents': serializer.toJson<int>(priceCents),
      'profitCents': serializer.toJson<int>(profitCents),
      'sourceFile': serializer.toJson<String?>(sourceFile),
      'stockDeducted': serializer.toJson<bool>(stockDeducted),
      'printedAt': serializer.toJson<DateTime?>(printedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  JobRow copyWith({
    int? id,
    String? name,
    Value<String?> customer = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    JobStatus? status,
    int? quantity,
    Value<int?> printerId = const Value.absent(),
    Value<String?> printerName = const Value.absent(),
    int? powerWatts,
    int? machineValueCents,
    int? lifespanHours,
    int? maintenancePerHourCents,
    int? printSeconds,
    int? postProcessMinutes,
    int? kwhPrice,
    int? laborHourCents,
    int? packagingCents,
    int? wasteBp,
    int? failureBp,
    int? marginBp,
    int? marketplaceFeeBp,
    int? taxBp,
    PriceRounding? priceRounding,
    Value<int?> channelId = const Value.absent(),
    Value<String?> channelName = const Value.absent(),
    int? marketplaceFixedCents,
    int? unitsPerPrint,
    int? costCents,
    int? priceCents,
    int? profitCents,
    Value<String?> sourceFile = const Value.absent(),
    bool? stockDeducted,
    Value<DateTime?> printedAt = const Value.absent(),
    DateTime? createdAt,
  }) => JobRow(
    id: id ?? this.id,
    name: name ?? this.name,
    customer: customer.present ? customer.value : this.customer,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    quantity: quantity ?? this.quantity,
    printerId: printerId.present ? printerId.value : this.printerId,
    printerName: printerName.present ? printerName.value : this.printerName,
    powerWatts: powerWatts ?? this.powerWatts,
    machineValueCents: machineValueCents ?? this.machineValueCents,
    lifespanHours: lifespanHours ?? this.lifespanHours,
    maintenancePerHourCents:
        maintenancePerHourCents ?? this.maintenancePerHourCents,
    printSeconds: printSeconds ?? this.printSeconds,
    postProcessMinutes: postProcessMinutes ?? this.postProcessMinutes,
    kwhPrice: kwhPrice ?? this.kwhPrice,
    laborHourCents: laborHourCents ?? this.laborHourCents,
    packagingCents: packagingCents ?? this.packagingCents,
    wasteBp: wasteBp ?? this.wasteBp,
    failureBp: failureBp ?? this.failureBp,
    marginBp: marginBp ?? this.marginBp,
    marketplaceFeeBp: marketplaceFeeBp ?? this.marketplaceFeeBp,
    taxBp: taxBp ?? this.taxBp,
    priceRounding: priceRounding ?? this.priceRounding,
    channelId: channelId.present ? channelId.value : this.channelId,
    channelName: channelName.present ? channelName.value : this.channelName,
    marketplaceFixedCents: marketplaceFixedCents ?? this.marketplaceFixedCents,
    unitsPerPrint: unitsPerPrint ?? this.unitsPerPrint,
    costCents: costCents ?? this.costCents,
    priceCents: priceCents ?? this.priceCents,
    profitCents: profitCents ?? this.profitCents,
    sourceFile: sourceFile.present ? sourceFile.value : this.sourceFile,
    stockDeducted: stockDeducted ?? this.stockDeducted,
    printedAt: printedAt.present ? printedAt.value : this.printedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  JobRow copyWithCompanion(JobsCompanion data) {
    return JobRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      customer: data.customer.present ? data.customer.value : this.customer,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      printerId: data.printerId.present ? data.printerId.value : this.printerId,
      printerName: data.printerName.present
          ? data.printerName.value
          : this.printerName,
      powerWatts: data.powerWatts.present
          ? data.powerWatts.value
          : this.powerWatts,
      machineValueCents: data.machineValueCents.present
          ? data.machineValueCents.value
          : this.machineValueCents,
      lifespanHours: data.lifespanHours.present
          ? data.lifespanHours.value
          : this.lifespanHours,
      maintenancePerHourCents: data.maintenancePerHourCents.present
          ? data.maintenancePerHourCents.value
          : this.maintenancePerHourCents,
      printSeconds: data.printSeconds.present
          ? data.printSeconds.value
          : this.printSeconds,
      postProcessMinutes: data.postProcessMinutes.present
          ? data.postProcessMinutes.value
          : this.postProcessMinutes,
      kwhPrice: data.kwhPrice.present ? data.kwhPrice.value : this.kwhPrice,
      laborHourCents: data.laborHourCents.present
          ? data.laborHourCents.value
          : this.laborHourCents,
      packagingCents: data.packagingCents.present
          ? data.packagingCents.value
          : this.packagingCents,
      wasteBp: data.wasteBp.present ? data.wasteBp.value : this.wasteBp,
      failureBp: data.failureBp.present ? data.failureBp.value : this.failureBp,
      marginBp: data.marginBp.present ? data.marginBp.value : this.marginBp,
      marketplaceFeeBp: data.marketplaceFeeBp.present
          ? data.marketplaceFeeBp.value
          : this.marketplaceFeeBp,
      taxBp: data.taxBp.present ? data.taxBp.value : this.taxBp,
      priceRounding: data.priceRounding.present
          ? data.priceRounding.value
          : this.priceRounding,
      channelId: data.channelId.present ? data.channelId.value : this.channelId,
      channelName: data.channelName.present
          ? data.channelName.value
          : this.channelName,
      marketplaceFixedCents: data.marketplaceFixedCents.present
          ? data.marketplaceFixedCents.value
          : this.marketplaceFixedCents,
      unitsPerPrint: data.unitsPerPrint.present
          ? data.unitsPerPrint.value
          : this.unitsPerPrint,
      costCents: data.costCents.present ? data.costCents.value : this.costCents,
      priceCents: data.priceCents.present
          ? data.priceCents.value
          : this.priceCents,
      profitCents: data.profitCents.present
          ? data.profitCents.value
          : this.profitCents,
      sourceFile: data.sourceFile.present
          ? data.sourceFile.value
          : this.sourceFile,
      stockDeducted: data.stockDeducted.present
          ? data.stockDeducted.value
          : this.stockDeducted,
      printedAt: data.printedAt.present ? data.printedAt.value : this.printedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('customer: $customer, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('quantity: $quantity, ')
          ..write('printerId: $printerId, ')
          ..write('printerName: $printerName, ')
          ..write('powerWatts: $powerWatts, ')
          ..write('machineValueCents: $machineValueCents, ')
          ..write('lifespanHours: $lifespanHours, ')
          ..write('maintenancePerHourCents: $maintenancePerHourCents, ')
          ..write('printSeconds: $printSeconds, ')
          ..write('postProcessMinutes: $postProcessMinutes, ')
          ..write('kwhPrice: $kwhPrice, ')
          ..write('laborHourCents: $laborHourCents, ')
          ..write('packagingCents: $packagingCents, ')
          ..write('wasteBp: $wasteBp, ')
          ..write('failureBp: $failureBp, ')
          ..write('marginBp: $marginBp, ')
          ..write('marketplaceFeeBp: $marketplaceFeeBp, ')
          ..write('taxBp: $taxBp, ')
          ..write('priceRounding: $priceRounding, ')
          ..write('channelId: $channelId, ')
          ..write('channelName: $channelName, ')
          ..write('marketplaceFixedCents: $marketplaceFixedCents, ')
          ..write('unitsPerPrint: $unitsPerPrint, ')
          ..write('costCents: $costCents, ')
          ..write('priceCents: $priceCents, ')
          ..write('profitCents: $profitCents, ')
          ..write('sourceFile: $sourceFile, ')
          ..write('stockDeducted: $stockDeducted, ')
          ..write('printedAt: $printedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    customer,
    photoPath,
    notes,
    status,
    quantity,
    printerId,
    printerName,
    powerWatts,
    machineValueCents,
    lifespanHours,
    maintenancePerHourCents,
    printSeconds,
    postProcessMinutes,
    kwhPrice,
    laborHourCents,
    packagingCents,
    wasteBp,
    failureBp,
    marginBp,
    marketplaceFeeBp,
    taxBp,
    priceRounding,
    channelId,
    channelName,
    marketplaceFixedCents,
    unitsPerPrint,
    costCents,
    priceCents,
    profitCents,
    sourceFile,
    stockDeducted,
    printedAt,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.customer == this.customer &&
          other.photoPath == this.photoPath &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.quantity == this.quantity &&
          other.printerId == this.printerId &&
          other.printerName == this.printerName &&
          other.powerWatts == this.powerWatts &&
          other.machineValueCents == this.machineValueCents &&
          other.lifespanHours == this.lifespanHours &&
          other.maintenancePerHourCents == this.maintenancePerHourCents &&
          other.printSeconds == this.printSeconds &&
          other.postProcessMinutes == this.postProcessMinutes &&
          other.kwhPrice == this.kwhPrice &&
          other.laborHourCents == this.laborHourCents &&
          other.packagingCents == this.packagingCents &&
          other.wasteBp == this.wasteBp &&
          other.failureBp == this.failureBp &&
          other.marginBp == this.marginBp &&
          other.marketplaceFeeBp == this.marketplaceFeeBp &&
          other.taxBp == this.taxBp &&
          other.priceRounding == this.priceRounding &&
          other.channelId == this.channelId &&
          other.channelName == this.channelName &&
          other.marketplaceFixedCents == this.marketplaceFixedCents &&
          other.unitsPerPrint == this.unitsPerPrint &&
          other.costCents == this.costCents &&
          other.priceCents == this.priceCents &&
          other.profitCents == this.profitCents &&
          other.sourceFile == this.sourceFile &&
          other.stockDeducted == this.stockDeducted &&
          other.printedAt == this.printedAt &&
          other.createdAt == this.createdAt);
}

class JobsCompanion extends UpdateCompanion<JobRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> customer;
  final Value<String?> photoPath;
  final Value<String?> notes;
  final Value<JobStatus> status;
  final Value<int> quantity;
  final Value<int?> printerId;
  final Value<String?> printerName;
  final Value<int> powerWatts;
  final Value<int> machineValueCents;
  final Value<int> lifespanHours;
  final Value<int> maintenancePerHourCents;
  final Value<int> printSeconds;
  final Value<int> postProcessMinutes;
  final Value<int> kwhPrice;
  final Value<int> laborHourCents;
  final Value<int> packagingCents;
  final Value<int> wasteBp;
  final Value<int> failureBp;
  final Value<int> marginBp;
  final Value<int> marketplaceFeeBp;
  final Value<int> taxBp;
  final Value<PriceRounding> priceRounding;
  final Value<int?> channelId;
  final Value<String?> channelName;
  final Value<int> marketplaceFixedCents;
  final Value<int> unitsPerPrint;
  final Value<int> costCents;
  final Value<int> priceCents;
  final Value<int> profitCents;
  final Value<String?> sourceFile;
  final Value<bool> stockDeducted;
  final Value<DateTime?> printedAt;
  final Value<DateTime> createdAt;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.customer = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.quantity = const Value.absent(),
    this.printerId = const Value.absent(),
    this.printerName = const Value.absent(),
    this.powerWatts = const Value.absent(),
    this.machineValueCents = const Value.absent(),
    this.lifespanHours = const Value.absent(),
    this.maintenancePerHourCents = const Value.absent(),
    this.printSeconds = const Value.absent(),
    this.postProcessMinutes = const Value.absent(),
    this.kwhPrice = const Value.absent(),
    this.laborHourCents = const Value.absent(),
    this.packagingCents = const Value.absent(),
    this.wasteBp = const Value.absent(),
    this.failureBp = const Value.absent(),
    this.marginBp = const Value.absent(),
    this.marketplaceFeeBp = const Value.absent(),
    this.taxBp = const Value.absent(),
    this.priceRounding = const Value.absent(),
    this.channelId = const Value.absent(),
    this.channelName = const Value.absent(),
    this.marketplaceFixedCents = const Value.absent(),
    this.unitsPerPrint = const Value.absent(),
    this.costCents = const Value.absent(),
    this.priceCents = const Value.absent(),
    this.profitCents = const Value.absent(),
    this.sourceFile = const Value.absent(),
    this.stockDeducted = const Value.absent(),
    this.printedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  JobsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.customer = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
    required JobStatus status,
    this.quantity = const Value.absent(),
    this.printerId = const Value.absent(),
    this.printerName = const Value.absent(),
    this.powerWatts = const Value.absent(),
    this.machineValueCents = const Value.absent(),
    this.lifespanHours = const Value.absent(),
    this.maintenancePerHourCents = const Value.absent(),
    required int printSeconds,
    required int postProcessMinutes,
    required int kwhPrice,
    required int laborHourCents,
    required int packagingCents,
    required int wasteBp,
    required int failureBp,
    required int marginBp,
    required int marketplaceFeeBp,
    required int taxBp,
    required PriceRounding priceRounding,
    this.channelId = const Value.absent(),
    this.channelName = const Value.absent(),
    this.marketplaceFixedCents = const Value.absent(),
    this.unitsPerPrint = const Value.absent(),
    required int costCents,
    required int priceCents,
    required int profitCents,
    this.sourceFile = const Value.absent(),
    this.stockDeducted = const Value.absent(),
    this.printedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       status = Value(status),
       printSeconds = Value(printSeconds),
       postProcessMinutes = Value(postProcessMinutes),
       kwhPrice = Value(kwhPrice),
       laborHourCents = Value(laborHourCents),
       packagingCents = Value(packagingCents),
       wasteBp = Value(wasteBp),
       failureBp = Value(failureBp),
       marginBp = Value(marginBp),
       marketplaceFeeBp = Value(marketplaceFeeBp),
       taxBp = Value(taxBp),
       priceRounding = Value(priceRounding),
       costCents = Value(costCents),
       priceCents = Value(priceCents),
       profitCents = Value(profitCents);
  static Insertable<JobRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? customer,
    Expression<String>? photoPath,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<int>? quantity,
    Expression<int>? printerId,
    Expression<String>? printerName,
    Expression<int>? powerWatts,
    Expression<int>? machineValueCents,
    Expression<int>? lifespanHours,
    Expression<int>? maintenancePerHourCents,
    Expression<int>? printSeconds,
    Expression<int>? postProcessMinutes,
    Expression<int>? kwhPrice,
    Expression<int>? laborHourCents,
    Expression<int>? packagingCents,
    Expression<int>? wasteBp,
    Expression<int>? failureBp,
    Expression<int>? marginBp,
    Expression<int>? marketplaceFeeBp,
    Expression<int>? taxBp,
    Expression<String>? priceRounding,
    Expression<int>? channelId,
    Expression<String>? channelName,
    Expression<int>? marketplaceFixedCents,
    Expression<int>? unitsPerPrint,
    Expression<int>? costCents,
    Expression<int>? priceCents,
    Expression<int>? profitCents,
    Expression<String>? sourceFile,
    Expression<bool>? stockDeducted,
    Expression<DateTime>? printedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (customer != null) 'customer': customer,
      if (photoPath != null) 'photo_path': photoPath,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (quantity != null) 'quantity': quantity,
      if (printerId != null) 'printer_id': printerId,
      if (printerName != null) 'printer_name': printerName,
      if (powerWatts != null) 'power_watts': powerWatts,
      if (machineValueCents != null) 'machine_value_cents': machineValueCents,
      if (lifespanHours != null) 'lifespan_hours': lifespanHours,
      if (maintenancePerHourCents != null)
        'maintenance_per_hour_cents': maintenancePerHourCents,
      if (printSeconds != null) 'print_seconds': printSeconds,
      if (postProcessMinutes != null)
        'post_process_minutes': postProcessMinutes,
      if (kwhPrice != null) 'kwh_price': kwhPrice,
      if (laborHourCents != null) 'labor_hour_cents': laborHourCents,
      if (packagingCents != null) 'packaging_cents': packagingCents,
      if (wasteBp != null) 'waste_bp': wasteBp,
      if (failureBp != null) 'failure_bp': failureBp,
      if (marginBp != null) 'margin_bp': marginBp,
      if (marketplaceFeeBp != null) 'marketplace_fee_bp': marketplaceFeeBp,
      if (taxBp != null) 'tax_bp': taxBp,
      if (priceRounding != null) 'price_rounding': priceRounding,
      if (channelId != null) 'channel_id': channelId,
      if (channelName != null) 'channel_name': channelName,
      if (marketplaceFixedCents != null)
        'marketplace_fixed_cents': marketplaceFixedCents,
      if (unitsPerPrint != null) 'units_per_print': unitsPerPrint,
      if (costCents != null) 'cost_cents': costCents,
      if (priceCents != null) 'price_cents': priceCents,
      if (profitCents != null) 'profit_cents': profitCents,
      if (sourceFile != null) 'source_file': sourceFile,
      if (stockDeducted != null) 'stock_deducted': stockDeducted,
      if (printedAt != null) 'printed_at': printedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  JobsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? customer,
    Value<String?>? photoPath,
    Value<String?>? notes,
    Value<JobStatus>? status,
    Value<int>? quantity,
    Value<int?>? printerId,
    Value<String?>? printerName,
    Value<int>? powerWatts,
    Value<int>? machineValueCents,
    Value<int>? lifespanHours,
    Value<int>? maintenancePerHourCents,
    Value<int>? printSeconds,
    Value<int>? postProcessMinutes,
    Value<int>? kwhPrice,
    Value<int>? laborHourCents,
    Value<int>? packagingCents,
    Value<int>? wasteBp,
    Value<int>? failureBp,
    Value<int>? marginBp,
    Value<int>? marketplaceFeeBp,
    Value<int>? taxBp,
    Value<PriceRounding>? priceRounding,
    Value<int?>? channelId,
    Value<String?>? channelName,
    Value<int>? marketplaceFixedCents,
    Value<int>? unitsPerPrint,
    Value<int>? costCents,
    Value<int>? priceCents,
    Value<int>? profitCents,
    Value<String?>? sourceFile,
    Value<bool>? stockDeducted,
    Value<DateTime?>? printedAt,
    Value<DateTime>? createdAt,
  }) {
    return JobsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      customer: customer ?? this.customer,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      printerId: printerId ?? this.printerId,
      printerName: printerName ?? this.printerName,
      powerWatts: powerWatts ?? this.powerWatts,
      machineValueCents: machineValueCents ?? this.machineValueCents,
      lifespanHours: lifespanHours ?? this.lifespanHours,
      maintenancePerHourCents:
          maintenancePerHourCents ?? this.maintenancePerHourCents,
      printSeconds: printSeconds ?? this.printSeconds,
      postProcessMinutes: postProcessMinutes ?? this.postProcessMinutes,
      kwhPrice: kwhPrice ?? this.kwhPrice,
      laborHourCents: laborHourCents ?? this.laborHourCents,
      packagingCents: packagingCents ?? this.packagingCents,
      wasteBp: wasteBp ?? this.wasteBp,
      failureBp: failureBp ?? this.failureBp,
      marginBp: marginBp ?? this.marginBp,
      marketplaceFeeBp: marketplaceFeeBp ?? this.marketplaceFeeBp,
      taxBp: taxBp ?? this.taxBp,
      priceRounding: priceRounding ?? this.priceRounding,
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
      marketplaceFixedCents:
          marketplaceFixedCents ?? this.marketplaceFixedCents,
      unitsPerPrint: unitsPerPrint ?? this.unitsPerPrint,
      costCents: costCents ?? this.costCents,
      priceCents: priceCents ?? this.priceCents,
      profitCents: profitCents ?? this.profitCents,
      sourceFile: sourceFile ?? this.sourceFile,
      stockDeducted: stockDeducted ?? this.stockDeducted,
      printedAt: printedAt ?? this.printedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (customer.present) {
      map['customer'] = Variable<String>(customer.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $JobsTable.$converterstatus.toSql(status.value),
      );
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (printerId.present) {
      map['printer_id'] = Variable<int>(printerId.value);
    }
    if (printerName.present) {
      map['printer_name'] = Variable<String>(printerName.value);
    }
    if (powerWatts.present) {
      map['power_watts'] = Variable<int>(powerWatts.value);
    }
    if (machineValueCents.present) {
      map['machine_value_cents'] = Variable<int>(machineValueCents.value);
    }
    if (lifespanHours.present) {
      map['lifespan_hours'] = Variable<int>(lifespanHours.value);
    }
    if (maintenancePerHourCents.present) {
      map['maintenance_per_hour_cents'] = Variable<int>(
        maintenancePerHourCents.value,
      );
    }
    if (printSeconds.present) {
      map['print_seconds'] = Variable<int>(printSeconds.value);
    }
    if (postProcessMinutes.present) {
      map['post_process_minutes'] = Variable<int>(postProcessMinutes.value);
    }
    if (kwhPrice.present) {
      map['kwh_price'] = Variable<int>(kwhPrice.value);
    }
    if (laborHourCents.present) {
      map['labor_hour_cents'] = Variable<int>(laborHourCents.value);
    }
    if (packagingCents.present) {
      map['packaging_cents'] = Variable<int>(packagingCents.value);
    }
    if (wasteBp.present) {
      map['waste_bp'] = Variable<int>(wasteBp.value);
    }
    if (failureBp.present) {
      map['failure_bp'] = Variable<int>(failureBp.value);
    }
    if (marginBp.present) {
      map['margin_bp'] = Variable<int>(marginBp.value);
    }
    if (marketplaceFeeBp.present) {
      map['marketplace_fee_bp'] = Variable<int>(marketplaceFeeBp.value);
    }
    if (taxBp.present) {
      map['tax_bp'] = Variable<int>(taxBp.value);
    }
    if (priceRounding.present) {
      map['price_rounding'] = Variable<String>(
        $JobsTable.$converterpriceRounding.toSql(priceRounding.value),
      );
    }
    if (channelId.present) {
      map['channel_id'] = Variable<int>(channelId.value);
    }
    if (channelName.present) {
      map['channel_name'] = Variable<String>(channelName.value);
    }
    if (marketplaceFixedCents.present) {
      map['marketplace_fixed_cents'] = Variable<int>(
        marketplaceFixedCents.value,
      );
    }
    if (unitsPerPrint.present) {
      map['units_per_print'] = Variable<int>(unitsPerPrint.value);
    }
    if (costCents.present) {
      map['cost_cents'] = Variable<int>(costCents.value);
    }
    if (priceCents.present) {
      map['price_cents'] = Variable<int>(priceCents.value);
    }
    if (profitCents.present) {
      map['profit_cents'] = Variable<int>(profitCents.value);
    }
    if (sourceFile.present) {
      map['source_file'] = Variable<String>(sourceFile.value);
    }
    if (stockDeducted.present) {
      map['stock_deducted'] = Variable<bool>(stockDeducted.value);
    }
    if (printedAt.present) {
      map['printed_at'] = Variable<DateTime>(printedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('customer: $customer, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('quantity: $quantity, ')
          ..write('printerId: $printerId, ')
          ..write('printerName: $printerName, ')
          ..write('powerWatts: $powerWatts, ')
          ..write('machineValueCents: $machineValueCents, ')
          ..write('lifespanHours: $lifespanHours, ')
          ..write('maintenancePerHourCents: $maintenancePerHourCents, ')
          ..write('printSeconds: $printSeconds, ')
          ..write('postProcessMinutes: $postProcessMinutes, ')
          ..write('kwhPrice: $kwhPrice, ')
          ..write('laborHourCents: $laborHourCents, ')
          ..write('packagingCents: $packagingCents, ')
          ..write('wasteBp: $wasteBp, ')
          ..write('failureBp: $failureBp, ')
          ..write('marginBp: $marginBp, ')
          ..write('marketplaceFeeBp: $marketplaceFeeBp, ')
          ..write('taxBp: $taxBp, ')
          ..write('priceRounding: $priceRounding, ')
          ..write('channelId: $channelId, ')
          ..write('channelName: $channelName, ')
          ..write('marketplaceFixedCents: $marketplaceFixedCents, ')
          ..write('unitsPerPrint: $unitsPerPrint, ')
          ..write('costCents: $costCents, ')
          ..write('priceCents: $priceCents, ')
          ..write('profitCents: $profitCents, ')
          ..write('sourceFile: $sourceFile, ')
          ..write('stockDeducted: $stockDeducted, ')
          ..write('printedAt: $printedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $JobFilamentsTable extends JobFilaments
    with TableInfo<$JobFilamentsTable, JobFilamentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobFilamentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _filamentIdMeta = const VerificationMeta(
    'filamentId',
  );
  @override
  late final GeneratedColumn<int> filamentId = GeneratedColumn<int>(
    'filament_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES filaments (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMgMeta = const VerificationMeta(
    'weightMg',
  );
  @override
  late final GeneratedColumn<int> weightMg = GeneratedColumn<int>(
    'weight_mg',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rollPriceCentsMeta = const VerificationMeta(
    'rollPriceCents',
  );
  @override
  late final GeneratedColumn<int> rollPriceCents = GeneratedColumn<int>(
    'roll_price_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rollWeightGramsMeta = const VerificationMeta(
    'rollWeightGrams',
  );
  @override
  late final GeneratedColumn<int> rollWeightGrams = GeneratedColumn<int>(
    'roll_weight_grams',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jobId,
    filamentId,
    label,
    weightMg,
    rollPriceCents,
    rollWeightGrams,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_filaments';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobFilamentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('filament_id')) {
      context.handle(
        _filamentIdMeta,
        filamentId.isAcceptableOrUnknown(data['filament_id']!, _filamentIdMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('weight_mg')) {
      context.handle(
        _weightMgMeta,
        weightMg.isAcceptableOrUnknown(data['weight_mg']!, _weightMgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMgMeta);
    }
    if (data.containsKey('roll_price_cents')) {
      context.handle(
        _rollPriceCentsMeta,
        rollPriceCents.isAcceptableOrUnknown(
          data['roll_price_cents']!,
          _rollPriceCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rollPriceCentsMeta);
    }
    if (data.containsKey('roll_weight_grams')) {
      context.handle(
        _rollWeightGramsMeta,
        rollWeightGrams.isAcceptableOrUnknown(
          data['roll_weight_grams']!,
          _rollWeightGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rollWeightGramsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobFilamentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobFilamentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}job_id'],
      )!,
      filamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}filament_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      weightMg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight_mg'],
      )!,
      rollPriceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}roll_price_cents'],
      )!,
      rollWeightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}roll_weight_grams'],
      )!,
    );
  }

  @override
  $JobFilamentsTable createAlias(String alias) {
    return $JobFilamentsTable(attachedDatabase, alias);
  }
}

class JobFilamentRow extends DataClass implements Insertable<JobFilamentRow> {
  final int id;
  final int jobId;
  final int? filamentId;

  /// Snapshot so history survives filament edits/deletion.
  final String label;
  final int weightMg;
  final int rollPriceCents;
  final int rollWeightGrams;
  const JobFilamentRow({
    required this.id,
    required this.jobId,
    this.filamentId,
    required this.label,
    required this.weightMg,
    required this.rollPriceCents,
    required this.rollWeightGrams,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<int>(jobId);
    if (!nullToAbsent || filamentId != null) {
      map['filament_id'] = Variable<int>(filamentId);
    }
    map['label'] = Variable<String>(label);
    map['weight_mg'] = Variable<int>(weightMg);
    map['roll_price_cents'] = Variable<int>(rollPriceCents);
    map['roll_weight_grams'] = Variable<int>(rollWeightGrams);
    return map;
  }

  JobFilamentsCompanion toCompanion(bool nullToAbsent) {
    return JobFilamentsCompanion(
      id: Value(id),
      jobId: Value(jobId),
      filamentId: filamentId == null && nullToAbsent
          ? const Value.absent()
          : Value(filamentId),
      label: Value(label),
      weightMg: Value(weightMg),
      rollPriceCents: Value(rollPriceCents),
      rollWeightGrams: Value(rollWeightGrams),
    );
  }

  factory JobFilamentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobFilamentRow(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<int>(json['jobId']),
      filamentId: serializer.fromJson<int?>(json['filamentId']),
      label: serializer.fromJson<String>(json['label']),
      weightMg: serializer.fromJson<int>(json['weightMg']),
      rollPriceCents: serializer.fromJson<int>(json['rollPriceCents']),
      rollWeightGrams: serializer.fromJson<int>(json['rollWeightGrams']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<int>(jobId),
      'filamentId': serializer.toJson<int?>(filamentId),
      'label': serializer.toJson<String>(label),
      'weightMg': serializer.toJson<int>(weightMg),
      'rollPriceCents': serializer.toJson<int>(rollPriceCents),
      'rollWeightGrams': serializer.toJson<int>(rollWeightGrams),
    };
  }

  JobFilamentRow copyWith({
    int? id,
    int? jobId,
    Value<int?> filamentId = const Value.absent(),
    String? label,
    int? weightMg,
    int? rollPriceCents,
    int? rollWeightGrams,
  }) => JobFilamentRow(
    id: id ?? this.id,
    jobId: jobId ?? this.jobId,
    filamentId: filamentId.present ? filamentId.value : this.filamentId,
    label: label ?? this.label,
    weightMg: weightMg ?? this.weightMg,
    rollPriceCents: rollPriceCents ?? this.rollPriceCents,
    rollWeightGrams: rollWeightGrams ?? this.rollWeightGrams,
  );
  JobFilamentRow copyWithCompanion(JobFilamentsCompanion data) {
    return JobFilamentRow(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      filamentId: data.filamentId.present
          ? data.filamentId.value
          : this.filamentId,
      label: data.label.present ? data.label.value : this.label,
      weightMg: data.weightMg.present ? data.weightMg.value : this.weightMg,
      rollPriceCents: data.rollPriceCents.present
          ? data.rollPriceCents.value
          : this.rollPriceCents,
      rollWeightGrams: data.rollWeightGrams.present
          ? data.rollWeightGrams.value
          : this.rollWeightGrams,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobFilamentRow(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('filamentId: $filamentId, ')
          ..write('label: $label, ')
          ..write('weightMg: $weightMg, ')
          ..write('rollPriceCents: $rollPriceCents, ')
          ..write('rollWeightGrams: $rollWeightGrams')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    jobId,
    filamentId,
    label,
    weightMg,
    rollPriceCents,
    rollWeightGrams,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobFilamentRow &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.filamentId == this.filamentId &&
          other.label == this.label &&
          other.weightMg == this.weightMg &&
          other.rollPriceCents == this.rollPriceCents &&
          other.rollWeightGrams == this.rollWeightGrams);
}

class JobFilamentsCompanion extends UpdateCompanion<JobFilamentRow> {
  final Value<int> id;
  final Value<int> jobId;
  final Value<int?> filamentId;
  final Value<String> label;
  final Value<int> weightMg;
  final Value<int> rollPriceCents;
  final Value<int> rollWeightGrams;
  const JobFilamentsCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.filamentId = const Value.absent(),
    this.label = const Value.absent(),
    this.weightMg = const Value.absent(),
    this.rollPriceCents = const Value.absent(),
    this.rollWeightGrams = const Value.absent(),
  });
  JobFilamentsCompanion.insert({
    this.id = const Value.absent(),
    required int jobId,
    this.filamentId = const Value.absent(),
    required String label,
    required int weightMg,
    required int rollPriceCents,
    required int rollWeightGrams,
  }) : jobId = Value(jobId),
       label = Value(label),
       weightMg = Value(weightMg),
       rollPriceCents = Value(rollPriceCents),
       rollWeightGrams = Value(rollWeightGrams);
  static Insertable<JobFilamentRow> custom({
    Expression<int>? id,
    Expression<int>? jobId,
    Expression<int>? filamentId,
    Expression<String>? label,
    Expression<int>? weightMg,
    Expression<int>? rollPriceCents,
    Expression<int>? rollWeightGrams,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (filamentId != null) 'filament_id': filamentId,
      if (label != null) 'label': label,
      if (weightMg != null) 'weight_mg': weightMg,
      if (rollPriceCents != null) 'roll_price_cents': rollPriceCents,
      if (rollWeightGrams != null) 'roll_weight_grams': rollWeightGrams,
    });
  }

  JobFilamentsCompanion copyWith({
    Value<int>? id,
    Value<int>? jobId,
    Value<int?>? filamentId,
    Value<String>? label,
    Value<int>? weightMg,
    Value<int>? rollPriceCents,
    Value<int>? rollWeightGrams,
  }) {
    return JobFilamentsCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      filamentId: filamentId ?? this.filamentId,
      label: label ?? this.label,
      weightMg: weightMg ?? this.weightMg,
      rollPriceCents: rollPriceCents ?? this.rollPriceCents,
      rollWeightGrams: rollWeightGrams ?? this.rollWeightGrams,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (filamentId.present) {
      map['filament_id'] = Variable<int>(filamentId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (weightMg.present) {
      map['weight_mg'] = Variable<int>(weightMg.value);
    }
    if (rollPriceCents.present) {
      map['roll_price_cents'] = Variable<int>(rollPriceCents.value);
    }
    if (rollWeightGrams.present) {
      map['roll_weight_grams'] = Variable<int>(rollWeightGrams.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobFilamentsCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('filamentId: $filamentId, ')
          ..write('label: $label, ')
          ..write('weightMg: $weightMg, ')
          ..write('rollPriceCents: $rollPriceCents, ')
          ..write('rollWeightGrams: $rollWeightGrams')
          ..write(')'))
        .toString();
  }
}

class $PrinterConnectionsTable extends PrinterConnections
    with TableInfo<$PrinterConnectionsTable, PrinterConnectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrinterConnectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('bambu_lan'),
  );
  static const VerificationMeta _hostMeta = const VerificationMeta('host');
  @override
  late final GeneratedColumn<String> host = GeneratedColumn<String>(
    'host',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serialMeta = const VerificationMeta('serial');
  @override
  late final GeneratedColumn<String> serial = GeneratedColumn<String>(
    'serial',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _printerIdMeta = const VerificationMeta(
    'printerId',
  );
  @override
  late final GeneratedColumn<int> printerId = GeneratedColumn<int>(
    'printer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES printers (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    kind,
    host,
    serial,
    printerId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'printer_connections';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrinterConnectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('host')) {
      context.handle(
        _hostMeta,
        host.isAcceptableOrUnknown(data['host']!, _hostMeta),
      );
    } else if (isInserting) {
      context.missing(_hostMeta);
    }
    if (data.containsKey('serial')) {
      context.handle(
        _serialMeta,
        serial.isAcceptableOrUnknown(data['serial']!, _serialMeta),
      );
    } else if (isInserting) {
      context.missing(_serialMeta);
    }
    if (data.containsKey('printer_id')) {
      context.handle(
        _printerIdMeta,
        printerId.isAcceptableOrUnknown(data['printer_id']!, _printerIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrinterConnectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrinterConnectionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      host: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}host'],
      )!,
      serial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial'],
      )!,
      printerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}printer_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PrinterConnectionsTable createAlias(String alias) {
    return $PrinterConnectionsTable(attachedDatabase, alias);
  }
}

class PrinterConnectionRow extends DataClass
    implements Insertable<PrinterConnectionRow> {
  final int id;
  final String name;

  /// bambu_lan (future: moonraker, ...)
  final String kind;
  final String host;
  final String serial;

  /// Registered printer used for cost (power, wear) when registering prints.
  final int? printerId;
  final DateTime createdAt;
  const PrinterConnectionRow({
    required this.id,
    required this.name,
    required this.kind,
    required this.host,
    required this.serial,
    this.printerId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['host'] = Variable<String>(host);
    map['serial'] = Variable<String>(serial);
    if (!nullToAbsent || printerId != null) {
      map['printer_id'] = Variable<int>(printerId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PrinterConnectionsCompanion toCompanion(bool nullToAbsent) {
    return PrinterConnectionsCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      host: Value(host),
      serial: Value(serial),
      printerId: printerId == null && nullToAbsent
          ? const Value.absent()
          : Value(printerId),
      createdAt: Value(createdAt),
    );
  }

  factory PrinterConnectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrinterConnectionRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      host: serializer.fromJson<String>(json['host']),
      serial: serializer.fromJson<String>(json['serial']),
      printerId: serializer.fromJson<int?>(json['printerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'host': serializer.toJson<String>(host),
      'serial': serializer.toJson<String>(serial),
      'printerId': serializer.toJson<int?>(printerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PrinterConnectionRow copyWith({
    int? id,
    String? name,
    String? kind,
    String? host,
    String? serial,
    Value<int?> printerId = const Value.absent(),
    DateTime? createdAt,
  }) => PrinterConnectionRow(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    host: host ?? this.host,
    serial: serial ?? this.serial,
    printerId: printerId.present ? printerId.value : this.printerId,
    createdAt: createdAt ?? this.createdAt,
  );
  PrinterConnectionRow copyWithCompanion(PrinterConnectionsCompanion data) {
    return PrinterConnectionRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      host: data.host.present ? data.host.value : this.host,
      serial: data.serial.present ? data.serial.value : this.serial,
      printerId: data.printerId.present ? data.printerId.value : this.printerId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrinterConnectionRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('host: $host, ')
          ..write('serial: $serial, ')
          ..write('printerId: $printerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, kind, host, serial, printerId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrinterConnectionRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.host == this.host &&
          other.serial == this.serial &&
          other.printerId == this.printerId &&
          other.createdAt == this.createdAt);
}

class PrinterConnectionsCompanion
    extends UpdateCompanion<PrinterConnectionRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> kind;
  final Value<String> host;
  final Value<String> serial;
  final Value<int?> printerId;
  final Value<DateTime> createdAt;
  const PrinterConnectionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.host = const Value.absent(),
    this.serial = const Value.absent(),
    this.printerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PrinterConnectionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.kind = const Value.absent(),
    required String host,
    required String serial,
    this.printerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       host = Value(host),
       serial = Value(serial);
  static Insertable<PrinterConnectionRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? host,
    Expression<String>? serial,
    Expression<int>? printerId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (host != null) 'host': host,
      if (serial != null) 'serial': serial,
      if (printerId != null) 'printer_id': printerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PrinterConnectionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? kind,
    Value<String>? host,
    Value<String>? serial,
    Value<int?>? printerId,
    Value<DateTime>? createdAt,
  }) {
    return PrinterConnectionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      host: host ?? this.host,
      serial: serial ?? this.serial,
      printerId: printerId ?? this.printerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (host.present) {
      map['host'] = Variable<String>(host.value);
    }
    if (serial.present) {
      map['serial'] = Variable<String>(serial.value);
    }
    if (printerId.present) {
      map['printer_id'] = Variable<int>(printerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrinterConnectionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('host: $host, ')
          ..write('serial: $serial, ')
          ..write('printerId: $printerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FilamentsTable filaments = $FilamentsTable(this);
  late final $PrintersTable printers = $PrintersTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $SalesChannelsTable salesChannels = $SalesChannelsTable(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final $JobFilamentsTable jobFilaments = $JobFilamentsTable(this);
  late final $PrinterConnectionsTable printerConnections =
      $PrinterConnectionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    filaments,
    printers,
    appSettings,
    salesChannels,
    jobs,
    jobFilaments,
    printerConnections,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'printers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('jobs', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sales_channels',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('jobs', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'jobs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('job_filaments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'filaments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('job_filaments', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'printers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('printer_connections', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$FilamentsTableCreateCompanionBuilder = FilamentsCompanion Function({
  Value<int> id,
  required String brand,
  required String material,
  Value<String> colorName,
  Value<int?> colorArgb,
  required int rollPriceCents,
  Value<int> rollWeightGrams,
  required int stockMg,
  Value<int> lowStockAlertMg,
  Value<bool> archived,
  Value<DateTime> createdAt,
});
typedef $$FilamentsTableUpdateCompanionBuilder = FilamentsCompanion Function({
  Value<int> id,
  Value<String> brand,
  Value<String> material,
  Value<String> colorName,
  Value<int?> colorArgb,
  Value<int> rollPriceCents,
  Value<int> rollWeightGrams,
  Value<int> stockMg,
  Value<int> lowStockAlertMg,
  Value<bool> archived,
  Value<DateTime> createdAt,
});

final class $$FilamentsTableReferences
    extends BaseReferences<_$AppDatabase, $FilamentsTable, FilamentRow> {
  $$FilamentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$JobFilamentsTable, List<JobFilamentRow>>
  _jobFilamentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.jobFilaments,
    aliasName: 'filaments__id__job_filaments__filament_id',
  );

  $$JobFilamentsTableProcessedTableManager get jobFilamentsRefs {
    final manager = $$JobFilamentsTableTableManager(
      $_db,
      $_db.jobFilaments,
    ).filter((f) => f.filamentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobFilamentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FilamentsTableFilterComposer
    extends Composer<_$AppDatabase, $FilamentsTable> {
  $$FilamentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorName => $composableBuilder(
    column: $table.colorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorArgb => $composableBuilder(
    column: $table.colorArgb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollPriceCents => $composableBuilder(
    column: $table.rollPriceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollWeightGrams => $composableBuilder(
    column: $table.rollWeightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockMg => $composableBuilder(
    column: $table.stockMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lowStockAlertMg => $composableBuilder(
    column: $table.lowStockAlertMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> jobFilamentsRefs(
    Expression<bool> Function($$JobFilamentsTableFilterComposer f) f,
  ) {
    final $$JobFilamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobFilaments,
      getReferencedColumn: (t) => t.filamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobFilamentsTableFilterComposer(
            $db: $db,
            $table: $db.jobFilaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FilamentsTableOrderingComposer
    extends Composer<_$AppDatabase, $FilamentsTable> {
  $$FilamentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorName => $composableBuilder(
    column: $table.colorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorArgb => $composableBuilder(
    column: $table.colorArgb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollPriceCents => $composableBuilder(
    column: $table.rollPriceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollWeightGrams => $composableBuilder(
    column: $table.rollWeightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockMg => $composableBuilder(
    column: $table.stockMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lowStockAlertMg => $composableBuilder(
    column: $table.lowStockAlertMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FilamentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FilamentsTable> {
  $$FilamentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get material =>
      $composableBuilder(column: $table.material, builder: (column) => column);

  GeneratedColumn<String> get colorName =>
      $composableBuilder(column: $table.colorName, builder: (column) => column);

  GeneratedColumn<int> get colorArgb =>
      $composableBuilder(column: $table.colorArgb, builder: (column) => column);

  GeneratedColumn<int> get rollPriceCents => $composableBuilder(
    column: $table.rollPriceCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rollWeightGrams => $composableBuilder(
    column: $table.rollWeightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockMg =>
      $composableBuilder(column: $table.stockMg, builder: (column) => column);

  GeneratedColumn<int> get lowStockAlertMg => $composableBuilder(
    column: $table.lowStockAlertMg,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> jobFilamentsRefs<T extends Object>(
    Expression<T> Function($$JobFilamentsTableAnnotationComposer a) f,
  ) {
    final $$JobFilamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobFilaments,
      getReferencedColumn: (t) => t.filamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobFilamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobFilaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FilamentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FilamentsTable,
          FilamentRow,
          $$FilamentsTableFilterComposer,
          $$FilamentsTableOrderingComposer,
          $$FilamentsTableAnnotationComposer,
          $$FilamentsTableCreateCompanionBuilder,
          $$FilamentsTableUpdateCompanionBuilder,
          (FilamentRow, $$FilamentsTableReferences),
          FilamentRow,
          PrefetchHooks Function({bool jobFilamentsRefs})
        > {
  $$FilamentsTableTableManager(_$AppDatabase db, $FilamentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilamentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilamentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilamentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> material = const Value.absent(),
                Value<String> colorName = const Value.absent(),
                Value<int?> colorArgb = const Value.absent(),
                Value<int> rollPriceCents = const Value.absent(),
                Value<int> rollWeightGrams = const Value.absent(),
                Value<int> stockMg = const Value.absent(),
                Value<int> lowStockAlertMg = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FilamentsCompanion(
                id: id,
                brand: brand,
                material: material,
                colorName: colorName,
                colorArgb: colorArgb,
                rollPriceCents: rollPriceCents,
                rollWeightGrams: rollWeightGrams,
                stockMg: stockMg,
                lowStockAlertMg: lowStockAlertMg,
                archived: archived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String brand,
                required String material,
                Value<String> colorName = const Value.absent(),
                Value<int?> colorArgb = const Value.absent(),
                required int rollPriceCents,
                Value<int> rollWeightGrams = const Value.absent(),
                required int stockMg,
                Value<int> lowStockAlertMg = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FilamentsCompanion.insert(
                id: id,
                brand: brand,
                material: material,
                colorName: colorName,
                colorArgb: colorArgb,
                rollPriceCents: rollPriceCents,
                rollWeightGrams: rollWeightGrams,
                stockMg: stockMg,
                lowStockAlertMg: lowStockAlertMg,
                archived: archived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FilamentsTable, FilamentRow>(table),
                  $$FilamentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({jobFilamentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (jobFilamentsRefs) db.jobFilaments],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (jobFilamentsRefs)
                    await $_getPrefetchedDataByColumns<
                      FilamentRow,
                      $FilamentsTable,
                      JobFilamentRow,
                      $JobFilamentsTable
                    >(
                      currentTable: table,
                      referencedTable: $$FilamentsTableReferences
                          ._jobFilamentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FilamentsTableReferences(
                            db,
                            table,
                            p0,
                          ).jobFilamentsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'filament_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FilamentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FilamentsTable,
      FilamentRow,
      $$FilamentsTableFilterComposer,
      $$FilamentsTableOrderingComposer,
      $$FilamentsTableAnnotationComposer,
      $$FilamentsTableCreateCompanionBuilder,
      $$FilamentsTableUpdateCompanionBuilder,
      (FilamentRow, $$FilamentsTableReferences),
      FilamentRow,
      PrefetchHooks Function({bool jobFilamentsRefs})
    >;
typedef $$PrintersTableCreateCompanionBuilder = PrintersCompanion Function({
  Value<int> id,
  required String name,
  required int powerWatts,
  required int machineValueCents,
  required int lifespanHours,
  Value<int> maintenancePerHourCents,
  Value<bool> archived,
  Value<DateTime> createdAt,
});
typedef $$PrintersTableUpdateCompanionBuilder = PrintersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> powerWatts,
  Value<int> machineValueCents,
  Value<int> lifespanHours,
  Value<int> maintenancePerHourCents,
  Value<bool> archived,
  Value<DateTime> createdAt,
});

final class $$PrintersTableReferences
    extends BaseReferences<_$AppDatabase, $PrintersTable, PrinterRow> {
  $$PrintersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$JobsTable, List<JobRow>> _jobsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.jobs,
    aliasName: 'printers__id__jobs__printer_id',
  );

  $$JobsTableProcessedTableManager get jobsRefs {
    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.printerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PrinterConnectionsTable,
    List<PrinterConnectionRow>
  >
  _printerConnectionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.printerConnections,
        aliasName: 'printers__id__printer_connections__printer_id',
      );

  $$PrinterConnectionsTableProcessedTableManager get printerConnectionsRefs {
    final manager = $$PrinterConnectionsTableTableManager(
      $_db,
      $_db.printerConnections,
    ).filter((f) => f.printerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _printerConnectionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PrintersTableFilterComposer
    extends Composer<_$AppDatabase, $PrintersTable> {
  $$PrintersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get powerWatts => $composableBuilder(
    column: $table.powerWatts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get machineValueCents => $composableBuilder(
    column: $table.machineValueCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lifespanHours => $composableBuilder(
    column: $table.lifespanHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maintenancePerHourCents => $composableBuilder(
    column: $table.maintenancePerHourCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> jobsRefs(
    Expression<bool> Function($$JobsTableFilterComposer f) f,
  ) {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.printerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> printerConnectionsRefs(
    Expression<bool> Function($$PrinterConnectionsTableFilterComposer f) f,
  ) {
    final $$PrinterConnectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.printerConnections,
      getReferencedColumn: (t) => t.printerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrinterConnectionsTableFilterComposer(
            $db: $db,
            $table: $db.printerConnections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PrintersTableOrderingComposer
    extends Composer<_$AppDatabase, $PrintersTable> {
  $$PrintersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get powerWatts => $composableBuilder(
    column: $table.powerWatts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get machineValueCents => $composableBuilder(
    column: $table.machineValueCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lifespanHours => $composableBuilder(
    column: $table.lifespanHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maintenancePerHourCents => $composableBuilder(
    column: $table.maintenancePerHourCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrintersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrintersTable> {
  $$PrintersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get powerWatts => $composableBuilder(
    column: $table.powerWatts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get machineValueCents => $composableBuilder(
    column: $table.machineValueCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lifespanHours => $composableBuilder(
    column: $table.lifespanHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maintenancePerHourCents => $composableBuilder(
    column: $table.maintenancePerHourCents,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> jobsRefs<T extends Object>(
    Expression<T> Function($$JobsTableAnnotationComposer a) f,
  ) {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.printerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> printerConnectionsRefs<T extends Object>(
    Expression<T> Function($$PrinterConnectionsTableAnnotationComposer a) f,
  ) {
    final $$PrinterConnectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.printerConnections,
          getReferencedColumn: (t) => t.printerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PrinterConnectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.printerConnections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PrintersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrintersTable,
          PrinterRow,
          $$PrintersTableFilterComposer,
          $$PrintersTableOrderingComposer,
          $$PrintersTableAnnotationComposer,
          $$PrintersTableCreateCompanionBuilder,
          $$PrintersTableUpdateCompanionBuilder,
          (PrinterRow, $$PrintersTableReferences),
          PrinterRow,
          PrefetchHooks Function({bool jobsRefs, bool printerConnectionsRefs})
        > {
  $$PrintersTableTableManager(_$AppDatabase db, $PrintersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrintersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrintersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrintersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> powerWatts = const Value.absent(),
                Value<int> machineValueCents = const Value.absent(),
                Value<int> lifespanHours = const Value.absent(),
                Value<int> maintenancePerHourCents = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PrintersCompanion(
                id: id,
                name: name,
                powerWatts: powerWatts,
                machineValueCents: machineValueCents,
                lifespanHours: lifespanHours,
                maintenancePerHourCents: maintenancePerHourCents,
                archived: archived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int powerWatts,
                required int machineValueCents,
                required int lifespanHours,
                Value<int> maintenancePerHourCents = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PrintersCompanion.insert(
                id: id,
                name: name,
                powerWatts: powerWatts,
                machineValueCents: machineValueCents,
                lifespanHours: lifespanHours,
                maintenancePerHourCents: maintenancePerHourCents,
                archived: archived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrintersTable, PrinterRow>(table),
                  $$PrintersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({jobsRefs = false, printerConnectionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (jobsRefs) db.jobs,
                    if (printerConnectionsRefs) db.printerConnections,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (jobsRefs)
                        await $_getPrefetchedDataByColumns<
                          PrinterRow,
                          $PrintersTable,
                          JobRow,
                          $JobsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PrintersTableReferences
                              ._jobsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PrintersTableReferences(db, table, p0).jobsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'printer_id',
                          typedResults: items,
                        ),
                      if (printerConnectionsRefs)
                        await $_getPrefetchedDataByColumns<
                          PrinterRow,
                          $PrintersTable,
                          PrinterConnectionRow,
                          $PrinterConnectionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PrintersTableReferences
                              ._printerConnectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PrintersTableReferences(
                                db,
                                table,
                                p0,
                              ).printerConnectionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'printer_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PrintersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrintersTable,
      PrinterRow,
      $$PrintersTableFilterComposer,
      $$PrintersTableOrderingComposer,
      $$PrintersTableAnnotationComposer,
      $$PrintersTableCreateCompanionBuilder,
      $$PrintersTableUpdateCompanionBuilder,
      (PrinterRow, $$PrintersTableReferences),
      PrinterRow,
      PrefetchHooks Function({bool jobsRefs, bool printerConnectionsRefs})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> currencyCode,
      Value<String?> localeCode,
      Value<String> themeMode,
      Value<int> kwhPrice,
      Value<int> laborHourCents,
      Value<int> marketplaceFeeBp,
      Value<int> taxBp,
      Value<int> defaultMarginBp,
      Value<int> packagingCents,
      Value<int> defaultWasteBp,
      Value<int> defaultFailureBp,
      Value<PriceRounding> priceRounding,
      Value<String> shopName,
      Value<String> shopContact,
      Value<Uint8List?> shopLogo,
      Value<bool> printerModuleEnabled,
      Value<bool> onboardingDone,
      Value<int?> defaultChannelId,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> currencyCode,
      Value<String?> localeCode,
      Value<String> themeMode,
      Value<int> kwhPrice,
      Value<int> laborHourCents,
      Value<int> marketplaceFeeBp,
      Value<int> taxBp,
      Value<int> defaultMarginBp,
      Value<int> packagingCents,
      Value<int> defaultWasteBp,
      Value<int> defaultFailureBp,
      Value<PriceRounding> priceRounding,
      Value<String> shopName,
      Value<String> shopContact,
      Value<Uint8List?> shopLogo,
      Value<bool> printerModuleEnabled,
      Value<bool> onboardingDone,
      Value<int?> defaultChannelId,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kwhPrice => $composableBuilder(
    column: $table.kwhPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get laborHourCents => $composableBuilder(
    column: $table.laborHourCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get marketplaceFeeBp => $composableBuilder(
    column: $table.marketplaceFeeBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxBp => $composableBuilder(
    column: $table.taxBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultMarginBp => $composableBuilder(
    column: $table.defaultMarginBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get packagingCents => $composableBuilder(
    column: $table.packagingCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultWasteBp => $composableBuilder(
    column: $table.defaultWasteBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultFailureBp => $composableBuilder(
    column: $table.defaultFailureBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PriceRounding, PriceRounding, String>
  get priceRounding => $composableBuilder(
    column: $table.priceRounding,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopContact => $composableBuilder(
    column: $table.shopContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get shopLogo => $composableBuilder(
    column: $table.shopLogo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get printerModuleEnabled => $composableBuilder(
    column: $table.printerModuleEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultChannelId => $composableBuilder(
    column: $table.defaultChannelId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kwhPrice => $composableBuilder(
    column: $table.kwhPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get laborHourCents => $composableBuilder(
    column: $table.laborHourCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get marketplaceFeeBp => $composableBuilder(
    column: $table.marketplaceFeeBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxBp => $composableBuilder(
    column: $table.taxBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultMarginBp => $composableBuilder(
    column: $table.defaultMarginBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get packagingCents => $composableBuilder(
    column: $table.packagingCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultWasteBp => $composableBuilder(
    column: $table.defaultWasteBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultFailureBp => $composableBuilder(
    column: $table.defaultFailureBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceRounding => $composableBuilder(
    column: $table.priceRounding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopContact => $composableBuilder(
    column: $table.shopContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get shopLogo => $composableBuilder(
    column: $table.shopLogo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get printerModuleEnabled => $composableBuilder(
    column: $table.printerModuleEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultChannelId => $composableBuilder(
    column: $table.defaultChannelId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get kwhPrice =>
      $composableBuilder(column: $table.kwhPrice, builder: (column) => column);

  GeneratedColumn<int> get laborHourCents => $composableBuilder(
    column: $table.laborHourCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get marketplaceFeeBp => $composableBuilder(
    column: $table.marketplaceFeeBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxBp =>
      $composableBuilder(column: $table.taxBp, builder: (column) => column);

  GeneratedColumn<int> get defaultMarginBp => $composableBuilder(
    column: $table.defaultMarginBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get packagingCents => $composableBuilder(
    column: $table.packagingCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultWasteBp => $composableBuilder(
    column: $table.defaultWasteBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultFailureBp => $composableBuilder(
    column: $table.defaultFailureBp,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PriceRounding, String> get priceRounding =>
      $composableBuilder(
        column: $table.priceRounding,
        builder: (column) => column,
      );

  GeneratedColumn<String> get shopName =>
      $composableBuilder(column: $table.shopName, builder: (column) => column);

  GeneratedColumn<String> get shopContact => $composableBuilder(
    column: $table.shopContact,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get shopLogo =>
      $composableBuilder(column: $table.shopLogo, builder: (column) => column);

  GeneratedColumn<bool> get printerModuleEnabled => $composableBuilder(
    column: $table.printerModuleEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultChannelId => $composableBuilder(
    column: $table.defaultChannelId,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          SettingsRow,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            SettingsRow,
            BaseReferences<_$AppDatabase, $AppSettingsTable, SettingsRow>,
          ),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String?> localeCode = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> kwhPrice = const Value.absent(),
                Value<int> laborHourCents = const Value.absent(),
                Value<int> marketplaceFeeBp = const Value.absent(),
                Value<int> taxBp = const Value.absent(),
                Value<int> defaultMarginBp = const Value.absent(),
                Value<int> packagingCents = const Value.absent(),
                Value<int> defaultWasteBp = const Value.absent(),
                Value<int> defaultFailureBp = const Value.absent(),
                Value<PriceRounding> priceRounding = const Value.absent(),
                Value<String> shopName = const Value.absent(),
                Value<String> shopContact = const Value.absent(),
                Value<Uint8List?> shopLogo = const Value.absent(),
                Value<bool> printerModuleEnabled = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<int?> defaultChannelId = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                currencyCode: currencyCode,
                localeCode: localeCode,
                themeMode: themeMode,
                kwhPrice: kwhPrice,
                laborHourCents: laborHourCents,
                marketplaceFeeBp: marketplaceFeeBp,
                taxBp: taxBp,
                defaultMarginBp: defaultMarginBp,
                packagingCents: packagingCents,
                defaultWasteBp: defaultWasteBp,
                defaultFailureBp: defaultFailureBp,
                priceRounding: priceRounding,
                shopName: shopName,
                shopContact: shopContact,
                shopLogo: shopLogo,
                printerModuleEnabled: printerModuleEnabled,
                onboardingDone: onboardingDone,
                defaultChannelId: defaultChannelId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String?> localeCode = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> kwhPrice = const Value.absent(),
                Value<int> laborHourCents = const Value.absent(),
                Value<int> marketplaceFeeBp = const Value.absent(),
                Value<int> taxBp = const Value.absent(),
                Value<int> defaultMarginBp = const Value.absent(),
                Value<int> packagingCents = const Value.absent(),
                Value<int> defaultWasteBp = const Value.absent(),
                Value<int> defaultFailureBp = const Value.absent(),
                Value<PriceRounding> priceRounding = const Value.absent(),
                Value<String> shopName = const Value.absent(),
                Value<String> shopContact = const Value.absent(),
                Value<Uint8List?> shopLogo = const Value.absent(),
                Value<bool> printerModuleEnabled = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<int?> defaultChannelId = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                currencyCode: currencyCode,
                localeCode: localeCode,
                themeMode: themeMode,
                kwhPrice: kwhPrice,
                laborHourCents: laborHourCents,
                marketplaceFeeBp: marketplaceFeeBp,
                taxBp: taxBp,
                defaultMarginBp: defaultMarginBp,
                packagingCents: packagingCents,
                defaultWasteBp: defaultWasteBp,
                defaultFailureBp: defaultFailureBp,
                priceRounding: priceRounding,
                shopName: shopName,
                shopContact: shopContact,
                shopLogo: shopLogo,
                printerModuleEnabled: printerModuleEnabled,
                onboardingDone: onboardingDone,
                defaultChannelId: defaultChannelId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, SettingsRow>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, SettingsRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      SettingsRow,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        SettingsRow,
        BaseReferences<_$AppDatabase, $AppSettingsTable, SettingsRow>,
      ),
      SettingsRow,
      PrefetchHooks Function()
    >;
typedef $$SalesChannelsTableCreateCompanionBuilder =
    SalesChannelsCompanion Function({
      Value<int> id,
      required String name,
      required List<FeeTier> tiers,
      Value<bool> isExample,
      Value<String?> infoUrl,
      Value<int> sortOrder,
      Value<bool> archived,
      Value<DateTime> createdAt,
    });
typedef $$SalesChannelsTableUpdateCompanionBuilder =
    SalesChannelsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<List<FeeTier>> tiers,
      Value<bool> isExample,
      Value<String?> infoUrl,
      Value<int> sortOrder,
      Value<bool> archived,
      Value<DateTime> createdAt,
    });

final class $$SalesChannelsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SalesChannelsTable, SalesChannelRow> {
  $$SalesChannelsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$JobsTable, List<JobRow>> _jobsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.jobs,
    aliasName: 'sales_channels__id__jobs__channel_id',
  );

  $$JobsTableProcessedTableManager get jobsRefs {
    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.channelId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesChannelsTableFilterComposer
    extends Composer<_$AppDatabase, $SalesChannelsTable> {
  $$SalesChannelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<FeeTier>, List<FeeTier>, String>
  get tiers => $composableBuilder(
    column: $table.tiers,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isExample => $composableBuilder(
    column: $table.isExample,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get infoUrl => $composableBuilder(
    column: $table.infoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> jobsRefs(
    Expression<bool> Function($$JobsTableFilterComposer f) f,
  ) {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.channelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesChannelsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesChannelsTable> {
  $$SalesChannelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tiers => $composableBuilder(
    column: $table.tiers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isExample => $composableBuilder(
    column: $table.isExample,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get infoUrl => $composableBuilder(
    column: $table.infoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesChannelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesChannelsTable> {
  $$SalesChannelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<FeeTier>, String> get tiers =>
      $composableBuilder(column: $table.tiers, builder: (column) => column);

  GeneratedColumn<bool> get isExample =>
      $composableBuilder(column: $table.isExample, builder: (column) => column);

  GeneratedColumn<String> get infoUrl =>
      $composableBuilder(column: $table.infoUrl, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> jobsRefs<T extends Object>(
    Expression<T> Function($$JobsTableAnnotationComposer a) f,
  ) {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.channelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesChannelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesChannelsTable,
          SalesChannelRow,
          $$SalesChannelsTableFilterComposer,
          $$SalesChannelsTableOrderingComposer,
          $$SalesChannelsTableAnnotationComposer,
          $$SalesChannelsTableCreateCompanionBuilder,
          $$SalesChannelsTableUpdateCompanionBuilder,
          (SalesChannelRow, $$SalesChannelsTableReferences),
          SalesChannelRow,
          PrefetchHooks Function({bool jobsRefs})
        > {
  $$SalesChannelsTableTableManager(_$AppDatabase db, $SalesChannelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesChannelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesChannelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesChannelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<List<FeeTier>> tiers = const Value.absent(),
                Value<bool> isExample = const Value.absent(),
                Value<String?> infoUrl = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesChannelsCompanion(
                id: id,
                name: name,
                tiers: tiers,
                isExample: isExample,
                infoUrl: infoUrl,
                sortOrder: sortOrder,
                archived: archived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required List<FeeTier> tiers,
                Value<bool> isExample = const Value.absent(),
                Value<String?> infoUrl = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesChannelsCompanion.insert(
                id: id,
                name: name,
                tiers: tiers,
                isExample: isExample,
                infoUrl: infoUrl,
                sortOrder: sortOrder,
                archived: archived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SalesChannelsTable, SalesChannelRow>(table),
                  $$SalesChannelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({jobsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (jobsRefs) db.jobs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (jobsRefs)
                    await $_getPrefetchedDataByColumns<
                      SalesChannelRow,
                      $SalesChannelsTable,
                      JobRow,
                      $JobsTable
                    >(
                      currentTable: table,
                      referencedTable: $$SalesChannelsTableReferences
                          ._jobsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SalesChannelsTableReferences(
                            db,
                            table,
                            p0,
                          ).jobsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'channel_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SalesChannelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesChannelsTable,
      SalesChannelRow,
      $$SalesChannelsTableFilterComposer,
      $$SalesChannelsTableOrderingComposer,
      $$SalesChannelsTableAnnotationComposer,
      $$SalesChannelsTableCreateCompanionBuilder,
      $$SalesChannelsTableUpdateCompanionBuilder,
      (SalesChannelRow, $$SalesChannelsTableReferences),
      SalesChannelRow,
      PrefetchHooks Function({bool jobsRefs})
    >;
typedef $$JobsTableCreateCompanionBuilder = JobsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> customer,
  Value<String?> photoPath,
  Value<String?> notes,
  required JobStatus status,
  Value<int> quantity,
  Value<int?> printerId,
  Value<String?> printerName,
  Value<int> powerWatts,
  Value<int> machineValueCents,
  Value<int> lifespanHours,
  Value<int> maintenancePerHourCents,
  required int printSeconds,
  required int postProcessMinutes,
  required int kwhPrice,
  required int laborHourCents,
  required int packagingCents,
  required int wasteBp,
  required int failureBp,
  required int marginBp,
  required int marketplaceFeeBp,
  required int taxBp,
  required PriceRounding priceRounding,
  Value<int?> channelId,
  Value<String?> channelName,
  Value<int> marketplaceFixedCents,
  Value<int> unitsPerPrint,
  required int costCents,
  required int priceCents,
  required int profitCents,
  Value<String?> sourceFile,
  Value<bool> stockDeducted,
  Value<DateTime?> printedAt,
  Value<DateTime> createdAt,
});
typedef $$JobsTableUpdateCompanionBuilder = JobsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> customer,
  Value<String?> photoPath,
  Value<String?> notes,
  Value<JobStatus> status,
  Value<int> quantity,
  Value<int?> printerId,
  Value<String?> printerName,
  Value<int> powerWatts,
  Value<int> machineValueCents,
  Value<int> lifespanHours,
  Value<int> maintenancePerHourCents,
  Value<int> printSeconds,
  Value<int> postProcessMinutes,
  Value<int> kwhPrice,
  Value<int> laborHourCents,
  Value<int> packagingCents,
  Value<int> wasteBp,
  Value<int> failureBp,
  Value<int> marginBp,
  Value<int> marketplaceFeeBp,
  Value<int> taxBp,
  Value<PriceRounding> priceRounding,
  Value<int?> channelId,
  Value<String?> channelName,
  Value<int> marketplaceFixedCents,
  Value<int> unitsPerPrint,
  Value<int> costCents,
  Value<int> priceCents,
  Value<int> profitCents,
  Value<String?> sourceFile,
  Value<bool> stockDeducted,
  Value<DateTime?> printedAt,
  Value<DateTime> createdAt,
});

final class $$JobsTableReferences
    extends BaseReferences<_$AppDatabase, $JobsTable, JobRow> {
  $$JobsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PrintersTable _printerIdTable(_$AppDatabase db) =>
      db.printers.createAlias('jobs__printer_id__printers__id');

  $$PrintersTableProcessedTableManager? get printerId {
    final $_column = $_itemColumn<int>('printer_id');
    if ($_column == null) return null;
    final manager = $$PrintersTableTableManager(
      $_db,
      $_db.printers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_printerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SalesChannelsTable _channelIdTable(_$AppDatabase db) =>
      db.salesChannels.createAlias('jobs__channel_id__sales_channels__id');

  $$SalesChannelsTableProcessedTableManager? get channelId {
    final $_column = $_itemColumn<int>('channel_id');
    if ($_column == null) return null;
    final manager = $$SalesChannelsTableTableManager(
      $_db,
      $_db.salesChannels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_channelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$JobFilamentsTable, List<JobFilamentRow>>
  _jobFilamentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.jobFilaments,
    aliasName: 'jobs__id__job_filaments__job_id',
  );

  $$JobFilamentsTableProcessedTableManager get jobFilamentsRefs {
    final manager = $$JobFilamentsTableTableManager(
      $_db,
      $_db.jobFilaments,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobFilamentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobsTableFilterComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customer => $composableBuilder(
    column: $table.customer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<JobStatus, JobStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get powerWatts => $composableBuilder(
    column: $table.powerWatts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get machineValueCents => $composableBuilder(
    column: $table.machineValueCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lifespanHours => $composableBuilder(
    column: $table.lifespanHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maintenancePerHourCents => $composableBuilder(
    column: $table.maintenancePerHourCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get printSeconds => $composableBuilder(
    column: $table.printSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get postProcessMinutes => $composableBuilder(
    column: $table.postProcessMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kwhPrice => $composableBuilder(
    column: $table.kwhPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get laborHourCents => $composableBuilder(
    column: $table.laborHourCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get packagingCents => $composableBuilder(
    column: $table.packagingCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wasteBp => $composableBuilder(
    column: $table.wasteBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failureBp => $composableBuilder(
    column: $table.failureBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get marginBp => $composableBuilder(
    column: $table.marginBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get marketplaceFeeBp => $composableBuilder(
    column: $table.marketplaceFeeBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxBp => $composableBuilder(
    column: $table.taxBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PriceRounding, PriceRounding, String>
  get priceRounding => $composableBuilder(
    column: $table.priceRounding,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get channelName => $composableBuilder(
    column: $table.channelName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get marketplaceFixedCents => $composableBuilder(
    column: $table.marketplaceFixedCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitsPerPrint => $composableBuilder(
    column: $table.unitsPerPrint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costCents => $composableBuilder(
    column: $table.costCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get profitCents => $composableBuilder(
    column: $table.profitCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceFile => $composableBuilder(
    column: $table.sourceFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get stockDeducted => $composableBuilder(
    column: $table.stockDeducted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get printedAt => $composableBuilder(
    column: $table.printedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PrintersTableFilterComposer get printerId {
    final $$PrintersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableFilterComposer(
            $db: $db,
            $table: $db.printers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SalesChannelsTableFilterComposer get channelId {
    final $$SalesChannelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.salesChannels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesChannelsTableFilterComposer(
            $db: $db,
            $table: $db.salesChannels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> jobFilamentsRefs(
    Expression<bool> Function($$JobFilamentsTableFilterComposer f) f,
  ) {
    final $$JobFilamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobFilaments,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobFilamentsTableFilterComposer(
            $db: $db,
            $table: $db.jobFilaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobsTableOrderingComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customer => $composableBuilder(
    column: $table.customer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get powerWatts => $composableBuilder(
    column: $table.powerWatts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get machineValueCents => $composableBuilder(
    column: $table.machineValueCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lifespanHours => $composableBuilder(
    column: $table.lifespanHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maintenancePerHourCents => $composableBuilder(
    column: $table.maintenancePerHourCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get printSeconds => $composableBuilder(
    column: $table.printSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get postProcessMinutes => $composableBuilder(
    column: $table.postProcessMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kwhPrice => $composableBuilder(
    column: $table.kwhPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get laborHourCents => $composableBuilder(
    column: $table.laborHourCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get packagingCents => $composableBuilder(
    column: $table.packagingCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wasteBp => $composableBuilder(
    column: $table.wasteBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failureBp => $composableBuilder(
    column: $table.failureBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get marginBp => $composableBuilder(
    column: $table.marginBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get marketplaceFeeBp => $composableBuilder(
    column: $table.marketplaceFeeBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxBp => $composableBuilder(
    column: $table.taxBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceRounding => $composableBuilder(
    column: $table.priceRounding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channelName => $composableBuilder(
    column: $table.channelName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get marketplaceFixedCents => $composableBuilder(
    column: $table.marketplaceFixedCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitsPerPrint => $composableBuilder(
    column: $table.unitsPerPrint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costCents => $composableBuilder(
    column: $table.costCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get profitCents => $composableBuilder(
    column: $table.profitCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceFile => $composableBuilder(
    column: $table.sourceFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get stockDeducted => $composableBuilder(
    column: $table.stockDeducted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get printedAt => $composableBuilder(
    column: $table.printedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PrintersTableOrderingComposer get printerId {
    final $$PrintersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableOrderingComposer(
            $db: $db,
            $table: $db.printers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SalesChannelsTableOrderingComposer get channelId {
    final $$SalesChannelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.salesChannels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesChannelsTableOrderingComposer(
            $db: $db,
            $table: $db.salesChannels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get customer =>
      $composableBuilder(column: $table.customer, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<JobStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get powerWatts => $composableBuilder(
    column: $table.powerWatts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get machineValueCents => $composableBuilder(
    column: $table.machineValueCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lifespanHours => $composableBuilder(
    column: $table.lifespanHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maintenancePerHourCents => $composableBuilder(
    column: $table.maintenancePerHourCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get printSeconds => $composableBuilder(
    column: $table.printSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get postProcessMinutes => $composableBuilder(
    column: $table.postProcessMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kwhPrice =>
      $composableBuilder(column: $table.kwhPrice, builder: (column) => column);

  GeneratedColumn<int> get laborHourCents => $composableBuilder(
    column: $table.laborHourCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get packagingCents => $composableBuilder(
    column: $table.packagingCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wasteBp =>
      $composableBuilder(column: $table.wasteBp, builder: (column) => column);

  GeneratedColumn<int> get failureBp =>
      $composableBuilder(column: $table.failureBp, builder: (column) => column);

  GeneratedColumn<int> get marginBp =>
      $composableBuilder(column: $table.marginBp, builder: (column) => column);

  GeneratedColumn<int> get marketplaceFeeBp => $composableBuilder(
    column: $table.marketplaceFeeBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxBp =>
      $composableBuilder(column: $table.taxBp, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PriceRounding, String> get priceRounding =>
      $composableBuilder(
        column: $table.priceRounding,
        builder: (column) => column,
      );

  GeneratedColumn<String> get channelName => $composableBuilder(
    column: $table.channelName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get marketplaceFixedCents => $composableBuilder(
    column: $table.marketplaceFixedCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitsPerPrint => $composableBuilder(
    column: $table.unitsPerPrint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costCents =>
      $composableBuilder(column: $table.costCents, builder: (column) => column);

  GeneratedColumn<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get profitCents => $composableBuilder(
    column: $table.profitCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceFile => $composableBuilder(
    column: $table.sourceFile,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get stockDeducted => $composableBuilder(
    column: $table.stockDeducted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get printedAt =>
      $composableBuilder(column: $table.printedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PrintersTableAnnotationComposer get printerId {
    final $$PrintersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableAnnotationComposer(
            $db: $db,
            $table: $db.printers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SalesChannelsTableAnnotationComposer get channelId {
    final $$SalesChannelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.channelId,
      referencedTable: $db.salesChannels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesChannelsTableAnnotationComposer(
            $db: $db,
            $table: $db.salesChannels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> jobFilamentsRefs<T extends Object>(
    Expression<T> Function($$JobFilamentsTableAnnotationComposer a) f,
  ) {
    final $$JobFilamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobFilaments,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobFilamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobFilaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobsTable,
          JobRow,
          $$JobsTableFilterComposer,
          $$JobsTableOrderingComposer,
          $$JobsTableAnnotationComposer,
          $$JobsTableCreateCompanionBuilder,
          $$JobsTableUpdateCompanionBuilder,
          (JobRow, $$JobsTableReferences),
          JobRow,
          PrefetchHooks Function({
            bool printerId,
            bool channelId,
            bool jobFilamentsRefs,
          })
        > {
  $$JobsTableTableManager(_$AppDatabase db, $JobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> customer = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<JobStatus> status = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int?> printerId = const Value.absent(),
                Value<String?> printerName = const Value.absent(),
                Value<int> powerWatts = const Value.absent(),
                Value<int> machineValueCents = const Value.absent(),
                Value<int> lifespanHours = const Value.absent(),
                Value<int> maintenancePerHourCents = const Value.absent(),
                Value<int> printSeconds = const Value.absent(),
                Value<int> postProcessMinutes = const Value.absent(),
                Value<int> kwhPrice = const Value.absent(),
                Value<int> laborHourCents = const Value.absent(),
                Value<int> packagingCents = const Value.absent(),
                Value<int> wasteBp = const Value.absent(),
                Value<int> failureBp = const Value.absent(),
                Value<int> marginBp = const Value.absent(),
                Value<int> marketplaceFeeBp = const Value.absent(),
                Value<int> taxBp = const Value.absent(),
                Value<PriceRounding> priceRounding = const Value.absent(),
                Value<int?> channelId = const Value.absent(),
                Value<String?> channelName = const Value.absent(),
                Value<int> marketplaceFixedCents = const Value.absent(),
                Value<int> unitsPerPrint = const Value.absent(),
                Value<int> costCents = const Value.absent(),
                Value<int> priceCents = const Value.absent(),
                Value<int> profitCents = const Value.absent(),
                Value<String?> sourceFile = const Value.absent(),
                Value<bool> stockDeducted = const Value.absent(),
                Value<DateTime?> printedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => JobsCompanion(
                id: id,
                name: name,
                customer: customer,
                photoPath: photoPath,
                notes: notes,
                status: status,
                quantity: quantity,
                printerId: printerId,
                printerName: printerName,
                powerWatts: powerWatts,
                machineValueCents: machineValueCents,
                lifespanHours: lifespanHours,
                maintenancePerHourCents: maintenancePerHourCents,
                printSeconds: printSeconds,
                postProcessMinutes: postProcessMinutes,
                kwhPrice: kwhPrice,
                laborHourCents: laborHourCents,
                packagingCents: packagingCents,
                wasteBp: wasteBp,
                failureBp: failureBp,
                marginBp: marginBp,
                marketplaceFeeBp: marketplaceFeeBp,
                taxBp: taxBp,
                priceRounding: priceRounding,
                channelId: channelId,
                channelName: channelName,
                marketplaceFixedCents: marketplaceFixedCents,
                unitsPerPrint: unitsPerPrint,
                costCents: costCents,
                priceCents: priceCents,
                profitCents: profitCents,
                sourceFile: sourceFile,
                stockDeducted: stockDeducted,
                printedAt: printedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> customer = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required JobStatus status,
                Value<int> quantity = const Value.absent(),
                Value<int?> printerId = const Value.absent(),
                Value<String?> printerName = const Value.absent(),
                Value<int> powerWatts = const Value.absent(),
                Value<int> machineValueCents = const Value.absent(),
                Value<int> lifespanHours = const Value.absent(),
                Value<int> maintenancePerHourCents = const Value.absent(),
                required int printSeconds,
                required int postProcessMinutes,
                required int kwhPrice,
                required int laborHourCents,
                required int packagingCents,
                required int wasteBp,
                required int failureBp,
                required int marginBp,
                required int marketplaceFeeBp,
                required int taxBp,
                required PriceRounding priceRounding,
                Value<int?> channelId = const Value.absent(),
                Value<String?> channelName = const Value.absent(),
                Value<int> marketplaceFixedCents = const Value.absent(),
                Value<int> unitsPerPrint = const Value.absent(),
                required int costCents,
                required int priceCents,
                required int profitCents,
                Value<String?> sourceFile = const Value.absent(),
                Value<bool> stockDeducted = const Value.absent(),
                Value<DateTime?> printedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => JobsCompanion.insert(
                id: id,
                name: name,
                customer: customer,
                photoPath: photoPath,
                notes: notes,
                status: status,
                quantity: quantity,
                printerId: printerId,
                printerName: printerName,
                powerWatts: powerWatts,
                machineValueCents: machineValueCents,
                lifespanHours: lifespanHours,
                maintenancePerHourCents: maintenancePerHourCents,
                printSeconds: printSeconds,
                postProcessMinutes: postProcessMinutes,
                kwhPrice: kwhPrice,
                laborHourCents: laborHourCents,
                packagingCents: packagingCents,
                wasteBp: wasteBp,
                failureBp: failureBp,
                marginBp: marginBp,
                marketplaceFeeBp: marketplaceFeeBp,
                taxBp: taxBp,
                priceRounding: priceRounding,
                channelId: channelId,
                channelName: channelName,
                marketplaceFixedCents: marketplaceFixedCents,
                unitsPerPrint: unitsPerPrint,
                costCents: costCents,
                priceCents: priceCents,
                profitCents: profitCents,
                sourceFile: sourceFile,
                stockDeducted: stockDeducted,
                printedAt: printedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JobsTable, JobRow>(table),
                  $$JobsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                printerId = false,
                channelId = false,
                jobFilamentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (jobFilamentsRefs) db.jobFilaments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (printerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.printerId,
                            referencedTable: $$JobsTableReferences
                                ._printerIdTable(db),
                            referencedColumn: $$JobsTableReferences
                                ._printerIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (channelId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.channelId,
                            referencedTable: $$JobsTableReferences
                                ._channelIdTable(db),
                            referencedColumn: $$JobsTableReferences
                                ._channelIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (jobFilamentsRefs)
                        await $_getPrefetchedDataByColumns<
                          JobRow,
                          $JobsTable,
                          JobFilamentRow,
                          $JobFilamentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._jobFilamentsRefsTable(db),
                          managerFromTypedResult: (p0) => $$JobsTableReferences(
                            db,
                            table,
                            p0,
                          ).jobFilamentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'job_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobsTable,
      JobRow,
      $$JobsTableFilterComposer,
      $$JobsTableOrderingComposer,
      $$JobsTableAnnotationComposer,
      $$JobsTableCreateCompanionBuilder,
      $$JobsTableUpdateCompanionBuilder,
      (JobRow, $$JobsTableReferences),
      JobRow,
      PrefetchHooks Function({
        bool printerId,
        bool channelId,
        bool jobFilamentsRefs,
      })
    >;
typedef $$JobFilamentsTableCreateCompanionBuilder =
    JobFilamentsCompanion Function({
      Value<int> id,
      required int jobId,
      Value<int?> filamentId,
      required String label,
      required int weightMg,
      required int rollPriceCents,
      required int rollWeightGrams,
    });
typedef $$JobFilamentsTableUpdateCompanionBuilder =
    JobFilamentsCompanion Function({
      Value<int> id,
      Value<int> jobId,
      Value<int?> filamentId,
      Value<String> label,
      Value<int> weightMg,
      Value<int> rollPriceCents,
      Value<int> rollWeightGrams,
    });

final class $$JobFilamentsTableReferences
    extends BaseReferences<_$AppDatabase, $JobFilamentsTable, JobFilamentRow> {
  $$JobFilamentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias('job_filaments__job_id__jobs__id');

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<int>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FilamentsTable _filamentIdTable(_$AppDatabase db) =>
      db.filaments.createAlias('job_filaments__filament_id__filaments__id');

  $$FilamentsTableProcessedTableManager? get filamentId {
    final $_column = $_itemColumn<int>('filament_id');
    if ($_column == null) return null;
    final manager = $$FilamentsTableTableManager(
      $_db,
      $_db.filaments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_filamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JobFilamentsTableFilterComposer
    extends Composer<_$AppDatabase, $JobFilamentsTable> {
  $$JobFilamentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weightMg => $composableBuilder(
    column: $table.weightMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollPriceCents => $composableBuilder(
    column: $table.rollPriceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollWeightGrams => $composableBuilder(
    column: $table.rollWeightGrams,
    builder: (column) => ColumnFilters(column),
  );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilamentsTableFilterComposer get filamentId {
    final $$FilamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.filamentId,
      referencedTable: $db.filaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilamentsTableFilterComposer(
            $db: $db,
            $table: $db.filaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobFilamentsTableOrderingComposer
    extends Composer<_$AppDatabase, $JobFilamentsTable> {
  $$JobFilamentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weightMg => $composableBuilder(
    column: $table.weightMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollPriceCents => $composableBuilder(
    column: $table.rollPriceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollWeightGrams => $composableBuilder(
    column: $table.rollWeightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilamentsTableOrderingComposer get filamentId {
    final $$FilamentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.filamentId,
      referencedTable: $db.filaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilamentsTableOrderingComposer(
            $db: $db,
            $table: $db.filaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobFilamentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobFilamentsTable> {
  $$JobFilamentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get weightMg =>
      $composableBuilder(column: $table.weightMg, builder: (column) => column);

  GeneratedColumn<int> get rollPriceCents => $composableBuilder(
    column: $table.rollPriceCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rollWeightGrams => $composableBuilder(
    column: $table.rollWeightGrams,
    builder: (column) => column,
  );

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilamentsTableAnnotationComposer get filamentId {
    final $$FilamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.filamentId,
      referencedTable: $db.filaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.filaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobFilamentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobFilamentsTable,
          JobFilamentRow,
          $$JobFilamentsTableFilterComposer,
          $$JobFilamentsTableOrderingComposer,
          $$JobFilamentsTableAnnotationComposer,
          $$JobFilamentsTableCreateCompanionBuilder,
          $$JobFilamentsTableUpdateCompanionBuilder,
          (JobFilamentRow, $$JobFilamentsTableReferences),
          JobFilamentRow,
          PrefetchHooks Function({bool jobId, bool filamentId})
        > {
  $$JobFilamentsTableTableManager(_$AppDatabase db, $JobFilamentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobFilamentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobFilamentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobFilamentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> jobId = const Value.absent(),
                Value<int?> filamentId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> weightMg = const Value.absent(),
                Value<int> rollPriceCents = const Value.absent(),
                Value<int> rollWeightGrams = const Value.absent(),
              }) => JobFilamentsCompanion(
                id: id,
                jobId: jobId,
                filamentId: filamentId,
                label: label,
                weightMg: weightMg,
                rollPriceCents: rollPriceCents,
                rollWeightGrams: rollWeightGrams,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int jobId,
                Value<int?> filamentId = const Value.absent(),
                required String label,
                required int weightMg,
                required int rollPriceCents,
                required int rollWeightGrams,
              }) => JobFilamentsCompanion.insert(
                id: id,
                jobId: jobId,
                filamentId: filamentId,
                label: label,
                weightMg: weightMg,
                rollPriceCents: rollPriceCents,
                rollWeightGrams: rollWeightGrams,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JobFilamentsTable, JobFilamentRow>(table),
                  $$JobFilamentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({jobId = false, filamentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (jobId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.jobId,
                        referencedTable: $$JobFilamentsTableReferences
                            ._jobIdTable(db),
                        referencedColumn: $$JobFilamentsTableReferences
                            ._jobIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (filamentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.filamentId,
                        referencedTable: $$JobFilamentsTableReferences
                            ._filamentIdTable(db),
                        referencedColumn: $$JobFilamentsTableReferences
                            ._filamentIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JobFilamentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobFilamentsTable,
      JobFilamentRow,
      $$JobFilamentsTableFilterComposer,
      $$JobFilamentsTableOrderingComposer,
      $$JobFilamentsTableAnnotationComposer,
      $$JobFilamentsTableCreateCompanionBuilder,
      $$JobFilamentsTableUpdateCompanionBuilder,
      (JobFilamentRow, $$JobFilamentsTableReferences),
      JobFilamentRow,
      PrefetchHooks Function({bool jobId, bool filamentId})
    >;
typedef $$PrinterConnectionsTableCreateCompanionBuilder =
    PrinterConnectionsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> kind,
      required String host,
      required String serial,
      Value<int?> printerId,
      Value<DateTime> createdAt,
    });
typedef $$PrinterConnectionsTableUpdateCompanionBuilder =
    PrinterConnectionsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> kind,
      Value<String> host,
      Value<String> serial,
      Value<int?> printerId,
      Value<DateTime> createdAt,
    });

final class $$PrinterConnectionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PrinterConnectionsTable,
          PrinterConnectionRow
        > {
  $$PrinterConnectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PrintersTable _printerIdTable(_$AppDatabase db) =>
      db.printers.createAlias('printer_connections__printer_id__printers__id');

  $$PrintersTableProcessedTableManager? get printerId {
    final $_column = $_itemColumn<int>('printer_id');
    if ($_column == null) return null;
    final manager = $$PrintersTableTableManager(
      $_db,
      $_db.printers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_printerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PrinterConnectionsTableFilterComposer
    extends Composer<_$AppDatabase, $PrinterConnectionsTable> {
  $$PrinterConnectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get host => $composableBuilder(
    column: $table.host,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serial => $composableBuilder(
    column: $table.serial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PrintersTableFilterComposer get printerId {
    final $$PrintersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableFilterComposer(
            $db: $db,
            $table: $db.printers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrinterConnectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrinterConnectionsTable> {
  $$PrinterConnectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get host => $composableBuilder(
    column: $table.host,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serial => $composableBuilder(
    column: $table.serial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PrintersTableOrderingComposer get printerId {
    final $$PrintersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableOrderingComposer(
            $db: $db,
            $table: $db.printers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrinterConnectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrinterConnectionsTable> {
  $$PrinterConnectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get host =>
      $composableBuilder(column: $table.host, builder: (column) => column);

  GeneratedColumn<String> get serial =>
      $composableBuilder(column: $table.serial, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PrintersTableAnnotationComposer get printerId {
    final $$PrintersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.printerId,
      referencedTable: $db.printers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintersTableAnnotationComposer(
            $db: $db,
            $table: $db.printers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrinterConnectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrinterConnectionsTable,
          PrinterConnectionRow,
          $$PrinterConnectionsTableFilterComposer,
          $$PrinterConnectionsTableOrderingComposer,
          $$PrinterConnectionsTableAnnotationComposer,
          $$PrinterConnectionsTableCreateCompanionBuilder,
          $$PrinterConnectionsTableUpdateCompanionBuilder,
          (PrinterConnectionRow, $$PrinterConnectionsTableReferences),
          PrinterConnectionRow,
          PrefetchHooks Function({bool printerId})
        > {
  $$PrinterConnectionsTableTableManager(
    _$AppDatabase db,
    $PrinterConnectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrinterConnectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrinterConnectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrinterConnectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> host = const Value.absent(),
                Value<String> serial = const Value.absent(),
                Value<int?> printerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PrinterConnectionsCompanion(
                id: id,
                name: name,
                kind: kind,
                host: host,
                serial: serial,
                printerId: printerId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> kind = const Value.absent(),
                required String host,
                required String serial,
                Value<int?> printerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PrinterConnectionsCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                host: host,
                serial: serial,
                printerId: printerId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrinterConnectionsTable, PrinterConnectionRow>(
                    table,
                  ),
                  $$PrinterConnectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({printerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (printerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.printerId,
                        referencedTable: $$PrinterConnectionsTableReferences
                            ._printerIdTable(db),
                        referencedColumn: $$PrinterConnectionsTableReferences
                            ._printerIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PrinterConnectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrinterConnectionsTable,
      PrinterConnectionRow,
      $$PrinterConnectionsTableFilterComposer,
      $$PrinterConnectionsTableOrderingComposer,
      $$PrinterConnectionsTableAnnotationComposer,
      $$PrinterConnectionsTableCreateCompanionBuilder,
      $$PrinterConnectionsTableUpdateCompanionBuilder,
      (PrinterConnectionRow, $$PrinterConnectionsTableReferences),
      PrinterConnectionRow,
      PrefetchHooks Function({bool printerId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FilamentsTableTableManager get filaments =>
      $$FilamentsTableTableManager(_db, _db.filaments);
  $$PrintersTableTableManager get printers =>
      $$PrintersTableTableManager(_db, _db.printers);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$SalesChannelsTableTableManager get salesChannels =>
      $$SalesChannelsTableTableManager(_db, _db.salesChannels);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
  $$JobFilamentsTableTableManager get jobFilaments =>
      $$JobFilamentsTableTableManager(_db, _db.jobFilaments);
  $$PrinterConnectionsTableTableManager get printerConnections =>
      $$PrinterConnectionsTableTableManager(_db, _db.printerConnections);
}

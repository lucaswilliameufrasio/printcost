import 'package:drift/drift.dart';

import '../../domain/models/job_status.dart';
import '../../domain/pricing/price_rounding.dart';

/// Units: money in cents, percent in basis points, weight in mg,
/// time in seconds, kWh price with 4 decimals.

@DataClassName('FilamentRow')
class Filaments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get brand => text().withLength(min: 1, max: 80)();
  TextColumn get material => text().withLength(min: 1, max: 30)();
  TextColumn get colorName => text().withDefault(const Constant(''))();

  /// ARGB color for the swatch, optional.
  IntColumn get colorArgb => integer().nullable()();
  IntColumn get rollPriceCents => integer()();
  IntColumn get rollWeightGrams =>
      integer().withDefault(const Constant(1000))();
  IntColumn get stockMg => integer()();
  IntColumn get lowStockAlertMg =>
      integer().withDefault(const Constant(100000))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('PrinterRow')
class Printers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  IntColumn get powerWatts => integer()();
  IntColumn get machineValueCents => integer()();
  IntColumn get lifespanHours => integer()();
  IntColumn get maintenancePerHourCents =>
      integer().withDefault(const Constant(0))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Single row (id = 1) with global settings.
@DataClassName('SettingsRow')
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get currencyCode => text().withDefault(const Constant('BRL'))();

  /// `null` follows the device language.
  TextColumn get localeCode => text().nullable()();

  /// system | light | dark
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  IntColumn get kwhPrice => integer().withDefault(const Constant(9000))();
  IntColumn get laborHourCents => integer().withDefault(const Constant(2500))();
  IntColumn get marketplaceFeeBp => integer().withDefault(const Constant(0))();
  IntColumn get taxBp => integer().withDefault(const Constant(0))();
  IntColumn get defaultMarginBp =>
      integer().withDefault(const Constant(3000))();
  IntColumn get packagingCents => integer().withDefault(const Constant(0))();
  IntColumn get defaultWasteBp => integer().withDefault(const Constant(500))();
  IntColumn get defaultFailureBp =>
      integer().withDefault(const Constant(500))();
  TextColumn get priceRounding => textEnum<PriceRounding>().withDefault(
    Constant(PriceRounding.none.name),
  )();
  TextColumn get shopName => text().withDefault(const Constant(''))();
  TextColumn get shopContact => text().withDefault(const Constant(''))();
  BlobColumn get shopLogo => blob().nullable()();
  BoolColumn get printerModuleEnabled =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// A priced part / quote, with a snapshot of every parameter used, so
/// editing a printer or the settings later does not change history.
@DataClassName('JobRow')
class Jobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get customer => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => textEnum<JobStatus>()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  IntColumn get printerId => integer().nullable().references(
    Printers,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get printerName => text().nullable()();
  IntColumn get powerWatts => integer().withDefault(const Constant(0))();
  IntColumn get machineValueCents => integer().withDefault(const Constant(0))();
  IntColumn get lifespanHours => integer().withDefault(const Constant(0))();
  IntColumn get maintenancePerHourCents =>
      integer().withDefault(const Constant(0))();

  IntColumn get printSeconds => integer()();
  IntColumn get postProcessMinutes => integer()();
  IntColumn get kwhPrice => integer()();
  IntColumn get laborHourCents => integer()();
  IntColumn get packagingCents => integer()();
  IntColumn get wasteBp => integer()();
  IntColumn get failureBp => integer()();
  IntColumn get marginBp => integer()();
  IntColumn get marketplaceFeeBp => integer()();
  IntColumn get taxBp => integer()();
  TextColumn get priceRounding => textEnum<PriceRounding>()();

  /// Results per unit.
  IntColumn get costCents => integer()();
  IntColumn get priceCents => integer()();
  IntColumn get profitCents => integer()();

  /// Name of the sliced file this came from (.3mf / printer job), if any.
  TextColumn get sourceFile => text().nullable()();

  BoolColumn get stockDeducted =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get printedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('JobFilamentRow')
class JobFilaments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jobId =>
      integer().references(Jobs, #id, onDelete: KeyAction.cascade)();
  IntColumn get filamentId => integer().nullable().references(
    Filaments,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Snapshot so history survives filament edits/deletion.
  TextColumn get label => text()();
  IntColumn get weightMg => integer()();
  IntColumn get rollPriceCents => integer()();
  IntColumn get rollWeightGrams => integer()();
}

/// Optional printer module: a printer reachable on the local network.
/// The access code is NOT stored here, only in secure storage.
@DataClassName('PrinterConnectionRow')
class PrinterConnections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();

  /// bambu_lan (future: moonraker, ...)
  TextColumn get kind => text().withDefault(const Constant('bambu_lan'))();
  TextColumn get host => text()();
  TextColumn get serial => text()();

  /// Registered printer used for cost (power, wear) when registering prints.
  IntColumn get printerId => integer().nullable().references(
    Printers,
    #id,
    onDelete: KeyAction.setNull,
  )();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

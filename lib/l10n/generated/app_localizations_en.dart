// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PrintCost';

  @override
  String get navCalculator => 'Calculator';

  @override
  String get navHistory => 'History';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navMore => 'More';

  @override
  String get filaments => 'Filaments';

  @override
  String get printers => 'Printers';

  @override
  String get settings => 'Settings';

  @override
  String get backup => 'Backup';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get close => 'Close';

  @override
  String get ok => 'OK';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get archive => 'Archive';

  @override
  String get help => 'Help';

  @override
  String get optional => 'optional';

  @override
  String get requiredField => 'This field is required';

  @override
  String get invalidNumber => 'Invalid number. E.g.: 12.50';

  @override
  String get mustBePositive => 'Must be greater than zero';

  @override
  String unexpectedError(String error) {
    return 'Something went wrong: $error';
  }

  @override
  String get newFilament => 'New filament';

  @override
  String get editFilament => 'Edit filament';

  @override
  String get noFilaments => 'No filaments yet. Tap + to add your first roll.';

  @override
  String get filamentBrand => 'Brand';

  @override
  String get filamentMaterial => 'Type';

  @override
  String get filamentColor => 'Color';

  @override
  String get filamentRollPrice => 'Roll price';

  @override
  String get filamentRollWeight => 'Roll weight (g)';

  @override
  String get filamentStock => 'Remaining stock (g)';

  @override
  String get filamentLowStock => 'Warn when below (g)';

  @override
  String get helpBrand =>
      'Filament manufacturer. E.g.: Bambu, Polymaker, eSun.';

  @override
  String get helpMaterial =>
      'Plastic type: PLA, PETG, ABS, TPU... Just to keep things organized.';

  @override
  String get helpColor =>
      'Color name and, optionally, a swatch to find it quickly.';

  @override
  String get helpRollPrice =>
      'What you paid for the roll. You can include shipping.';

  @override
  String get helpRollWeight =>
      'Filament weight on the roll, without the spool. Usually 1000 g.';

  @override
  String get helpStock =>
      'How much is left. New roll: same as the roll weight. The app deducts automatically when you mark a part as printed.';

  @override
  String get helpLowStock =>
      'You get a warning when stock reaches this amount.';

  @override
  String get lowStockBadge => 'Running low';

  @override
  String stockLeft(String grams) {
    return '$grams left';
  }

  @override
  String pricePerKg(String price) {
    return '$price/kg';
  }

  @override
  String get archiveFilamentConfirm =>
      'Archive this filament? It leaves the list, but history stays the same.';

  @override
  String get pickColor => 'Pick color';

  @override
  String get noColor => 'No color';

  @override
  String get newPrinter => 'New printer';

  @override
  String get editPrinter => 'Edit printer';

  @override
  String get noPrinters => 'No printers yet. Tap + to add one.';

  @override
  String get printerName => 'Name';

  @override
  String get printerPower => 'Average power (W)';

  @override
  String get printerValue => 'Machine price';

  @override
  String get printerLifespan => 'Expected lifespan (hours)';

  @override
  String get printerMaintenance => 'Maintenance per hour (optional)';

  @override
  String get helpPrinterName => 'A name to recognize it. E.g.: Office A1.';

  @override
  String get helpPower =>
      'Average power while printing. Rough PLA values: A1 mini ~ 80 W, A1 ~ 95 W, P1S ~ 110 W, X1C ~ 140 W. Use a plug meter if you have one.';

  @override
  String get helpMachineValue =>
      'What you paid for the printer. Used to compute wear.';

  @override
  String get helpLifespan =>
      'How many printing hours you expect it to last. 5000 h is a fair guess.';

  @override
  String get helpMaintenance =>
      'Average spend on nozzles, belts, grease... per printing hour. Can be 0.';

  @override
  String wearPerHour(String value) {
    return '$value/h wear';
  }

  @override
  String get archivePrinterConfirm =>
      'Archive this printer? History stays the same.';

  @override
  String get sectionCosts => 'Costs';

  @override
  String get sectionPricing => 'Pricing';

  @override
  String get sectionAppearance => 'Appearance and language';

  @override
  String get sectionShop => 'Your shop (shown on the PDF)';

  @override
  String get sectionModules => 'Extra features';

  @override
  String get settingsKwh => 'Price per kWh';

  @override
  String get settingsLaborHour => 'Your hourly rate';

  @override
  String get settingsMarketplace => 'Marketplace fee (%)';

  @override
  String get settingsTax => 'Taxes (%)';

  @override
  String get settingsMargin => 'Default profit margin (%)';

  @override
  String get settingsPackaging => 'Packaging per part';

  @override
  String get settingsWaste => 'Default waste/purge (%)';

  @override
  String get settingsFailure => 'Default failure rate (%)';

  @override
  String get settingsRounding => 'Price rounding';

  @override
  String get settingsCurrency => 'Currency';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'Device language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'Automatic';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get shopName => 'Shop name';

  @override
  String get shopContact => 'Contact (phone, Instagram...)';

  @override
  String get shopLogo => 'Logo';

  @override
  String get chooseLogo => 'Choose logo';

  @override
  String get removeLogo => 'Remove logo';

  @override
  String get printerModuleTitle => 'Monitor printer on the network (beta)';

  @override
  String get printerModuleSubtitle =>
      'Shows print progress of a printer on the same Wi-Fi. Off by default.';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get helpKwh =>
      'Your power bill divided by kWh used (it\'s on the bill). E.g.: 0.1650.';

  @override
  String get helpLabor =>
      'What one hour of your manual work is worth (supports, sanding, painting, packing).';

  @override
  String get helpPackaging => 'Box, bag, label, freebie... per part sold.';

  @override
  String get helpMarketplace =>
      'Sales platform commission (Etsy, eBay...). Use 0 if you sell directly.';

  @override
  String get helpTax => 'Sales taxes. Use 0 if not applicable.';

  @override
  String get helpMargin =>
      'How much of the final price you keep as profit after costs, fees and taxes. 30% is a good start.';

  @override
  String get helpWaste =>
      'Filament lost to purge (AMS color changes), tests and leftovers. 5% for one color; more for multicolor.';

  @override
  String get helpFailure =>
      'Reserve for failed prints. If 1 in 20 fails, use 5%.';

  @override
  String get helpRounding =>
      'Always rounds the price up so it looks like a shop price.';

  @override
  String get helpCurrency =>
      'Currency used to display values. Does not convert existing values.';

  @override
  String get roundingNone => 'No rounding';

  @override
  String get rounding90 => 'End in .90';

  @override
  String get rounding99 => 'End in .99';

  @override
  String get roundingHalf => 'Multiple of 0.50';

  @override
  String get roundingWhole => 'Whole number';

  @override
  String get calcFilamentsSection => 'Filament used';

  @override
  String get calcAddFilament => 'Add another filament';

  @override
  String get calcSelectFilament => 'Filament';

  @override
  String get calcGrams => 'Grams';

  @override
  String get calcPrinterSection => 'Printing';

  @override
  String get calcPrinter => 'Printer';

  @override
  String get calcNoPrinter => 'No printer (ignores power and wear)';

  @override
  String get calcHours => 'Hours';

  @override
  String get calcMinutes => 'Minutes';

  @override
  String get calcPostProcess => 'Post-processing (min)';

  @override
  String get calcPercentsSection => 'Margin and reserves';

  @override
  String get calcWaste => 'Waste/purge (%)';

  @override
  String get calcFailure => 'Failure rate (%)';

  @override
  String get calcMargin => 'Profit margin (%)';

  @override
  String get calcAdvanced => 'Costs and fees for this part';

  @override
  String get calcAdvancedSubtitle =>
      'Taken from Settings. Change here for this part only.';

  @override
  String get calcResultPrice => 'Suggested price';

  @override
  String get calcResultCost => 'Total cost';

  @override
  String get calcResultProfit => 'Net profit';

  @override
  String calcPriceBeforeRounding(String price) {
    return 'Before rounding: $price';
  }

  @override
  String profitPercentOfPrice(String percent) {
    return '$percent of price';
  }

  @override
  String get calcBreakdown => 'Where the money goes';

  @override
  String get breakdownMaterial => 'Material';

  @override
  String get breakdownEnergy => 'Power';

  @override
  String get breakdownWear => 'Machine wear';

  @override
  String get breakdownLabor => 'Labor';

  @override
  String get breakdownPackaging => 'Packaging';

  @override
  String get breakdownFailure => 'Failure reserve';

  @override
  String get breakdownFees => 'Marketplace fee';

  @override
  String get breakdownTaxes => 'Taxes';

  @override
  String get breakdownProfit => 'Your profit';

  @override
  String get calcSave => 'Save part';

  @override
  String get calcUpdate => 'Update part';

  @override
  String get calcClear => 'Clear';

  @override
  String calcEditing(String name) {
    return 'Editing: $name';
  }

  @override
  String get calcImport3mf => 'Import from file (.3mf)';

  @override
  String get calcNeedFilament => 'Add at least one filament to calculate.';

  @override
  String get calcGoToFilaments => 'Add filament';

  @override
  String get calcFillToSee => 'Fill in filament and time to see the price.';

  @override
  String get helpGrams =>
      'Grams of this filament the part uses. Your slicer shows it after slicing. Or use \"Import from file\".';

  @override
  String get helpPrinterField =>
      'Printer used. Defines power cost and wear per hour.';

  @override
  String get helpPrintTime => 'Estimated print time shown by your slicer.';

  @override
  String get helpPostProcess =>
      'Your time removing supports, sanding, painting, assembling and packing.';

  @override
  String errDeductionsTooHigh(String total) {
    return 'Margin + fees + taxes add up to $total. It must stay below 100%, otherwise no price can cover them. Lower the margin or the fees.';
  }

  @override
  String get errNegative => 'Some value is negative. Check the fields.';

  @override
  String get errRollWeight =>
      'A filament has roll weight 0. Fix it in the filament settings.';

  @override
  String get saveJobTitle => 'Save part';

  @override
  String get jobName => 'Part name';

  @override
  String get jobCustomer => 'Customer (optional)';

  @override
  String get jobQuantity => 'Quantity';

  @override
  String get jobStatus => 'Status';

  @override
  String get jobNotes => 'Notes (optional)';

  @override
  String get jobPhoto => 'Photo (optional)';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get pickPhoto => 'Gallery';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get jobSaved => 'Part saved to history';

  @override
  String get statusQuote => 'Quote';

  @override
  String get statusInProduction => 'In production';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get historyEmpty =>
      'No saved parts yet. Price something and tap \"Save part\".';

  @override
  String get historySearch => 'Search by name or customer';

  @override
  String get filterAll => 'All';

  @override
  String get markPrinted => 'Mark as printed';

  @override
  String get printedBadge => 'Printed';

  @override
  String get stockUpdated => 'Filament stock updated';

  @override
  String get stockAlreadyDeducted =>
      'Stock for this part was already deducted.';

  @override
  String lowStockWarning(String name, String grams) {
    return '$name is running low: $grams left.';
  }

  @override
  String insufficientStockWarning(String name) {
    return '$name: registered stock was not enough and is now zero. Check the roll.';
  }

  @override
  String get jobDetails => 'Part details';

  @override
  String get openInCalculator => 'Open in calculator';

  @override
  String get deleteJobConfirm =>
      'Delete this part from history? Stock is not restored.';

  @override
  String get unitPrice => 'Unit price';

  @override
  String get unitCost => 'Unit cost';

  @override
  String get unitProfit => 'Unit profit';

  @override
  String get totalLabel => 'Total';

  @override
  String quantityUnits(int count) {
    return '$count pcs';
  }

  @override
  String printedOn(String date) {
    return 'Printed on $date';
  }

  @override
  String createdOn(String date) {
    return 'Created on $date';
  }

  @override
  String get printTimeLabel => 'Print time';

  @override
  String get sourceFileLabel => 'File';

  @override
  String get generatePdf => 'PDF quote';

  @override
  String get selectForQuote => 'Select parts for the quote';

  @override
  String quoteSelectedCount(int count) {
    return '$count selected';
  }

  @override
  String get createQuote => 'Create PDF';

  @override
  String get pdfCustomerPrompt => 'Customer name on the quote';

  @override
  String get pdfQuoteTitle => 'Quote';

  @override
  String get pdfItem => 'Item';

  @override
  String get pdfQty => 'Qty';

  @override
  String get pdfUnit => 'Unit';

  @override
  String get pdfSubtotal => 'Subtotal';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfCustomer => 'Customer';

  @override
  String get pdfDate => 'Date';

  @override
  String get pdfValidity => 'Quote valid for 7 days.';

  @override
  String get dashboardEmpty =>
      'Numbers show up here once you have parts in production or delivered.';

  @override
  String get dashProfitByMonth => 'Profit per month';

  @override
  String get dashRevenue => 'Revenue';

  @override
  String get dashProfit => 'Profit';

  @override
  String get dashAvgMargin => 'Average margin';

  @override
  String get dashJobsSold => 'Parts sold';

  @override
  String get dashTopJobs => 'Most profitable parts';

  @override
  String get dashFilamentUsage => 'Most used filament';

  @override
  String get dashNote =>
      'Counts parts in production and delivered. Quotes are excluded.';

  @override
  String get backupExport => 'Export backup';

  @override
  String get backupExportHelp =>
      'Creates a file with all your data. Keep it in the cloud, email or a computer.';

  @override
  String get backupImport => 'Restore backup';

  @override
  String get backupImportHelp => 'Replaces current data with a backup file.';

  @override
  String get backupImportWarning =>
      'This replaces ALL current data with the file\'s. Export a backup first if needed. Continue?';

  @override
  String get backupSaved => 'Backup saved';

  @override
  String get backupRestored => 'Backup restored';

  @override
  String get backupInvalidFile =>
      'This file doesn\'t look like a PrintCost backup.';

  @override
  String get backupNewerVersion =>
      'This backup is from a newer app version. Update the app first.';

  @override
  String get backupPhotosNote => 'Part photos are not included, only data.';

  @override
  String get backupShare => 'Share';

  @override
  String get backupSaveToFile => 'Save to file';

  @override
  String get restore => 'Restore';

  @override
  String get about => 'About';

  @override
  String get aboutText =>
      'PrintCost is an offline calculator: your data stays on your device. Works with Bambu Studio files and Bambu Lab printers in LAN mode. This app is not affiliated with, sponsored or endorsed by Bambu Lab.';

  @override
  String get importPickPlate => 'Which plate do you want to import?';

  @override
  String plateLabel(int index) {
    return 'Plate $index';
  }

  @override
  String get importSummaryTitle => 'Data found in the file';

  @override
  String importTime(String time) {
    return 'Print time: $time';
  }

  @override
  String importFilamentLine(String name, String weight) {
    return '$name: $weight';
  }

  @override
  String get importMissingTime =>
      'The file has no print time. Fill it in manually.';

  @override
  String importOnlyTotalWeight(String weight) {
    return 'The file only has the total weight ($weight), not per filament. It was added as one filament; adjust if needed.';
  }

  @override
  String get importMissingWeight =>
      'The file has no filament weight. Fill it in manually.';

  @override
  String get importUnmatched =>
      'Some filaments in the file have no registered match of the same type. Pick them in the calculator.';

  @override
  String get importErrNotA3mf => 'This is not a valid .3mf file.';

  @override
  String get importErrNoSliceInfo =>
      'This .3mf has no slicing data (weight and time). In Bambu Studio, slice the plate and save the project, or use \"Export plate sliced file\". You can also fill the fields by hand.';

  @override
  String get importErrNoPlates =>
      'The file opened, but no plate has weight or time. Slice again and save, or fill in by hand.';

  @override
  String get importErrWrongExtension =>
      'Pick a .3mf file (Bambu Studio project or .gcode.3mf).';

  @override
  String get importApply => 'Use this data';

  @override
  String get pmTitle => 'Network printer';

  @override
  String get pmSubtitle => 'Follow your print live';

  @override
  String get pmEmpty =>
      'No connected printer yet. Tap + to set one up (takes about 3 minutes).';

  @override
  String get pmAdd => 'Connect printer';

  @override
  String get pmDeleteConfirm =>
      'Remove this connection? The access code saved on this device is deleted too.';

  @override
  String get pmRemoteTitle => 'Following from outside home';

  @override
  String get pmRemoteText =>
      'Use a VPN such as Tailscale or NetBird on your phone and on a computer or router at home: free for personal use, and your phone \"sees\" the printer as if it were on your Wi-Fi. Never open the printer port (8883) to the internet with router port forwarding: anyone could try to access it.';

  @override
  String get pmState_idle => 'Idle';

  @override
  String get pmState_preparing => 'Preparing';

  @override
  String get pmState_printing => 'Printing';

  @override
  String get pmState_paused => 'Paused';

  @override
  String get pmState_finished => 'Finished';

  @override
  String get pmState_failed => 'Failed';

  @override
  String get pmState_unknown => 'Waiting for status…';

  @override
  String get pmConnecting => 'Connecting…';

  @override
  String get pmConnected => 'Connected';

  @override
  String get pmDisconnected => 'Disconnected';

  @override
  String get pmReconnect => 'Try again';

  @override
  String pmRemaining(String time) {
    return '$time left';
  }

  @override
  String pmFile(String name) {
    return 'File: $name';
  }

  @override
  String pmErrorCode(String code) {
    return 'Printer error code: $code';
  }

  @override
  String get pmRegisterPrint => 'Register this print';

  @override
  String get pmRegisterText =>
      'To get the weight of each filament, pick this print\'s .3mf file (the one you sent to print). Or continue with just the time and fill in the weight in the calculator.';

  @override
  String get pmRegisterNoFetch =>
      'Downloading the file straight from the printer is not supported yet.';

  @override
  String get pmChoose3mf => 'Pick .3mf';

  @override
  String get pmOnlyTime => 'Time only';

  @override
  String get pmDebugTitle => 'Received messages (debug)';

  @override
  String get pmDebugHelp =>
      'Last raw messages sent by the printer. Use them to check field names if something looks wrong. The access code never appears here.';

  @override
  String get pmDebugEmpty => 'No messages yet.';

  @override
  String get pmCopy => 'Copy';

  @override
  String get pmCopied => 'Copied';

  @override
  String get pmMergedState => 'Current merged state';

  @override
  String get pmNotifyFinished => 'Print finished';

  @override
  String get pmNotifyFailed => 'Print failed';

  @override
  String get pmNotifyChannel => 'Printer status';

  @override
  String get pmForegroundNote =>
      'Finish alerts work while the app is open or recently in the background. If the system closes the app, open it again to reconnect.';

  @override
  String get wzTitle => 'Connect printer';

  @override
  String wzStep(int step) {
    return 'Step $step of 4';
  }

  @override
  String get wz1Title => 'Turn on LAN mode';

  @override
  String get wz1Text =>
      'On the printer screen, open Settings (gear) → WLAN/Network and turn on \"LAN Only Mode\". The printer then talks to your phone over your Wi-Fi, without the cloud.\n\nWhile LAN mode is on, the official app and cloud printing do not work.';

  @override
  String get wz2Title => 'Turn on Developer Mode';

  @override
  String get wz2Text =>
      'On recent firmware (and on H2 models) you also need \"Developer Mode\", on the same screen as LAN mode.\n\nNote: this mode is not officially supported by the manufacturer. It allows local access for third-party programs like this one. PrintCost only reads the status: it never sends commands to the printer.';

  @override
  String get wz3Title => 'Printer details';

  @override
  String get wz3Text =>
      'The printer\'s network screen shows the IP and the access code (8 characters). The serial number is under Settings → Device (or on the label on the back).';

  @override
  String get wz4Title => 'Test connection';

  @override
  String get wz4Text => 'Your phone must be on the same Wi-Fi as the printer.';

  @override
  String get wzName => 'Name';

  @override
  String get wzIp => 'IP address';

  @override
  String get wzSerial => 'Serial number';

  @override
  String get wzCode => 'Access code';

  @override
  String get wzLinkedPrinter => 'Registered printer (for costs)';

  @override
  String get wzLinkedNone => 'None';

  @override
  String get wzHelpIp =>
      'Shown on the printer\'s network screen. E.g.: 192.168.0.50. Tip: reserve this IP in your router so it doesn\'t change.';

  @override
  String get wzHelpCode =>
      '8 characters, on the LAN mode screen. It changes every time you turn LAN mode off and on. It is stored only on this device, protected, and is not included in backups.';

  @override
  String get wzHelpSerial =>
      'Under Settings → Device, or on the label. Dashes are optional.';

  @override
  String get wzInvalidIp => 'Use the format 192.168.0.50';

  @override
  String get wzInvalidCode => 'The code has 8 characters';

  @override
  String get wzTest => 'Test connection';

  @override
  String get wzTesting => 'Testing…';

  @override
  String wzSuccess(String state) {
    return 'Connected! The printer is: $state';
  }

  @override
  String get wzSave => 'Save and follow';

  @override
  String get wzShowCode => 'Show code';

  @override
  String errUnreachable(String ip) {
    return 'Could not find the printer at $ip. Check: is the IP right? Is your phone on the same Wi-Fi (not mobile data or a guest network)? Is the printer on with LAN mode enabled?';
  }

  @override
  String get errRejected =>
      'The printer refused the connection. Check the access code: it changes whenever LAN mode is turned off and on. On recent firmware, also check that Developer Mode is on.';

  @override
  String get errNoReports =>
      'Connected, but the printer sent no status. This usually means Developer Mode is off or the serial number is wrong.';

  @override
  String get errCertChanged =>
      'The printer\'s security certificate changed since the last connection. If you replaced or reset the printer, remove this connection and add it again. Otherwise another device may be impersonating the printer on your network.';

  @override
  String get errInvalidConfig =>
      'Check the fields: the IP must look like 192.168.0.50 and the code has 8 characters.';

  @override
  String errUnknownPrinter(String detail) {
    return 'Could not connect. $detail';
  }
}

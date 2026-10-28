import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'PrintCost'**
  String get appTitle;

  /// No description provided for @navCalculator.
  ///
  /// In pt, this message translates to:
  /// **'Calculadora'**
  String get navCalculator;

  /// No description provided for @navHistory.
  ///
  /// In pt, this message translates to:
  /// **'Histórico'**
  String get navHistory;

  /// No description provided for @navDashboard.
  ///
  /// In pt, this message translates to:
  /// **'Painel'**
  String get navDashboard;

  /// No description provided for @navMore.
  ///
  /// In pt, this message translates to:
  /// **'Mais'**
  String get navMore;

  /// No description provided for @filaments.
  ///
  /// In pt, this message translates to:
  /// **'Filamentos'**
  String get filaments;

  /// No description provided for @printers.
  ///
  /// In pt, this message translates to:
  /// **'Impressoras'**
  String get printers;

  /// No description provided for @settings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settings;

  /// No description provided for @backup.
  ///
  /// In pt, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @save.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get add;

  /// No description provided for @close.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get close;

  /// No description provided for @ok.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @back.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get back;

  /// No description provided for @next.
  ///
  /// In pt, this message translates to:
  /// **'Próximo'**
  String get next;

  /// No description provided for @archive.
  ///
  /// In pt, this message translates to:
  /// **'Arquivar'**
  String get archive;

  /// No description provided for @help.
  ///
  /// In pt, this message translates to:
  /// **'Ajuda'**
  String get help;

  /// No description provided for @optional.
  ///
  /// In pt, this message translates to:
  /// **'opcional'**
  String get optional;

  /// No description provided for @requiredField.
  ///
  /// In pt, this message translates to:
  /// **'Preencha este campo'**
  String get requiredField;

  /// No description provided for @invalidNumber.
  ///
  /// In pt, this message translates to:
  /// **'Número inválido. Ex.: 12,50'**
  String get invalidNumber;

  /// No description provided for @mustBePositive.
  ///
  /// In pt, this message translates to:
  /// **'Precisa ser maior que zero'**
  String get mustBePositive;

  /// No description provided for @unexpectedError.
  ///
  /// In pt, this message translates to:
  /// **'Algo deu errado: {error}'**
  String unexpectedError(String error);

  /// No description provided for @newFilament.
  ///
  /// In pt, this message translates to:
  /// **'Novo filamento'**
  String get newFilament;

  /// No description provided for @editFilament.
  ///
  /// In pt, this message translates to:
  /// **'Editar filamento'**
  String get editFilament;

  /// No description provided for @noFilaments.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum filamento cadastrado. Toque em + para cadastrar o primeiro rolo.'**
  String get noFilaments;

  /// No description provided for @filamentBrand.
  ///
  /// In pt, this message translates to:
  /// **'Marca'**
  String get filamentBrand;

  /// No description provided for @filamentMaterial.
  ///
  /// In pt, this message translates to:
  /// **'Tipo'**
  String get filamentMaterial;

  /// No description provided for @filamentColor.
  ///
  /// In pt, this message translates to:
  /// **'Cor'**
  String get filamentColor;

  /// No description provided for @filamentRollPrice.
  ///
  /// In pt, this message translates to:
  /// **'Preço do rolo'**
  String get filamentRollPrice;

  /// No description provided for @filamentRollWeight.
  ///
  /// In pt, this message translates to:
  /// **'Peso do rolo (g)'**
  String get filamentRollWeight;

  /// No description provided for @filamentStock.
  ///
  /// In pt, this message translates to:
  /// **'Estoque restante (g)'**
  String get filamentStock;

  /// No description provided for @filamentLowStock.
  ///
  /// In pt, this message translates to:
  /// **'Avisar quando restar (g)'**
  String get filamentLowStock;

  /// No description provided for @helpBrand.
  ///
  /// In pt, this message translates to:
  /// **'Fabricante do filamento. Ex.: Bambu, Voolt, 3D Fila, eSun.'**
  String get helpBrand;

  /// No description provided for @helpMaterial.
  ///
  /// In pt, this message translates to:
  /// **'Tipo do plástico: PLA, PETG, ABS, TPU... Só para você se organizar.'**
  String get helpMaterial;

  /// No description provided for @helpColor.
  ///
  /// In pt, this message translates to:
  /// **'Nome da cor e, se quiser, a cor da bolinha para achar rápido na lista.'**
  String get helpColor;

  /// No description provided for @helpRollPrice.
  ///
  /// In pt, this message translates to:
  /// **'Quanto você pagou no rolo. Pode incluir o frete dividido.'**
  String get helpRollPrice;

  /// No description provided for @helpRollWeight.
  ///
  /// In pt, this message translates to:
  /// **'Peso do filamento no rolo, sem o carretel. Quase sempre 1000 g.'**
  String get helpRollWeight;

  /// No description provided for @helpStock.
  ///
  /// In pt, this message translates to:
  /// **'Quanto ainda tem no rolo. Rolo novo: igual ao peso do rolo. O app desconta sozinho quando você marca uma peça como impressa.'**
  String get helpStock;

  /// No description provided for @helpLowStock.
  ///
  /// In pt, this message translates to:
  /// **'Você recebe um aviso quando o estoque chegar nesse valor.'**
  String get helpLowStock;

  /// No description provided for @lowStockBadge.
  ///
  /// In pt, this message translates to:
  /// **'Acabando'**
  String get lowStockBadge;

  /// No description provided for @stockLeft.
  ///
  /// In pt, this message translates to:
  /// **'{grams} restantes'**
  String stockLeft(String grams);

  /// No description provided for @pricePerKg.
  ///
  /// In pt, this message translates to:
  /// **'{price}/kg'**
  String pricePerKg(String price);

  /// No description provided for @archiveFilamentConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Arquivar este filamento? Ele some da lista, mas o histórico continua igual.'**
  String get archiveFilamentConfirm;

  /// No description provided for @pickColor.
  ///
  /// In pt, this message translates to:
  /// **'Escolher cor'**
  String get pickColor;

  /// No description provided for @noColor.
  ///
  /// In pt, this message translates to:
  /// **'Sem cor'**
  String get noColor;

  /// No description provided for @newPrinter.
  ///
  /// In pt, this message translates to:
  /// **'Nova impressora'**
  String get newPrinter;

  /// No description provided for @editPrinter.
  ///
  /// In pt, this message translates to:
  /// **'Editar impressora'**
  String get editPrinter;

  /// No description provided for @noPrinters.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma impressora cadastrada. Toque em + para cadastrar.'**
  String get noPrinters;

  /// No description provided for @printerName.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get printerName;

  /// No description provided for @printerPower.
  ///
  /// In pt, this message translates to:
  /// **'Consumo médio (W)'**
  String get printerPower;

  /// No description provided for @printerValue.
  ///
  /// In pt, this message translates to:
  /// **'Valor da máquina'**
  String get printerValue;

  /// No description provided for @printerLifespan.
  ///
  /// In pt, this message translates to:
  /// **'Vida útil estimada (horas)'**
  String get printerLifespan;

  /// No description provided for @printerMaintenance.
  ///
  /// In pt, this message translates to:
  /// **'Manutenção por hora (opcional)'**
  String get printerMaintenance;

  /// No description provided for @helpPrinterName.
  ///
  /// In pt, this message translates to:
  /// **'Um nome para reconhecer a impressora. Ex.: A1 da sala.'**
  String get helpPrinterName;

  /// No description provided for @helpPower.
  ///
  /// In pt, this message translates to:
  /// **'Consumo médio enquanto imprime. Valores aproximados em PLA: A1 mini ~ 80 W, A1 ~ 95 W, P1S ~ 110 W, X1C ~ 140 W. Se tiver uma tomada medidora, use o valor medido.'**
  String get helpPower;

  /// No description provided for @helpMachineValue.
  ///
  /// In pt, this message translates to:
  /// **'Quanto você pagou na impressora. Serve para calcular o desgaste.'**
  String get helpMachineValue;

  /// No description provided for @helpLifespan.
  ///
  /// In pt, this message translates to:
  /// **'Quantas horas de impressão você espera que ela dure. 5000 h é um chute razoável.'**
  String get helpLifespan;

  /// No description provided for @helpMaintenance.
  ///
  /// In pt, this message translates to:
  /// **'Gasto médio com bicos, correias, graxa... por hora de impressão. Pode deixar 0.'**
  String get helpMaintenance;

  /// No description provided for @wearPerHour.
  ///
  /// In pt, this message translates to:
  /// **'{value}/h de desgaste'**
  String wearPerHour(String value);

  /// No description provided for @archivePrinterConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Arquivar esta impressora? O histórico continua igual.'**
  String get archivePrinterConfirm;

  /// No description provided for @sectionCosts.
  ///
  /// In pt, this message translates to:
  /// **'Custos'**
  String get sectionCosts;

  /// No description provided for @sectionPricing.
  ///
  /// In pt, this message translates to:
  /// **'Preço'**
  String get sectionPricing;

  /// No description provided for @sectionAppearance.
  ///
  /// In pt, this message translates to:
  /// **'Aparência e idioma'**
  String get sectionAppearance;

  /// No description provided for @sectionShop.
  ///
  /// In pt, this message translates to:
  /// **'Sua loja (aparece no PDF)'**
  String get sectionShop;

  /// No description provided for @sectionModules.
  ///
  /// In pt, this message translates to:
  /// **'Recursos extras'**
  String get sectionModules;

  /// No description provided for @settingsKwh.
  ///
  /// In pt, this message translates to:
  /// **'Preço do kWh'**
  String get settingsKwh;

  /// No description provided for @settingsLaborHour.
  ///
  /// In pt, this message translates to:
  /// **'Valor da sua hora de trabalho'**
  String get settingsLaborHour;

  /// No description provided for @settingsMarketplace.
  ///
  /// In pt, this message translates to:
  /// **'Taxa do marketplace (%)'**
  String get settingsMarketplace;

  /// No description provided for @settingsTax.
  ///
  /// In pt, this message translates to:
  /// **'Impostos (%)'**
  String get settingsTax;

  /// No description provided for @settingsMargin.
  ///
  /// In pt, this message translates to:
  /// **'Margem de lucro padrão (%)'**
  String get settingsMargin;

  /// No description provided for @settingsPackaging.
  ///
  /// In pt, this message translates to:
  /// **'Embalagem por peça'**
  String get settingsPackaging;

  /// No description provided for @settingsWaste.
  ///
  /// In pt, this message translates to:
  /// **'Desperdício/purga padrão (%)'**
  String get settingsWaste;

  /// No description provided for @settingsFailure.
  ///
  /// In pt, this message translates to:
  /// **'Taxa de falha padrão (%)'**
  String get settingsFailure;

  /// No description provided for @settingsRounding.
  ///
  /// In pt, this message translates to:
  /// **'Arredondamento do preço'**
  String get settingsRounding;

  /// No description provided for @settingsCurrency.
  ///
  /// In pt, this message translates to:
  /// **'Moeda'**
  String get settingsCurrency;

  /// No description provided for @settingsLanguage.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In pt, this message translates to:
  /// **'Do aparelho'**
  String get languageSystem;

  /// No description provided for @settingsTheme.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In pt, this message translates to:
  /// **'Automático'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In pt, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In pt, this message translates to:
  /// **'Escuro'**
  String get themeDark;

  /// No description provided for @shopName.
  ///
  /// In pt, this message translates to:
  /// **'Nome da loja'**
  String get shopName;

  /// No description provided for @shopContact.
  ///
  /// In pt, this message translates to:
  /// **'Contato (WhatsApp, Instagram...)'**
  String get shopContact;

  /// No description provided for @shopLogo.
  ///
  /// In pt, this message translates to:
  /// **'Logo'**
  String get shopLogo;

  /// No description provided for @chooseLogo.
  ///
  /// In pt, this message translates to:
  /// **'Escolher logo'**
  String get chooseLogo;

  /// No description provided for @removeLogo.
  ///
  /// In pt, this message translates to:
  /// **'Remover logo'**
  String get removeLogo;

  /// No description provided for @printerModuleTitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhar impressora na rede (beta)'**
  String get printerModuleTitle;

  /// No description provided for @printerModuleSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Mostra o andamento da impressão de uma impressora na mesma rede Wi-Fi. Desligado por padrão.'**
  String get printerModuleSubtitle;

  /// No description provided for @settingsSaved.
  ///
  /// In pt, this message translates to:
  /// **'Configurações salvas'**
  String get settingsSaved;

  /// No description provided for @helpKwh.
  ///
  /// In pt, this message translates to:
  /// **'Valor da conta de luz dividido pelos kWh consumidos (está na fatura). Use 4 casas se quiser, ex.: 0,8950.'**
  String get helpKwh;

  /// No description provided for @helpLabor.
  ///
  /// In pt, this message translates to:
  /// **'Quanto vale uma hora do seu trabalho manual (tirar suporte, lixar, pintar, embalar).'**
  String get helpLabor;

  /// No description provided for @helpPackaging.
  ///
  /// In pt, this message translates to:
  /// **'Caixa, saquinho, etiqueta, brinde... por peça vendida.'**
  String get helpPackaging;

  /// No description provided for @helpMarketplace.
  ///
  /// In pt, this message translates to:
  /// **'Comissão da plataforma de venda (Shopee, Mercado Livre, Elo7...). Use 0 se você vende direto.'**
  String get helpMarketplace;

  /// No description provided for @helpTax.
  ///
  /// In pt, this message translates to:
  /// **'Impostos sobre a venda (ex.: Simples Nacional). Use 0 se não se aplica.'**
  String get helpTax;

  /// No description provided for @helpMargin.
  ///
  /// In pt, this message translates to:
  /// **'Quanto do preço final fica com você como lucro, depois de pagar custos, taxas e impostos. 30% é um bom começo.'**
  String get helpMargin;

  /// No description provided for @helpWaste.
  ///
  /// In pt, this message translates to:
  /// **'Filamento perdido em purga (troca de cor no AMS), testes e sobras. 5% para uma cor; com muitas cores, use mais.'**
  String get helpWaste;

  /// No description provided for @helpFailure.
  ///
  /// In pt, this message translates to:
  /// **'Reserva para impressões que dão errado. Se 1 em cada 20 falha, use 5%.'**
  String get helpFailure;

  /// No description provided for @helpRounding.
  ///
  /// In pt, this message translates to:
  /// **'Arredonda o preço sempre para cima, para ficar com cara de preço de loja.'**
  String get helpRounding;

  /// No description provided for @helpCurrency.
  ///
  /// In pt, this message translates to:
  /// **'Moeda usada para mostrar os valores. Não converte valores já cadastrados.'**
  String get helpCurrency;

  /// No description provided for @roundingNone.
  ///
  /// In pt, this message translates to:
  /// **'Sem arredondar'**
  String get roundingNone;

  /// No description provided for @rounding90.
  ///
  /// In pt, this message translates to:
  /// **'Terminar em ,90'**
  String get rounding90;

  /// No description provided for @rounding99.
  ///
  /// In pt, this message translates to:
  /// **'Terminar em ,99'**
  String get rounding99;

  /// No description provided for @roundingHalf.
  ///
  /// In pt, this message translates to:
  /// **'Múltiplo de 0,50'**
  String get roundingHalf;

  /// No description provided for @roundingWhole.
  ///
  /// In pt, this message translates to:
  /// **'Valor inteiro'**
  String get roundingWhole;

  /// No description provided for @calcFilamentsSection.
  ///
  /// In pt, this message translates to:
  /// **'Filamento usado'**
  String get calcFilamentsSection;

  /// No description provided for @calcAddFilament.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar outro filamento'**
  String get calcAddFilament;

  /// No description provided for @calcSelectFilament.
  ///
  /// In pt, this message translates to:
  /// **'Filamento'**
  String get calcSelectFilament;

  /// No description provided for @calcGrams.
  ///
  /// In pt, this message translates to:
  /// **'Gramas'**
  String get calcGrams;

  /// No description provided for @calcPrinterSection.
  ///
  /// In pt, this message translates to:
  /// **'Impressão'**
  String get calcPrinterSection;

  /// No description provided for @calcPrinter.
  ///
  /// In pt, this message translates to:
  /// **'Impressora'**
  String get calcPrinter;

  /// No description provided for @calcNoPrinter.
  ///
  /// In pt, this message translates to:
  /// **'Sem impressora (ignora energia e desgaste)'**
  String get calcNoPrinter;

  /// No description provided for @calcHours.
  ///
  /// In pt, this message translates to:
  /// **'Horas'**
  String get calcHours;

  /// No description provided for @calcMinutes.
  ///
  /// In pt, this message translates to:
  /// **'Minutos'**
  String get calcMinutes;

  /// No description provided for @calcPostProcess.
  ///
  /// In pt, this message translates to:
  /// **'Pós-processamento (min)'**
  String get calcPostProcess;

  /// No description provided for @calcPercentsSection.
  ///
  /// In pt, this message translates to:
  /// **'Margem e reservas'**
  String get calcPercentsSection;

  /// No description provided for @calcWaste.
  ///
  /// In pt, this message translates to:
  /// **'Desperdício/purga (%)'**
  String get calcWaste;

  /// No description provided for @calcFailure.
  ///
  /// In pt, this message translates to:
  /// **'Taxa de falha (%)'**
  String get calcFailure;

  /// No description provided for @calcMargin.
  ///
  /// In pt, this message translates to:
  /// **'Margem de lucro (%)'**
  String get calcMargin;

  /// No description provided for @calcAdvanced.
  ///
  /// In pt, this message translates to:
  /// **'Custos e taxas desta peça'**
  String get calcAdvanced;

  /// No description provided for @calcAdvancedSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Vêm das Configurações. Altere aqui só para esta peça.'**
  String get calcAdvancedSubtitle;

  /// No description provided for @calcResultPrice.
  ///
  /// In pt, this message translates to:
  /// **'Preço sugerido'**
  String get calcResultPrice;

  /// No description provided for @calcResultCost.
  ///
  /// In pt, this message translates to:
  /// **'Custo total'**
  String get calcResultCost;

  /// No description provided for @calcResultProfit.
  ///
  /// In pt, this message translates to:
  /// **'Lucro líquido'**
  String get calcResultProfit;

  /// No description provided for @calcPriceBeforeRounding.
  ///
  /// In pt, this message translates to:
  /// **'Sem arredondar: {price}'**
  String calcPriceBeforeRounding(String price);

  /// No description provided for @profitPercentOfPrice.
  ///
  /// In pt, this message translates to:
  /// **'{percent} do preço'**
  String profitPercentOfPrice(String percent);

  /// No description provided for @calcBreakdown.
  ///
  /// In pt, this message translates to:
  /// **'Para onde vai o dinheiro'**
  String get calcBreakdown;

  /// No description provided for @breakdownMaterial.
  ///
  /// In pt, this message translates to:
  /// **'Material'**
  String get breakdownMaterial;

  /// No description provided for @breakdownEnergy.
  ///
  /// In pt, this message translates to:
  /// **'Energia'**
  String get breakdownEnergy;

  /// No description provided for @breakdownWear.
  ///
  /// In pt, this message translates to:
  /// **'Desgaste da máquina'**
  String get breakdownWear;

  /// No description provided for @breakdownLabor.
  ///
  /// In pt, this message translates to:
  /// **'Mão de obra'**
  String get breakdownLabor;

  /// No description provided for @breakdownPackaging.
  ///
  /// In pt, this message translates to:
  /// **'Embalagem'**
  String get breakdownPackaging;

  /// No description provided for @breakdownFailure.
  ///
  /// In pt, this message translates to:
  /// **'Reserva para falhas'**
  String get breakdownFailure;

  /// No description provided for @breakdownFees.
  ///
  /// In pt, this message translates to:
  /// **'Taxa do marketplace'**
  String get breakdownFees;

  /// No description provided for @breakdownTaxes.
  ///
  /// In pt, this message translates to:
  /// **'Impostos'**
  String get breakdownTaxes;

  /// No description provided for @breakdownProfit.
  ///
  /// In pt, this message translates to:
  /// **'Seu lucro'**
  String get breakdownProfit;

  /// No description provided for @calcSave.
  ///
  /// In pt, this message translates to:
  /// **'Salvar peça'**
  String get calcSave;

  /// No description provided for @calcUpdate.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar peça'**
  String get calcUpdate;

  /// No description provided for @calcClear.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get calcClear;

  /// No description provided for @calcEditing.
  ///
  /// In pt, this message translates to:
  /// **'Editando: {name}'**
  String calcEditing(String name);

  /// No description provided for @calcImport3mf.
  ///
  /// In pt, this message translates to:
  /// **'Importar do arquivo (.3mf)'**
  String get calcImport3mf;

  /// No description provided for @calcNeedFilament.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre pelo menos um filamento para calcular.'**
  String get calcNeedFilament;

  /// No description provided for @calcGoToFilaments.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar filamento'**
  String get calcGoToFilaments;

  /// No description provided for @calcFillToSee.
  ///
  /// In pt, this message translates to:
  /// **'Preencha o filamento e o tempo para ver o preço.'**
  String get calcFillToSee;

  /// No description provided for @helpGrams.
  ///
  /// In pt, this message translates to:
  /// **'Quantos gramas desse filamento a peça usa. O fatiador (Bambu Studio, Orca...) mostra depois de fatiar. Ou use \"Importar do arquivo\".'**
  String get helpGrams;

  /// No description provided for @helpPrinterField.
  ///
  /// In pt, this message translates to:
  /// **'Impressora usada. Define o gasto de energia e o desgaste por hora.'**
  String get helpPrinterField;

  /// No description provided for @helpPrintTime.
  ///
  /// In pt, this message translates to:
  /// **'Tempo estimado de impressão mostrado pelo fatiador.'**
  String get helpPrintTime;

  /// No description provided for @helpPostProcess.
  ///
  /// In pt, this message translates to:
  /// **'Seu tempo removendo suporte, lixando, pintando, montando e embalando esta peça.'**
  String get helpPostProcess;

  /// No description provided for @errDeductionsTooHigh.
  ///
  /// In pt, this message translates to:
  /// **'Margem + taxas + impostos somam {total}. Essa soma precisa ficar abaixo de 100%, senão nenhum preço cobre os descontos. Diminua a margem ou as taxas.'**
  String errDeductionsTooHigh(String total);

  /// No description provided for @errNegative.
  ///
  /// In pt, this message translates to:
  /// **'Algum valor está negativo. Confira os campos.'**
  String get errNegative;

  /// No description provided for @errRollWeight.
  ///
  /// In pt, this message translates to:
  /// **'Um filamento está com peso do rolo zerado. Corrija no cadastro do filamento.'**
  String get errRollWeight;

  /// No description provided for @saveJobTitle.
  ///
  /// In pt, this message translates to:
  /// **'Salvar peça'**
  String get saveJobTitle;

  /// No description provided for @jobName.
  ///
  /// In pt, this message translates to:
  /// **'Nome da peça'**
  String get jobName;

  /// No description provided for @jobCustomer.
  ///
  /// In pt, this message translates to:
  /// **'Cliente (opcional)'**
  String get jobCustomer;

  /// No description provided for @jobQuantity.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade'**
  String get jobQuantity;

  /// No description provided for @jobStatus.
  ///
  /// In pt, this message translates to:
  /// **'Status'**
  String get jobStatus;

  /// No description provided for @jobNotes.
  ///
  /// In pt, this message translates to:
  /// **'Observações (opcional)'**
  String get jobNotes;

  /// No description provided for @jobPhoto.
  ///
  /// In pt, this message translates to:
  /// **'Foto (opcional)'**
  String get jobPhoto;

  /// No description provided for @takePhoto.
  ///
  /// In pt, this message translates to:
  /// **'Tirar foto'**
  String get takePhoto;

  /// No description provided for @pickPhoto.
  ///
  /// In pt, this message translates to:
  /// **'Galeria'**
  String get pickPhoto;

  /// No description provided for @removePhoto.
  ///
  /// In pt, this message translates to:
  /// **'Remover foto'**
  String get removePhoto;

  /// No description provided for @jobSaved.
  ///
  /// In pt, this message translates to:
  /// **'Peça salva no histórico'**
  String get jobSaved;

  /// No description provided for @statusQuote.
  ///
  /// In pt, this message translates to:
  /// **'Orçamento'**
  String get statusQuote;

  /// No description provided for @statusInProduction.
  ///
  /// In pt, this message translates to:
  /// **'Em produção'**
  String get statusInProduction;

  /// No description provided for @statusDelivered.
  ///
  /// In pt, this message translates to:
  /// **'Entregue'**
  String get statusDelivered;

  /// No description provided for @historyEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma peça salva ainda. Calcule um preço e toque em \"Salvar peça\".'**
  String get historyEmpty;

  /// No description provided for @historySearch.
  ///
  /// In pt, this message translates to:
  /// **'Buscar por nome ou cliente'**
  String get historySearch;

  /// No description provided for @filterAll.
  ///
  /// In pt, this message translates to:
  /// **'Todos'**
  String get filterAll;

  /// No description provided for @markPrinted.
  ///
  /// In pt, this message translates to:
  /// **'Marcar como impressa'**
  String get markPrinted;

  /// No description provided for @printedBadge.
  ///
  /// In pt, this message translates to:
  /// **'Impressa'**
  String get printedBadge;

  /// No description provided for @stockUpdated.
  ///
  /// In pt, this message translates to:
  /// **'Estoque de filamento atualizado'**
  String get stockUpdated;

  /// No description provided for @stockAlreadyDeducted.
  ///
  /// In pt, this message translates to:
  /// **'O estoque desta peça já foi descontado.'**
  String get stockAlreadyDeducted;

  /// No description provided for @lowStockWarning.
  ///
  /// In pt, this message translates to:
  /// **'{name} está acabando: restam {grams}.'**
  String lowStockWarning(String name, String grams);

  /// No description provided for @insufficientStockWarning.
  ///
  /// In pt, this message translates to:
  /// **'{name}: o estoque cadastrado não era suficiente e ficou zerado. Confira o rolo.'**
  String insufficientStockWarning(String name);

  /// No description provided for @jobDetails.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes da peça'**
  String get jobDetails;

  /// No description provided for @openInCalculator.
  ///
  /// In pt, this message translates to:
  /// **'Abrir na calculadora'**
  String get openInCalculator;

  /// No description provided for @deleteJobConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Excluir esta peça do histórico? O estoque não é devolvido.'**
  String get deleteJobConfirm;

  /// No description provided for @unitPrice.
  ///
  /// In pt, this message translates to:
  /// **'Preço unitário'**
  String get unitPrice;

  /// No description provided for @unitCost.
  ///
  /// In pt, this message translates to:
  /// **'Custo unitário'**
  String get unitCost;

  /// No description provided for @unitProfit.
  ///
  /// In pt, this message translates to:
  /// **'Lucro unitário'**
  String get unitProfit;

  /// No description provided for @totalLabel.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get totalLabel;

  /// No description provided for @quantityUnits.
  ///
  /// In pt, this message translates to:
  /// **'{count} un.'**
  String quantityUnits(int count);

  /// No description provided for @printedOn.
  ///
  /// In pt, this message translates to:
  /// **'Impressa em {date}'**
  String printedOn(String date);

  /// No description provided for @createdOn.
  ///
  /// In pt, this message translates to:
  /// **'Criada em {date}'**
  String createdOn(String date);

  /// No description provided for @printTimeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tempo de impressão'**
  String get printTimeLabel;

  /// No description provided for @sourceFileLabel.
  ///
  /// In pt, this message translates to:
  /// **'Arquivo'**
  String get sourceFileLabel;

  /// No description provided for @generatePdf.
  ///
  /// In pt, this message translates to:
  /// **'Orçamento em PDF'**
  String get generatePdf;

  /// No description provided for @selectForQuote.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar peças para o orçamento'**
  String get selectForQuote;

  /// No description provided for @quoteSelectedCount.
  ///
  /// In pt, this message translates to:
  /// **'{count} selecionadas'**
  String quoteSelectedCount(int count);

  /// No description provided for @createQuote.
  ///
  /// In pt, this message translates to:
  /// **'Gerar PDF'**
  String get createQuote;

  /// No description provided for @pdfCustomerPrompt.
  ///
  /// In pt, this message translates to:
  /// **'Nome do cliente no orçamento'**
  String get pdfCustomerPrompt;

  /// No description provided for @pdfQuoteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Orçamento'**
  String get pdfQuoteTitle;

  /// No description provided for @pdfItem.
  ///
  /// In pt, this message translates to:
  /// **'Item'**
  String get pdfItem;

  /// No description provided for @pdfQty.
  ///
  /// In pt, this message translates to:
  /// **'Qtd.'**
  String get pdfQty;

  /// No description provided for @pdfUnit.
  ///
  /// In pt, this message translates to:
  /// **'Unitário'**
  String get pdfUnit;

  /// No description provided for @pdfSubtotal.
  ///
  /// In pt, this message translates to:
  /// **'Subtotal'**
  String get pdfSubtotal;

  /// No description provided for @pdfTotal.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get pdfTotal;

  /// No description provided for @pdfCustomer.
  ///
  /// In pt, this message translates to:
  /// **'Cliente'**
  String get pdfCustomer;

  /// No description provided for @pdfDate.
  ///
  /// In pt, this message translates to:
  /// **'Data'**
  String get pdfDate;

  /// No description provided for @pdfValidity.
  ///
  /// In pt, this message translates to:
  /// **'Orçamento válido por 7 dias.'**
  String get pdfValidity;

  /// No description provided for @dashboardEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Os números aparecem aqui quando você tiver peças em produção ou entregues.'**
  String get dashboardEmpty;

  /// No description provided for @dashProfitByMonth.
  ///
  /// In pt, this message translates to:
  /// **'Lucro por mês'**
  String get dashProfitByMonth;

  /// No description provided for @dashRevenue.
  ///
  /// In pt, this message translates to:
  /// **'Faturamento'**
  String get dashRevenue;

  /// No description provided for @dashProfit.
  ///
  /// In pt, this message translates to:
  /// **'Lucro'**
  String get dashProfit;

  /// No description provided for @dashAvgMargin.
  ///
  /// In pt, this message translates to:
  /// **'Margem média'**
  String get dashAvgMargin;

  /// No description provided for @dashJobsSold.
  ///
  /// In pt, this message translates to:
  /// **'Peças vendidas'**
  String get dashJobsSold;

  /// No description provided for @dashTopJobs.
  ///
  /// In pt, this message translates to:
  /// **'Peças mais lucrativas'**
  String get dashTopJobs;

  /// No description provided for @dashFilamentUsage.
  ///
  /// In pt, this message translates to:
  /// **'Filamento mais usado'**
  String get dashFilamentUsage;

  /// No description provided for @dashNote.
  ///
  /// In pt, this message translates to:
  /// **'Conta peças em produção e entregues. Orçamentos ficam de fora.'**
  String get dashNote;

  /// No description provided for @backupExport.
  ///
  /// In pt, this message translates to:
  /// **'Exportar backup'**
  String get backupExport;

  /// No description provided for @backupExportHelp.
  ///
  /// In pt, this message translates to:
  /// **'Gera um arquivo com todos os seus dados. Guarde no Google Drive, e-mail ou computador.'**
  String get backupExportHelp;

  /// No description provided for @backupImport.
  ///
  /// In pt, this message translates to:
  /// **'Restaurar backup'**
  String get backupImport;

  /// No description provided for @backupImportHelp.
  ///
  /// In pt, this message translates to:
  /// **'Substitui os dados atuais pelos de um arquivo de backup.'**
  String get backupImportHelp;

  /// No description provided for @backupImportWarning.
  ///
  /// In pt, this message translates to:
  /// **'Isso substitui TODOS os dados atuais pelos do arquivo. Faça um backup antes, se precisar. Continuar?'**
  String get backupImportWarning;

  /// No description provided for @backupSaved.
  ///
  /// In pt, this message translates to:
  /// **'Backup salvo'**
  String get backupSaved;

  /// No description provided for @backupRestored.
  ///
  /// In pt, this message translates to:
  /// **'Backup restaurado'**
  String get backupRestored;

  /// No description provided for @backupInvalidFile.
  ///
  /// In pt, this message translates to:
  /// **'Esse arquivo não parece ser um backup do PrintCost.'**
  String get backupInvalidFile;

  /// No description provided for @backupNewerVersion.
  ///
  /// In pt, this message translates to:
  /// **'Esse backup foi feito numa versão mais nova do app. Atualize o app antes de restaurar.'**
  String get backupNewerVersion;

  /// No description provided for @backupPhotosNote.
  ///
  /// In pt, this message translates to:
  /// **'Fotos das peças não vão no backup, só os dados.'**
  String get backupPhotosNote;

  /// No description provided for @backupShare.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get backupShare;

  /// No description provided for @backupSaveToFile.
  ///
  /// In pt, this message translates to:
  /// **'Salvar em arquivo'**
  String get backupSaveToFile;

  /// No description provided for @restore.
  ///
  /// In pt, this message translates to:
  /// **'Restaurar'**
  String get restore;

  /// No description provided for @about.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get about;

  /// No description provided for @aboutText.
  ///
  /// In pt, this message translates to:
  /// **'PrintCost é uma calculadora offline: seus dados ficam só no aparelho. Compatível com arquivos do Bambu Studio e impressoras Bambu Lab no modo LAN. Este app não é afiliado, patrocinado ou endossado pela Bambu Lab.'**
  String get aboutText;

  /// No description provided for @importPickPlate.
  ///
  /// In pt, this message translates to:
  /// **'Qual placa você quer importar?'**
  String get importPickPlate;

  /// No description provided for @plateLabel.
  ///
  /// In pt, this message translates to:
  /// **'Placa {index}'**
  String plateLabel(int index);

  /// No description provided for @importSummaryTitle.
  ///
  /// In pt, this message translates to:
  /// **'Dados encontrados no arquivo'**
  String get importSummaryTitle;

  /// No description provided for @importTime.
  ///
  /// In pt, this message translates to:
  /// **'Tempo de impressão: {time}'**
  String importTime(String time);

  /// No description provided for @importFilamentLine.
  ///
  /// In pt, this message translates to:
  /// **'{name}: {weight}'**
  String importFilamentLine(String name, String weight);

  /// No description provided for @importMissingTime.
  ///
  /// In pt, this message translates to:
  /// **'O arquivo não informa o tempo de impressão. Preencha manualmente.'**
  String get importMissingTime;

  /// No description provided for @importOnlyTotalWeight.
  ///
  /// In pt, this message translates to:
  /// **'O arquivo só traz o peso total ({weight}), sem separar por filamento. Ele entrou como um filamento só; ajuste se precisar.'**
  String importOnlyTotalWeight(String weight);

  /// No description provided for @importMissingWeight.
  ///
  /// In pt, this message translates to:
  /// **'O arquivo não informa o peso do filamento. Preencha manualmente.'**
  String get importMissingWeight;

  /// No description provided for @importUnmatched.
  ///
  /// In pt, this message translates to:
  /// **'Alguns filamentos do arquivo não têm cadastro do mesmo tipo. Escolha o filamento certo na calculadora.'**
  String get importUnmatched;

  /// No description provided for @importErrNotA3mf.
  ///
  /// In pt, this message translates to:
  /// **'Esse arquivo não é um .3mf válido.'**
  String get importErrNotA3mf;

  /// No description provided for @importErrNoSliceInfo.
  ///
  /// In pt, this message translates to:
  /// **'Esse .3mf não tem dados de fatiamento (peso e tempo). No Bambu Studio, fatie a placa e salve o projeto, ou use \"Exportar arquivo fatiado da placa\". Você também pode preencher os campos à mão.'**
  String get importErrNoSliceInfo;

  /// No description provided for @importErrNoPlates.
  ///
  /// In pt, this message translates to:
  /// **'O arquivo abriu, mas nenhuma placa tem peso ou tempo. Fatie de novo e salve, ou preencha à mão.'**
  String get importErrNoPlates;

  /// No description provided for @importErrWrongExtension.
  ///
  /// In pt, this message translates to:
  /// **'Escolha um arquivo .3mf (projeto do Bambu Studio ou .gcode.3mf).'**
  String get importErrWrongExtension;

  /// No description provided for @importApply.
  ///
  /// In pt, this message translates to:
  /// **'Usar estes dados'**
  String get importApply;

  /// No description provided for @pmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Impressora na rede'**
  String get pmTitle;

  /// No description provided for @pmSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhe a impressão em tempo real'**
  String get pmSubtitle;

  /// No description provided for @pmEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma impressora conectada ainda. Toque em + para configurar (leva uns 3 minutos).'**
  String get pmEmpty;

  /// No description provided for @pmAdd.
  ///
  /// In pt, this message translates to:
  /// **'Conectar impressora'**
  String get pmAdd;

  /// No description provided for @pmDeleteConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Remover esta conexão? O código de acesso salvo no aparelho também é apagado.'**
  String get pmDeleteConfirm;

  /// No description provided for @pmRemoteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhar fora de casa'**
  String get pmRemoteTitle;

  /// No description provided for @pmRemoteText.
  ///
  /// In pt, this message translates to:
  /// **'Use uma VPN como Tailscale ou NetBird no celular e em um computador ou roteador da sua casa: é grátis para uso pessoal e o celular passa a \"enxergar\" a impressora como se estivesse no Wi-Fi. Nunca abra a porta da impressora (8883) na internet com redirecionamento de portas no roteador: qualquer pessoa poderia tentar acessá-la.'**
  String get pmRemoteText;

  /// No description provided for @pmState_idle.
  ///
  /// In pt, this message translates to:
  /// **'Ociosa'**
  String get pmState_idle;

  /// No description provided for @pmState_preparing.
  ///
  /// In pt, this message translates to:
  /// **'Preparando'**
  String get pmState_preparing;

  /// No description provided for @pmState_printing.
  ///
  /// In pt, this message translates to:
  /// **'Imprimindo'**
  String get pmState_printing;

  /// No description provided for @pmState_paused.
  ///
  /// In pt, this message translates to:
  /// **'Pausada'**
  String get pmState_paused;

  /// No description provided for @pmState_finished.
  ///
  /// In pt, this message translates to:
  /// **'Concluída'**
  String get pmState_finished;

  /// No description provided for @pmState_failed.
  ///
  /// In pt, this message translates to:
  /// **'Falhou'**
  String get pmState_failed;

  /// No description provided for @pmState_unknown.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando status…'**
  String get pmState_unknown;

  /// No description provided for @pmConnecting.
  ///
  /// In pt, this message translates to:
  /// **'Conectando…'**
  String get pmConnecting;

  /// No description provided for @pmConnected.
  ///
  /// In pt, this message translates to:
  /// **'Conectada'**
  String get pmConnected;

  /// No description provided for @pmDisconnected.
  ///
  /// In pt, this message translates to:
  /// **'Desconectada'**
  String get pmDisconnected;

  /// No description provided for @pmReconnect.
  ///
  /// In pt, this message translates to:
  /// **'Tentar de novo'**
  String get pmReconnect;

  /// No description provided for @pmRemaining.
  ///
  /// In pt, this message translates to:
  /// **'Faltam {time}'**
  String pmRemaining(String time);

  /// No description provided for @pmFile.
  ///
  /// In pt, this message translates to:
  /// **'Arquivo: {name}'**
  String pmFile(String name);

  /// No description provided for @pmErrorCode.
  ///
  /// In pt, this message translates to:
  /// **'Código de erro da impressora: {code}'**
  String pmErrorCode(String code);

  /// No description provided for @pmRegisterPrint.
  ///
  /// In pt, this message translates to:
  /// **'Registrar esta impressão'**
  String get pmRegisterPrint;

  /// No description provided for @pmRegisterText.
  ///
  /// In pt, this message translates to:
  /// **'Para pegar o peso de cada filamento, escolha o arquivo .3mf desta impressão (o mesmo que você mandou imprimir). Ou siga só com o tempo e preencha o peso na calculadora.'**
  String get pmRegisterText;

  /// No description provided for @pmRegisterNoFetch.
  ///
  /// In pt, this message translates to:
  /// **'Baixar o arquivo direto da impressora ainda não é suportado.'**
  String get pmRegisterNoFetch;

  /// No description provided for @pmChoose3mf.
  ///
  /// In pt, this message translates to:
  /// **'Escolher .3mf'**
  String get pmChoose3mf;

  /// No description provided for @pmOnlyTime.
  ///
  /// In pt, this message translates to:
  /// **'Só o tempo'**
  String get pmOnlyTime;

  /// No description provided for @pmDebugTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mensagens recebidas (debug)'**
  String get pmDebugTitle;

  /// No description provided for @pmDebugHelp.
  ///
  /// In pt, this message translates to:
  /// **'Últimas mensagens cruas enviadas pela impressora. Use para conferir os nomes dos campos se algo aparecer errado. O código de acesso nunca aparece aqui.'**
  String get pmDebugHelp;

  /// No description provided for @pmDebugEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma mensagem ainda.'**
  String get pmDebugEmpty;

  /// No description provided for @pmCopy.
  ///
  /// In pt, this message translates to:
  /// **'Copiar'**
  String get pmCopy;

  /// No description provided for @pmCopied.
  ///
  /// In pt, this message translates to:
  /// **'Copiado'**
  String get pmCopied;

  /// No description provided for @pmMergedState.
  ///
  /// In pt, this message translates to:
  /// **'Estado mesclado atual'**
  String get pmMergedState;

  /// No description provided for @pmNotifyFinished.
  ///
  /// In pt, this message translates to:
  /// **'Impressão concluída'**
  String get pmNotifyFinished;

  /// No description provided for @pmNotifyFailed.
  ///
  /// In pt, this message translates to:
  /// **'A impressão falhou'**
  String get pmNotifyFailed;

  /// No description provided for @pmNotifyChannel.
  ///
  /// In pt, this message translates to:
  /// **'Status da impressora'**
  String get pmNotifyChannel;

  /// No description provided for @pmForegroundNote.
  ///
  /// In pt, this message translates to:
  /// **'Os avisos de fim de impressão funcionam enquanto o app está aberto ou em segundo plano recente. Se o sistema fechar o app, abra-o de novo para reconectar.'**
  String get pmForegroundNote;

  /// No description provided for @wzTitle.
  ///
  /// In pt, this message translates to:
  /// **'Conectar impressora'**
  String get wzTitle;

  /// No description provided for @wzStep.
  ///
  /// In pt, this message translates to:
  /// **'Passo {step} de 4'**
  String wzStep(int step);

  /// No description provided for @wz1Title.
  ///
  /// In pt, this message translates to:
  /// **'Ative o modo LAN'**
  String get wz1Title;

  /// No description provided for @wz1Text.
  ///
  /// In pt, this message translates to:
  /// **'Na tela da impressora, abra Configurações (engrenagem) → WLAN/Rede e ligue \"Modo somente LAN\" (LAN Only Mode). Assim ela conversa direto com o celular pela sua rede Wi-Fi, sem passar pela nuvem.\n\nEnquanto o modo LAN estiver ligado, o app oficial e a impressão pela nuvem não funcionam.'**
  String get wz1Text;

  /// No description provided for @wz2Title.
  ///
  /// In pt, this message translates to:
  /// **'Ative o Developer Mode'**
  String get wz2Title;

  /// No description provided for @wz2Text.
  ///
  /// In pt, this message translates to:
  /// **'Em firmwares recentes (e nos modelos H2) também é preciso ligar o \"Modo desenvolvedor\" (Developer Mode), que fica na mesma tela do modo LAN.\n\nAtenção: é um modo sem suporte oficial da fabricante. Ele libera o acesso local para programas de terceiros como este. O PrintCost só lê o status: nunca envia comandos para a impressora.'**
  String get wz2Text;

  /// No description provided for @wz3Title.
  ///
  /// In pt, this message translates to:
  /// **'Dados da impressora'**
  String get wz3Title;

  /// No description provided for @wz3Text.
  ///
  /// In pt, this message translates to:
  /// **'Na tela de rede da impressora aparecem o IP e o código de acesso (8 caracteres). O número de série fica em Configurações → Dispositivo (ou na etiqueta atrás da impressora).'**
  String get wz3Text;

  /// No description provided for @wz4Title.
  ///
  /// In pt, this message translates to:
  /// **'Testar conexão'**
  String get wz4Title;

  /// No description provided for @wz4Text.
  ///
  /// In pt, this message translates to:
  /// **'O celular precisa estar no mesmo Wi-Fi da impressora.'**
  String get wz4Text;

  /// No description provided for @wzName.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get wzName;

  /// No description provided for @wzIp.
  ///
  /// In pt, this message translates to:
  /// **'Endereço IP'**
  String get wzIp;

  /// No description provided for @wzSerial.
  ///
  /// In pt, this message translates to:
  /// **'Número de série'**
  String get wzSerial;

  /// No description provided for @wzCode.
  ///
  /// In pt, this message translates to:
  /// **'Código de acesso'**
  String get wzCode;

  /// No description provided for @wzLinkedPrinter.
  ///
  /// In pt, this message translates to:
  /// **'Impressora cadastrada (para os custos)'**
  String get wzLinkedPrinter;

  /// No description provided for @wzLinkedNone.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma'**
  String get wzLinkedNone;

  /// No description provided for @wzHelpIp.
  ///
  /// In pt, this message translates to:
  /// **'Aparece na tela de rede da impressora. Ex.: 192.168.0.50. Dica: reserve esse IP no roteador para ele não mudar.'**
  String get wzHelpIp;

  /// No description provided for @wzHelpCode.
  ///
  /// In pt, this message translates to:
  /// **'8 caracteres, na tela do modo LAN. Muda toda vez que você desliga e liga o modo LAN. Fica guardado só neste aparelho, de forma protegida, e não vai no backup.'**
  String get wzHelpCode;

  /// No description provided for @wzHelpSerial.
  ///
  /// In pt, this message translates to:
  /// **'Em Configurações → Dispositivo, ou na etiqueta. Pode digitar com ou sem traços.'**
  String get wzHelpSerial;

  /// No description provided for @wzInvalidIp.
  ///
  /// In pt, this message translates to:
  /// **'Use o formato 192.168.0.50'**
  String get wzInvalidIp;

  /// No description provided for @wzInvalidCode.
  ///
  /// In pt, this message translates to:
  /// **'O código tem 8 caracteres'**
  String get wzInvalidCode;

  /// No description provided for @wzTest.
  ///
  /// In pt, this message translates to:
  /// **'Testar conexão'**
  String get wzTest;

  /// No description provided for @wzTesting.
  ///
  /// In pt, this message translates to:
  /// **'Testando…'**
  String get wzTesting;

  /// No description provided for @wzSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Conectado! A impressora está: {state}'**
  String wzSuccess(String state);

  /// No description provided for @wzSave.
  ///
  /// In pt, this message translates to:
  /// **'Salvar e acompanhar'**
  String get wzSave;

  /// No description provided for @wzShowCode.
  ///
  /// In pt, this message translates to:
  /// **'Mostrar código'**
  String get wzShowCode;

  /// No description provided for @errUnreachable.
  ///
  /// In pt, this message translates to:
  /// **'Não encontrei a impressora em {ip}. Confira: o IP está certo? O celular está no mesmo Wi-Fi (não no 4G/5G nem na rede de convidados)? A impressora está ligada e com o modo LAN ativo?'**
  String errUnreachable(String ip);

  /// No description provided for @errRejected.
  ///
  /// In pt, this message translates to:
  /// **'A impressora recusou a conexão. Confira o código de acesso: ele muda sempre que o modo LAN é desligado e ligado de novo. Em firmwares recentes, confira também se o Developer Mode está ligado.'**
  String get errRejected;

  /// No description provided for @errNoReports.
  ///
  /// In pt, this message translates to:
  /// **'Conectou, mas a impressora não enviou o status. Isso costuma acontecer com o Developer Mode desligado ou com o número de série errado.'**
  String get errNoReports;

  /// No description provided for @errCertChanged.
  ///
  /// In pt, this message translates to:
  /// **'O certificado de segurança da impressora mudou desde a última conexão. Se você trocou ou resetou a impressora, remova a conexão e cadastre de novo. Se não, pode haver outro aparelho se passando pela impressora na rede.'**
  String get errCertChanged;

  /// No description provided for @errInvalidConfig.
  ///
  /// In pt, this message translates to:
  /// **'Confira os campos: o IP deve estar no formato 192.168.0.50 e o código tem 8 caracteres.'**
  String get errInvalidConfig;

  /// No description provided for @errUnknownPrinter.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível conectar. {detail}'**
  String errUnknownPrinter(String detail);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

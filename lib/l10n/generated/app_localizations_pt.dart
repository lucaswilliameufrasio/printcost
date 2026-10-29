// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'PrintCost';

  @override
  String get navCalculator => 'Calculadora';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navDashboard => 'Painel';

  @override
  String get navMore => 'Mais';

  @override
  String get filaments => 'Filamentos';

  @override
  String get printers => 'Impressoras';

  @override
  String get settings => 'Configurações';

  @override
  String get backup => 'Backup';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get edit => 'Editar';

  @override
  String get add => 'Adicionar';

  @override
  String get close => 'Fechar';

  @override
  String get ok => 'OK';

  @override
  String get back => 'Voltar';

  @override
  String get next => 'Próximo';

  @override
  String get archive => 'Arquivar';

  @override
  String get help => 'Ajuda';

  @override
  String get optional => 'opcional';

  @override
  String get requiredField => 'Preencha este campo';

  @override
  String get invalidNumber => 'Número inválido. Ex.: 12,50';

  @override
  String get mustBePositive => 'Precisa ser maior que zero';

  @override
  String unexpectedError(String error) {
    return 'Algo deu errado: $error';
  }

  @override
  String get newFilament => 'Novo filamento';

  @override
  String get editFilament => 'Editar filamento';

  @override
  String get noFilaments =>
      'Nenhum filamento cadastrado. Toque em + para cadastrar o primeiro rolo.';

  @override
  String get filamentBrand => 'Marca';

  @override
  String get filamentMaterial => 'Tipo';

  @override
  String get filamentColor => 'Cor';

  @override
  String get filamentRollPrice => 'Preço do rolo';

  @override
  String get filamentRollWeight => 'Peso do rolo (g)';

  @override
  String get filamentStock => 'Estoque restante (g)';

  @override
  String get filamentLowStock => 'Avisar quando restar (g)';

  @override
  String get helpBrand =>
      'Fabricante do filamento. Ex.: Bambu, Voolt, 3D Fila, eSun.';

  @override
  String get helpMaterial =>
      'Tipo do plástico: PLA, PETG, ABS, TPU... Só para você se organizar.';

  @override
  String get helpColor =>
      'Nome da cor e, se quiser, a cor da bolinha para achar rápido na lista.';

  @override
  String get helpRollPrice =>
      'Quanto você pagou no rolo. Pode incluir o frete dividido.';

  @override
  String get helpRollWeight =>
      'Peso do filamento no rolo, sem o carretel. Quase sempre 1000 g.';

  @override
  String get helpStock =>
      'Quanto ainda tem no rolo. Rolo novo: igual ao peso do rolo. O app desconta sozinho quando você marca uma peça como impressa.';

  @override
  String get helpLowStock =>
      'Você recebe um aviso quando o estoque chegar nesse valor.';

  @override
  String get lowStockBadge => 'Acabando';

  @override
  String stockLeft(String grams) {
    return '$grams restantes';
  }

  @override
  String pricePerKg(String price) {
    return '$price/kg';
  }

  @override
  String get archiveFilamentConfirm =>
      'Arquivar este filamento? Ele some da lista, mas o histórico continua igual.';

  @override
  String get pickColor => 'Escolher cor';

  @override
  String get noColor => 'Sem cor';

  @override
  String get newPrinter => 'Nova impressora';

  @override
  String get editPrinter => 'Editar impressora';

  @override
  String get noPrinters =>
      'Nenhuma impressora cadastrada. Toque em + para cadastrar.';

  @override
  String get printerName => 'Nome';

  @override
  String get printerPower => 'Consumo médio (W)';

  @override
  String get printerValue => 'Valor da máquina';

  @override
  String get printerLifespan => 'Vida útil estimada (horas)';

  @override
  String get printerMaintenance => 'Manutenção por hora (opcional)';

  @override
  String get helpPrinterName =>
      'Um nome para reconhecer a impressora. Ex.: A1 da sala.';

  @override
  String get helpPower =>
      'Consumo médio enquanto imprime. Valores aproximados em PLA: A1 mini ~ 80 W, A1 ~ 95 W, P1S ~ 110 W, X1C ~ 140 W. Se tiver uma tomada medidora, use o valor medido.';

  @override
  String get helpMachineValue =>
      'Quanto você pagou na impressora. Serve para calcular o desgaste.';

  @override
  String get helpLifespan =>
      'Quantas horas de impressão você espera que ela dure. 5000 h é um chute razoável.';

  @override
  String get helpMaintenance =>
      'Gasto médio com bicos, correias, graxa... por hora de impressão. Pode deixar 0.';

  @override
  String wearPerHour(String value) {
    return '$value/h de desgaste';
  }

  @override
  String get archivePrinterConfirm =>
      'Arquivar esta impressora? O histórico continua igual.';

  @override
  String get sectionCosts => 'Custos';

  @override
  String get sectionPricing => 'Preço';

  @override
  String get sectionAppearance => 'Aparência e idioma';

  @override
  String get sectionShop => 'Sua loja (aparece no PDF)';

  @override
  String get sectionModules => 'Recursos extras';

  @override
  String get settingsKwh => 'Preço do kWh';

  @override
  String get settingsLaborHour => 'Valor da sua hora de trabalho';

  @override
  String get settingsMarketplace => 'Taxa do marketplace (%)';

  @override
  String get settingsTax => 'Impostos (%)';

  @override
  String get settingsMargin => 'Margem de lucro padrão (%)';

  @override
  String get settingsPackaging => 'Embalagem por peça';

  @override
  String get settingsWaste => 'Desperdício/purga padrão (%)';

  @override
  String get settingsFailure => 'Taxa de falha padrão (%)';

  @override
  String get settingsRounding => 'Arredondamento do preço';

  @override
  String get settingsCurrency => 'Moeda';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get languageSystem => 'Do aparelho';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get themeSystem => 'Automático';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get shopName => 'Nome da loja';

  @override
  String get shopContact => 'Contato (WhatsApp, Instagram...)';

  @override
  String get shopLogo => 'Logo';

  @override
  String get chooseLogo => 'Escolher logo';

  @override
  String get removeLogo => 'Remover logo';

  @override
  String get printerModuleTitle => 'Acompanhar impressora na rede (beta)';

  @override
  String get printerModuleSubtitle =>
      'Mostra o andamento da impressão de uma impressora na mesma rede Wi-Fi. Desligado por padrão.';

  @override
  String get settingsSaved => 'Configurações salvas';

  @override
  String get helpKwh =>
      'Valor da conta de luz dividido pelos kWh consumidos (está na fatura). Use 4 casas se quiser, ex.: 0,8950.';

  @override
  String get helpLabor =>
      'Quanto vale uma hora do seu trabalho manual (tirar suporte, lixar, pintar, embalar).';

  @override
  String get helpPackaging =>
      'Caixa, saquinho, etiqueta, brinde... por peça vendida.';

  @override
  String get helpMarketplace =>
      'Comissão da plataforma de venda (Shopee, Mercado Livre, Elo7...). Use 0 se você vende direto.';

  @override
  String get helpTax =>
      'Impostos sobre a venda (ex.: Simples Nacional). Use 0 se não se aplica.';

  @override
  String get helpMargin =>
      'Quanto do preço final fica com você como lucro, depois de pagar custos, taxas e impostos. 30% é um bom começo.';

  @override
  String get helpWaste =>
      'Filamento perdido em purga (troca de cor no AMS), testes e sobras. 5% para uma cor; com muitas cores, use mais.';

  @override
  String get helpFailure =>
      'Reserva para impressões que dão errado. Se 1 em cada 20 falha, use 5%.';

  @override
  String get helpRounding =>
      'Arredonda o preço sempre para cima, para ficar com cara de preço de loja.';

  @override
  String get helpCurrency =>
      'Moeda usada para mostrar os valores. Não converte valores já cadastrados.';

  @override
  String get roundingNone => 'Sem arredondar';

  @override
  String get rounding90 => 'Terminar em ,90';

  @override
  String get rounding99 => 'Terminar em ,99';

  @override
  String get roundingHalf => 'Múltiplo de 0,50';

  @override
  String get roundingWhole => 'Valor inteiro';

  @override
  String get calcFilamentsSection => 'Filamento usado';

  @override
  String get calcAddFilament => 'Adicionar outro filamento';

  @override
  String get calcSelectFilament => 'Filamento';

  @override
  String get calcGrams => 'Gramas';

  @override
  String get calcPrinterSection => 'Impressão';

  @override
  String get calcPrinter => 'Impressora';

  @override
  String get calcNoPrinter => 'Nenhuma impressora';

  @override
  String get calcHours => 'Horas';

  @override
  String get calcMinutes => 'Minutos';

  @override
  String get calcPostProcess => 'Pós-processamento por peça (min)';

  @override
  String get calcPercentsSection => 'Venda e margem';

  @override
  String get calcWaste => 'Desperdício/purga (%)';

  @override
  String get calcFailure => 'Taxa de falha (%)';

  @override
  String get calcMargin => 'Margem de lucro (%)';

  @override
  String get calcAdvanced => 'Custos desta peça';

  @override
  String get calcAdvancedSubtitle =>
      'Vêm das Configurações. Altere aqui só para esta peça.';

  @override
  String get calcResultPrice => 'Preço sugerido';

  @override
  String get calcResultCost => 'Custo total';

  @override
  String get calcResultProfit => 'Lucro líquido';

  @override
  String calcPriceBeforeRounding(String price) {
    return 'Sem arredondar: $price';
  }

  @override
  String profitPercentOfPrice(String percent) {
    return '$percent do preço';
  }

  @override
  String get calcBreakdown => 'Para onde vai o dinheiro';

  @override
  String get breakdownMaterial => 'Material';

  @override
  String get breakdownEnergy => 'Energia';

  @override
  String get breakdownWear => 'Desgaste da máquina';

  @override
  String get breakdownLabor => 'Mão de obra';

  @override
  String get breakdownPackaging => 'Embalagem';

  @override
  String get breakdownFailure => 'Reserva para falhas';

  @override
  String get breakdownFees => 'Taxas do canal';

  @override
  String get breakdownTaxes => 'Impostos';

  @override
  String get breakdownProfit => 'Seu lucro';

  @override
  String get calcSave => 'Salvar peça';

  @override
  String get calcUpdate => 'Atualizar peça';

  @override
  String get calcClear => 'Limpar';

  @override
  String calcEditing(String name) {
    return 'Editando: $name';
  }

  @override
  String get calcImport3mf => 'Importar do arquivo (.3mf)';

  @override
  String get calcNeedFilament =>
      'Cadastre pelo menos um filamento para calcular.';

  @override
  String get calcGoToFilaments => 'Cadastrar filamento';

  @override
  String get calcFillToSee =>
      'Preencha o filamento e o tempo para ver o preço.';

  @override
  String get helpGrams =>
      'Quantos gramas desse filamento a peça usa. O fatiador (Bambu Studio, Orca...) mostra depois de fatiar. Ou use \"Importar do arquivo\".';

  @override
  String get helpPrinterField =>
      'Impressora usada. Define o gasto de energia e o desgaste por hora. Sem impressora, energia e desgaste ficam fora do preço.';

  @override
  String get helpPrintTime =>
      'Tempo estimado de impressão mostrado pelo fatiador.';

  @override
  String get helpPostProcess =>
      'Seu tempo removendo suporte, lixando, pintando, montando e embalando esta peça.';

  @override
  String errDeductionsTooHigh(String total) {
    return 'Margem + taxas + impostos somam $total. Essa soma precisa ficar abaixo de 100%, senão nenhum preço cobre os descontos. Diminua a margem ou as taxas.';
  }

  @override
  String get errNegative => 'Algum valor está negativo. Confira os campos.';

  @override
  String get errRollWeight =>
      'Um filamento está com peso do rolo zerado. Corrija no cadastro do filamento.';

  @override
  String get saveJobTitle => 'Salvar peça';

  @override
  String get jobName => 'Nome da peça';

  @override
  String get jobCustomer => 'Cliente (opcional)';

  @override
  String get jobQuantity => 'Quantidade';

  @override
  String get jobStatus => 'Status';

  @override
  String get jobNotes => 'Observações (opcional)';

  @override
  String get jobPhoto => 'Foto (opcional)';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get pickPhoto => 'Galeria';

  @override
  String get removePhoto => 'Remover foto';

  @override
  String get jobSaved => 'Peça salva no histórico';

  @override
  String get statusQuote => 'Orçamento';

  @override
  String get statusInProduction => 'Em produção';

  @override
  String get statusDelivered => 'Entregue';

  @override
  String get historyEmpty =>
      'Nenhuma peça salva ainda. Calcule um preço e toque em \"Salvar peça\".';

  @override
  String get historySearch => 'Buscar por nome ou cliente';

  @override
  String get filterAll => 'Todos';

  @override
  String get markPrinted => 'Marcar como impressa';

  @override
  String get printedBadge => 'Impressa';

  @override
  String get stockUpdated => 'Estoque de filamento atualizado';

  @override
  String get stockAlreadyDeducted => 'O estoque desta peça já foi descontado.';

  @override
  String lowStockWarning(String name, String grams) {
    return '$name está acabando: restam $grams.';
  }

  @override
  String insufficientStockWarning(String name) {
    return '$name: o estoque cadastrado não era suficiente e ficou zerado. Confira o rolo.';
  }

  @override
  String get jobDetails => 'Detalhes da peça';

  @override
  String get openInCalculator => 'Abrir na calculadora';

  @override
  String get deleteJobConfirm =>
      'Excluir esta peça do histórico? O estoque não é devolvido.';

  @override
  String get unitPrice => 'Preço unitário';

  @override
  String get unitCost => 'Custo unitário';

  @override
  String get unitProfit => 'Lucro unitário';

  @override
  String get totalLabel => 'Total';

  @override
  String quantityUnits(int count) {
    return '$count un.';
  }

  @override
  String printedOn(String date) {
    return 'Impressa em $date';
  }

  @override
  String createdOn(String date) {
    return 'Criada em $date';
  }

  @override
  String get printTimeLabel => 'Tempo de impressão';

  @override
  String get sourceFileLabel => 'Arquivo';

  @override
  String get generatePdf => 'Orçamento em PDF';

  @override
  String get selectForQuote => 'Selecionar peças para o orçamento';

  @override
  String quoteSelectedCount(int count) {
    return '$count selecionadas';
  }

  @override
  String get createQuote => 'Gerar PDF';

  @override
  String get pdfCustomerPrompt => 'Nome do cliente no orçamento';

  @override
  String get pdfQuoteTitle => 'Orçamento';

  @override
  String get pdfItem => 'Item';

  @override
  String get pdfQty => 'Qtd.';

  @override
  String get pdfUnit => 'Unitário';

  @override
  String get pdfSubtotal => 'Subtotal';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfCustomer => 'Cliente';

  @override
  String get pdfDate => 'Data';

  @override
  String get pdfValidity => 'Orçamento válido por 7 dias.';

  @override
  String get dashboardEmpty =>
      'Os números aparecem aqui quando você tiver peças em produção ou entregues.';

  @override
  String get dashProfitByMonth => 'Lucro por mês';

  @override
  String get dashRevenue => 'Faturamento';

  @override
  String get dashProfit => 'Lucro';

  @override
  String get dashAvgMargin => 'Margem média';

  @override
  String get dashJobsSold => 'Peças produzidas';

  @override
  String get dashTopJobs => 'Peças mais lucrativas';

  @override
  String get dashFilamentUsage => 'Filamento mais usado';

  @override
  String get dashNote =>
      'Conta peças em produção e entregues. Orçamentos ficam de fora.';

  @override
  String get backupExport => 'Exportar backup';

  @override
  String get backupExportHelp =>
      'Gera um arquivo com todos os seus dados. Guarde no Google Drive, e-mail ou computador.';

  @override
  String get backupImport => 'Restaurar backup';

  @override
  String get backupImportHelp =>
      'Substitui os dados atuais pelos de um arquivo de backup.';

  @override
  String get backupImportWarning =>
      'Isso substitui TODOS os dados atuais pelos do arquivo. Faça um backup antes, se precisar. Continuar?';

  @override
  String get backupSaved => 'Backup salvo';

  @override
  String get backupRestored => 'Backup restaurado';

  @override
  String get backupInvalidFile =>
      'Esse arquivo não parece ser um backup do PrintCost.';

  @override
  String get backupNewerVersion =>
      'Esse backup foi feito numa versão mais nova do app. Atualize o app antes de restaurar.';

  @override
  String get backupPhotosNote =>
      'Fotos das peças não vão no backup, só os dados.';

  @override
  String get backupShare => 'Compartilhar';

  @override
  String get backupSaveToFile => 'Salvar em arquivo';

  @override
  String get restore => 'Restaurar';

  @override
  String get about => 'Sobre';

  @override
  String get aboutText =>
      'PrintCost é uma calculadora offline: seus dados ficam só no aparelho. Compatível com arquivos do Bambu Studio e impressoras Bambu Lab no modo LAN. Este app não é afiliado, patrocinado ou endossado pela Bambu Lab.';

  @override
  String get importPickPlate => 'Qual placa você quer importar?';

  @override
  String plateLabel(int index) {
    return 'Placa $index';
  }

  @override
  String get importSummaryTitle => 'Dados encontrados no arquivo';

  @override
  String importTime(String time) {
    return 'Tempo de impressão: $time';
  }

  @override
  String importFilamentLine(String name, String weight) {
    return '$name: $weight';
  }

  @override
  String get importMissingTime =>
      'O arquivo não informa o tempo de impressão. Preencha manualmente.';

  @override
  String importOnlyTotalWeight(String weight) {
    return 'O arquivo só traz o peso total ($weight), sem separar por filamento. Ele entrou como um filamento só; ajuste se precisar.';
  }

  @override
  String get importMissingWeight =>
      'O arquivo não informa o peso do filamento. Preencha manualmente.';

  @override
  String get importUnmatched =>
      'Alguns filamentos do arquivo não têm cadastro do mesmo tipo. Escolha o filamento certo na calculadora.';

  @override
  String get importErrNotA3mf => 'Esse arquivo não é um .3mf válido.';

  @override
  String get importErrNoSliceInfo =>
      'Esse .3mf não tem dados de fatiamento (peso e tempo). No Bambu Studio, fatie a placa e salve o projeto, ou use \"Exportar arquivo fatiado da placa\". Você também pode preencher os campos à mão.';

  @override
  String get importErrNoPlates =>
      'O arquivo abriu, mas nenhuma placa tem peso ou tempo. Fatie de novo e salve, ou preencha à mão.';

  @override
  String get importErrWrongExtension =>
      'Escolha um arquivo .3mf (projeto do Bambu Studio ou .gcode.3mf).';

  @override
  String get importApply => 'Usar estes dados';

  @override
  String get pmTitle => 'Impressora na rede';

  @override
  String get pmSubtitle => 'Acompanhe a impressão em tempo real';

  @override
  String get pmEmpty =>
      'Nenhuma impressora conectada ainda. Toque em + para configurar (leva uns 3 minutos).';

  @override
  String get pmAdd => 'Conectar impressora';

  @override
  String get pmDeleteConfirm =>
      'Remover esta conexão? O código de acesso salvo no aparelho também é apagado.';

  @override
  String get pmRemoteTitle => 'Acompanhar fora de casa';

  @override
  String get pmRemoteText =>
      'Use uma VPN como Tailscale ou NetBird no celular e em um computador ou roteador da sua casa: é grátis para uso pessoal e o celular passa a \"enxergar\" a impressora como se estivesse no Wi-Fi. Nunca abra a porta da impressora (8883) na internet com redirecionamento de portas no roteador: qualquer pessoa poderia tentar acessá-la.';

  @override
  String get pmState_idle => 'Ociosa';

  @override
  String get pmState_preparing => 'Preparando';

  @override
  String get pmState_printing => 'Imprimindo';

  @override
  String get pmState_paused => 'Pausada';

  @override
  String get pmState_finished => 'Concluída';

  @override
  String get pmState_failed => 'Falhou';

  @override
  String get pmState_unknown => 'Aguardando status…';

  @override
  String get pmConnecting => 'Conectando…';

  @override
  String get pmConnected => 'Conectada';

  @override
  String get pmDisconnected => 'Desconectada';

  @override
  String get pmReconnect => 'Tentar de novo';

  @override
  String pmRemaining(String time) {
    return 'Faltam $time';
  }

  @override
  String pmFile(String name) {
    return 'Arquivo: $name';
  }

  @override
  String pmErrorCode(String code) {
    return 'Código de erro da impressora: $code';
  }

  @override
  String get pmRegisterPrint => 'Registrar esta impressão';

  @override
  String get pmRegisterText =>
      'Para pegar o peso de cada filamento, escolha o arquivo .3mf desta impressão (o mesmo que você mandou imprimir). Ou siga só com o tempo e preencha o peso na calculadora.';

  @override
  String get pmRegisterNoFetch =>
      'Baixar o arquivo direto da impressora ainda não é suportado.';

  @override
  String get pmChoose3mf => 'Escolher .3mf';

  @override
  String get pmOnlyTime => 'Só o tempo';

  @override
  String get pmDebugTitle => 'Mensagens recebidas (debug)';

  @override
  String get pmDebugHelp =>
      'Últimas mensagens cruas enviadas pela impressora. Use para conferir os nomes dos campos se algo aparecer errado. O código de acesso nunca aparece aqui.';

  @override
  String get pmDebugEmpty => 'Nenhuma mensagem ainda.';

  @override
  String get pmCopy => 'Copiar';

  @override
  String get pmCopied => 'Copiado';

  @override
  String get pmMergedState => 'Estado mesclado atual';

  @override
  String get pmNotifyFinished => 'Impressão concluída';

  @override
  String get pmNotifyFailed => 'A impressão falhou';

  @override
  String get pmNotifyChannel => 'Status da impressora';

  @override
  String get pmForegroundNote =>
      'Os avisos de fim de impressão funcionam enquanto o app está aberto ou em segundo plano recente. Se o sistema fechar o app, abra-o de novo para reconectar.';

  @override
  String get wzTitle => 'Conectar impressora';

  @override
  String wzStep(int step) {
    return 'Passo $step de 4';
  }

  @override
  String get wz1Title => 'Ative o modo LAN';

  @override
  String get wz1Text =>
      'Na tela da impressora, abra Configurações (engrenagem) → WLAN/Rede e ligue \"Modo somente LAN\" (LAN Only Mode). Assim ela conversa direto com o celular pela sua rede Wi-Fi, sem passar pela nuvem.\n\nEnquanto o modo LAN estiver ligado, o app oficial e a impressão pela nuvem não funcionam.';

  @override
  String get wz2Title => 'Ative o Developer Mode';

  @override
  String get wz2Text =>
      'Em firmwares recentes (e nos modelos H2) também é preciso ligar o \"Modo desenvolvedor\" (Developer Mode), que fica na mesma tela do modo LAN.\n\nAtenção: é um modo sem suporte oficial da fabricante. Ele libera o acesso local para programas de terceiros como este. O PrintCost só lê o status: nunca envia comandos para a impressora.';

  @override
  String get wz3Title => 'Dados da impressora';

  @override
  String get wz3Text =>
      'Na tela de rede da impressora aparecem o IP e o código de acesso (8 caracteres). O número de série fica em Configurações → Dispositivo (ou na etiqueta atrás da impressora).';

  @override
  String get wz4Title => 'Testar conexão';

  @override
  String get wz4Text => 'O celular precisa estar no mesmo Wi-Fi da impressora.';

  @override
  String get wzName => 'Nome';

  @override
  String get wzIp => 'Endereço IP';

  @override
  String get wzSerial => 'Número de série';

  @override
  String get wzCode => 'Código de acesso';

  @override
  String get wzLinkedPrinter => 'Impressora cadastrada (para os custos)';

  @override
  String get wzLinkedNone => 'Nenhuma';

  @override
  String get wzHelpIp =>
      'Aparece na tela de rede da impressora. Ex.: 192.168.0.50. Dica: reserve esse IP no roteador para ele não mudar.';

  @override
  String get wzHelpCode =>
      '8 caracteres, na tela do modo LAN. Muda toda vez que você desliga e liga o modo LAN. Fica guardado só neste aparelho, de forma protegida, e não vai no backup.';

  @override
  String get wzHelpSerial =>
      'Em Configurações → Dispositivo, ou na etiqueta. Pode digitar com ou sem traços.';

  @override
  String get wzInvalidIp => 'Use o formato 192.168.0.50';

  @override
  String get wzInvalidCode => 'O código tem 8 caracteres';

  @override
  String get wzTest => 'Testar conexão';

  @override
  String get wzTesting => 'Testando…';

  @override
  String wzSuccess(String state) {
    return 'Conectado! A impressora está: $state';
  }

  @override
  String get wzSave => 'Salvar e acompanhar';

  @override
  String get wzShowCode => 'Mostrar código';

  @override
  String errUnreachable(String ip) {
    return 'Não encontrei a impressora em $ip. Confira: o IP está certo? O celular está no mesmo Wi-Fi (não no 4G/5G nem na rede de convidados)? A impressora está ligada e com o modo LAN ativo?';
  }

  @override
  String get errRejected =>
      'A impressora recusou a conexão. Confira o código de acesso: ele muda sempre que o modo LAN é desligado e ligado de novo. Em firmwares recentes, confira também se o Developer Mode está ligado.';

  @override
  String get errNoReports =>
      'Conectou, mas a impressora não enviou o status. Isso costuma acontecer com o Developer Mode desligado ou com o número de série errado.';

  @override
  String get errCertChanged =>
      'O certificado de segurança da impressora mudou desde a última conexão. Se você trocou ou resetou a impressora, remova a conexão e cadastre de novo. Se não, pode haver outro aparelho se passando pela impressora na rede.';

  @override
  String get errInvalidConfig =>
      'Confira os campos: o IP deve estar no formato 192.168.0.50 e o código tem 8 caracteres.';

  @override
  String errUnknownPrinter(String detail) {
    return 'Não foi possível conectar. $detail';
  }

  @override
  String get calcUnits => 'Peças nesta impressão';

  @override
  String get helpUnits =>
      'Quantas peças saem juntas na mesma mesa. Gramas e tempo são da impressão inteira (como o fatiador mostra); o app divide entre as peças. Pós-processamento, embalagem e taxas são por peça.';

  @override
  String get calcChannel => 'Onde vai vender';

  @override
  String get helpChannel =>
      'Cada canal cobra taxas diferentes, e elas entram no preço. Ajuste as taxas em Mais → Canais de venda.';

  @override
  String calcChannelFee(String fee) {
    return 'Taxa do canal neste preço: $fee';
  }

  @override
  String calcBatchTotal(int count, String price) {
    return 'Total das $count peças: $price';
  }

  @override
  String get calcPricePerPart => 'Preço sugerido por peça';

  @override
  String get calcOtherChannels => 'Mesma margem em outros canais';

  @override
  String calcOtherChannelProfit(String profit) {
    return 'lucro $profit';
  }

  @override
  String get calcSeeDetails => 'Ver detalhes';

  @override
  String get calcFixRequired => 'Preencha os campos marcados';

  @override
  String get channels => 'Canais de venda';

  @override
  String get channelNew => 'Novo canal';

  @override
  String get channelEdit => 'Editar canal';

  @override
  String get channelName => 'Nome do canal';

  @override
  String get helpChannelName =>
      'Ex.: Shopee, Mercado Livre, Elo7, Instagram, feira.';

  @override
  String get channelExampleWarning =>
      'Estas são taxas de exemplo (out/2026), tiradas de guias para vendedores, e podem estar desatualizadas. Elas mudam com a categoria e o tipo de conta. Para usar a sua taxa real:\n1. Toque em \"Ver tarifas oficiais\" ou abra o seu painel de vendedor.\n2. Ache a comissão (%) e o valor fixo por venda da sua categoria.\n3. Corrija as faixas abaixo e toque em Salvar. O aviso some depois de salvar.';

  @override
  String get channelTiers => 'Taxas por faixa de preço';

  @override
  String get helpChannelTiers =>
      'Alguns marketplaces cobram taxas diferentes conforme o preço da peça. Ex.: até R\$ 79,99, 20% + R\$ 4,50; a partir de R\$ 80, 14% + R\$ 16. Se o canal cobra sempre igual, deixe uma faixa só. Cobranças extras entram na própria faixa: some ao percentual ou ao fixo.';

  @override
  String get channelTierFrom => 'A partir de';

  @override
  String get channelTierPercent => 'Comissão';

  @override
  String get channelTierFixed => 'Fixo por venda';

  @override
  String get helpChannelPercent =>
      'Parte do preço de venda que o canal fica para si. Se você participa de algum programa com taxa extra em % sobre a venda, some aqui. Ex.: comissão de 14% + programa de 6% = 20.';

  @override
  String get helpChannelFixed =>
      'Valor cobrado a cada peça vendida, além da comissão. Se o marketplace cobra extras por item, some aqui. Ex.: fixo de R\$ 4,50 + adicional de R\$ 3,00 para conta CPF = 7,50.';

  @override
  String get channelOfficialFees => 'Ver tarifas oficiais';

  @override
  String get channelInfoUrl => 'Link das tarifas (opcional)';

  @override
  String get helpChannelInfoUrl =>
      'Página onde o canal publica as taxas atuais. Fica salva aqui para você conferir quando elas mudarem.';

  @override
  String get channelInfoUrlInvalid => 'Use um link que comece com https://';

  @override
  String get openLinkFailed => 'Não foi possível abrir o link';

  @override
  String get calcExampleFees =>
      'Taxas de exemplo neste canal. Toque para conferir.';

  @override
  String get channelAddTier => 'Adicionar faixa';

  @override
  String channelTierSummary(String price, String fee) {
    return 'a partir de $price: $fee';
  }

  @override
  String get channelNoFees => 'Sem taxas';

  @override
  String get channelExampleBadge => 'taxas de exemplo';

  @override
  String get channelDuplicateMin => 'Duas faixas com o mesmo valor inicial';

  @override
  String get settingsDefaultChannel => 'Canal padrão';

  @override
  String get helpDefaultChannel => 'Canal que já vem escolhido na calculadora.';

  @override
  String get obWelcomeTitle => 'Vamos configurar o básico';

  @override
  String obStep(int n, int total) {
    return 'Passo $n de $total';
  }

  @override
  String get obCostsTitle => 'Seus custos';

  @override
  String get obCostsText =>
      'Esses valores entram em todo cálculo. Se não souber algum, deixe como está e ajuste depois em Configurações.';

  @override
  String get obFilamentTitle => 'Seu primeiro filamento';

  @override
  String get obFilamentText =>
      'Cadastre o filamento que você mais usa. Os outros podem ser cadastrados depois.';

  @override
  String get obPrinterTitle => 'Sua impressora';

  @override
  String get obPrinterText =>
      'Com a impressora cadastrada, o preço inclui a energia e o desgaste da máquina. Se preferir, pule este passo.';

  @override
  String get obChannelTitle => 'Onde você vende';

  @override
  String get obChannelText =>
      'As taxas do canal entram no preço sugerido. Dá para trocar a cada cálculo.';

  @override
  String get obSkip => 'Pular';

  @override
  String get obFinish => 'Começar a calcular';

  @override
  String get obPrinterNameHint => 'Ex.: Minha impressora';

  @override
  String get historyExportCsv => 'Exportar planilha (CSV)';

  @override
  String get historyExportEmpty => 'Nada para exportar ainda';

  @override
  String get csvDate => 'Data';

  @override
  String get csvName => 'Peça';

  @override
  String get csvCustomer => 'Cliente';

  @override
  String get csvStatus => 'Status';

  @override
  String get csvQuantity => 'Quantidade';

  @override
  String get csvChannel => 'Canal';

  @override
  String get csvUnitPrice => 'Preço unitário';

  @override
  String get csvUnitCost => 'Custo unitário';

  @override
  String get csvUnitProfit => 'Lucro unitário';

  @override
  String get csvTotalPrice => 'Total';

  @override
  String get csvTotalProfit => 'Lucro total';

  @override
  String get csvFilamentGrams => 'Filamento total (g)';

  @override
  String get csvFileName => 'pecas';

  @override
  String get archiveChannelConfirm =>
      'Arquivar este canal? Peças já salvas continuam com as taxas usadas.';

  @override
  String get channelKeepOne => 'Mantenha pelo menos um canal.';
}

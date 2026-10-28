# PrintCost

Calculadora de custo e precificação para impressão 3D. **100% offline**: sem
conta, sem servidor — os dados ficam só no aparelho (SQLite). UI em português
(pt-BR) e inglês, Material 3, tema claro/escuro, moeda padrão BRL
(configurável).

> Compatível com arquivos do Bambu Studio e com impressoras Bambu Lab no modo
> LAN. **Este app não é afiliado, patrocinado ou endossado pela Bambu Lab.**

## Funcionalidades

- **Cadastros**: filamentos (marca, tipo, cor, preço e peso do rolo, estoque,
  alerta de estoque baixo), impressoras (consumo, valor, vida útil,
  manutenção/h) e configurações globais (kWh, hora de trabalho, taxas,
  impostos, margem, embalagem, arredondamento, dados da loja).
- **Calculadora** com vários filamentos por peça (AMS), detalhamento do custo
  em gráfico, lucro líquido em R$ e %, arredondamento (,90 / ,99 / 0,50 /
  inteiro) e erro claro quando margem + taxas + impostos ≥ 100%.
- **Importar do arquivo (.3mf)**: lê peso por filamento e tempo de
  `Metadata/slice_info.config` (Bambu Studio / compatíveis). Funciona sem
  impressora.
- **Histórico**: nome, foto, cliente, status (orçamento / em produção /
  entregue), custo e preço. "Marcar como impressa" desconta o estoque (com a
  % de desperdício) uma única vez e avisa quando o rolo está acabando.
- **Orçamento em PDF** com logo e nome da loja, para compartilhar.
- **Painel**: lucro por mês, faturamento, margem média, peças mais lucrativas,
  filamento mais usado.
- **Backup/restauração** manual do banco (arquivo `.sqlite`).
- **Módulo opcional de impressora** (desligado por padrão): acompanha uma
  impressora Bambu Lab na rede local (somente leitura).

## Como rodar

Requisitos: Flutter **3.47.8** (stable; fixado em `mise.toml`) e Android SDK
(ou Xcode para iOS).

```bash
flutter pub get
flutter run                   # com um celular/emulador conectado
flutter analyze               # lints estritos
flutter test                  # unitários, widget e migração
```

Código gerado (já está no repositório; rode de novo se mudar tabelas ou
textos):

```bash
dart run build_runner build --delete-conflicting-outputs  # drift
python3 tool/gen_arb.py && flutter gen-l10n               # textos pt/en
```

Os textos ficam em `tool/strings*.py` (uma tabela pt/en) e viram
`lib/l10n/app_pt.arb` e `app_en.arb`.

### Gerar o APK

```bash
flutter build apk --release            # APK universal
flutter build apk --release --split-per-abi   # APKs menores por arquitetura
```

Saída: `build/app/outputs/flutter-apk/`. O build de release está assinado com
a chave de debug (padrão do `flutter create`); para publicar na loja,
configure sua própria chave em `android/app/build.gradle.kts`.

## Arquitetura

```
lib/
  core/          aritmética exata (Ratio/BigInt) e parsing de números
  domain/        regras puras, sem Flutter nem banco:
    pricing/     calculatePrice() e arredondamento
    stock/       desconto de estoque
    stats/       números do painel
    slicer/      modelos do .3mf e casamento de filamentos
    printer/     PrinterAdapter, estados, mesclagem de relatórios MQTT
  data/          drift (SQLite + migrations), repositórios, backup, PDF,
                 parser do .3mf, BambuLanAdapter, secure storage
  presentation/  telas (Riverpod + go_router)
```

- **Dinheiro nunca é `double`**: valores em centavos (`int`), porcentagens em
  pontos-base (1% = 100), peso em mg, preço do kWh com 4 casas. Cada
  componente é calculado de forma exata (`Ratio` com `BigInt`) e arredondado
  uma única vez, então o detalhamento sempre fecha com o total.
- **Migrations**: `drift_schemas/` guarda o schema de cada versão;
  `test/drift/` testa a migração v1→v2 (schema e integridade de dados).
  Para uma nova versão: altere as tabelas, aumente `schemaVersion`, rode
  `dart run drift_dev make-migrations` e implemente o passo em `stepByStep`.

### Fórmulas

| Item | Fórmula |
|---|---|
| Material | Σ(gramas × preço por grama) × (1 + % desperdício/purga) |
| Energia | (W / 1000) × horas × preço do kWh |
| Desgaste | (valor da máquina / vida útil h + manutenção/h) × horas |
| Mão de obra | minutos de pós-processamento × valor da hora / 60 |
| Subtotal | material + energia + desgaste + mão de obra + embalagem |
| Custo | subtotal × (1 + % de falha) |
| Preço | custo / (1 − margem − taxa do marketplace − impostos) |
| Lucro líquido | preço − custo − taxa − impostos |

### Exemplo conferido à mão (está nos testes)

Rolo R$ 120 / 1000 g, peça de 50 g, 10% de purga; impressora 150 W, 4 h,
kWh R$ 0,90; máquina R$ 5.000 / 5.000 h + R$ 0,20/h; 15 min de
pós-processamento a R$ 30/h; embalagem R$ 2; falha 5%; margem 30%,
marketplace 12%, impostos 6%.

- material 50 × 0,12 × 1,10 = **6,60**; energia 0,15 × 4 × 0,90 = **0,54**;
  desgaste 1,20 × 4 = **4,80**; mão de obra **7,50**; embalagem **2,00**
- subtotal **21,44** → custo 21,44 × 1,05 = 22,512 → **R$ 22,51**
- preço 22,51 / 0,52 = 43,288 → **R$ 43,29**; arredondado em ,90 → **R$ 43,90**
- taxa 5,27 + impostos 2,63 → lucro **R$ 13,49** (30,73% do preço)

## Importar do arquivo (.3mf)

No Bambu Studio, **fatie** a placa e então salve o projeto, ou use
"Exportar arquivo fatiado da placa" (`.gcode.3mf`). Na calculadora, toque em
**Importar do arquivo (.3mf)**. O app lê de `Metadata/slice_info.config`:

- `<metadata key="prediction">` → tempo (segundos)
- `<filament type color used_g>` → peso por filamento
- `<metadata key="weight">` → peso total (usado se não houver peso por
  filamento)
- nome da placa em `Metadata/model_settings.config` (opcional)

Cada filamento do arquivo é ligado automaticamente a um filamento cadastrado
do mesmo tipo e cor mais próxima; se não houver do mesmo tipo, você escolhe na
calculadora. Arquivo não fatiado, sem tempo ou sem peso → mensagem clara e
preenchimento manual.

**Validação com arquivo real:** os testes usam arquivos de exemplo gerados por
`tool/make_3mf_fixtures.py`, que imitam o formato do Bambu Studio. Coloque
arquivos reais em `test/fixtures/real/` e rode `flutter test` — cada arquivo é
conferido (peso e tempo encontrados em todas as placas).

## Módulo de impressora (opcional)

Ative em **Configurações → Recursos extras → Acompanhar impressora na rede**.
Aparece então **Mais → Impressora na rede**, com um passo a passo:

1. **Modo LAN** na impressora (Configurações → WLAN → LAN Only Mode).
2. **Developer Mode** — necessário em firmwares recentes e nos modelos H2. É
   um modo **sem suporte oficial da fabricante**; libera acesso local para
   programas de terceiros. O PrintCost só lê o status; nunca envia comandos.
3. **IP, número de série e código de acesso** (8 caracteres) — na tela de rede
   da impressora. O código muda sempre que o modo LAN é desligado e ligado.
4. **Testar conexão** — com o celular no **mesmo Wi-Fi**.

Mostra: ociosa, imprimindo (% e tempo restante), pausada, concluída, falhou;
notificação local quando termina ou falha (com o app aberto ou em segundo
plano recente — não há serviço em background). Ao concluir, **Registrar esta
impressão** abre a calculadora com o tempo estimado, nome do arquivo e a
impressora; escolha o `.3mf` para trazer o peso de cada filamento.

Detalhes técnicos:

- MQTT sobre TLS, porta **8883**, usuário `bblp`, senha = código de acesso.
  Tópicos `device/{SERIAL}/report` e `device/{SERIAL}/request` (serial sem
  separadores). Ao conectar, publica `pushall` para receber o relatório
  completo; depois chegam diffs, mesclados recursivamente.
- O certificado da impressora é autoassinado: nenhuma raiz pública é aceita, a
  conexão só vai para o IP cadastrado e o certificado é **fixado na primeira
  conexão** (SHA-256). Se mudar, a conexão é recusada com aviso.
- O código de acesso fica **só no secure storage** (Keychain/Keystore) — não
  vai para o SQLite nem para o backup, e nunca é logado (o log da biblioteca
  MQTT fica desligado porque registraria o pacote CONNECT).
- **Campos lidos** de `print`: `gcode_state`, `mc_percent`,
  `mc_remaining_time` (minutos), `gcode_file`, `subtask_name`, `print_error`.
  Eles seguem a documentação pública da comunidade e **ainda precisam ser
  confirmados com uma impressora real**: abra o monitor → ícone de bug
  ("Mensagens recebidas") para ver/copiar as mensagens cruas e o estado
  mesclado. Em modo debug elas também vão para o log (`printcost.printer.raw`).
- **Baixar o .3mf pela impressora (FTPS, porta 990) não foi implementado**:
  o servidor da impressora usa FTPS implícito e costuma exigir reaproveitamento
  da sessão TLS no canal de dados, o que o `dart:io` não oferece. Por isso
  `supportsFileFetch` é `false` e o peso vem do import manual do `.3mf`.
- Novas marcas (ex.: Moonraker/Klipper) entram implementando
  `PrinterAdapter` (`lib/domain/printer/printer_adapter.dart`).

### Acompanhar fora de casa

Use uma VPN como **Tailscale** ou **NetBird** no celular e num computador ou
roteador da rede da impressora. **Nunca** exponha a porta da impressora
(8883) na internet com redirecionamento de portas.

### Permissões

- Android: `INTERNET` (necessária para qualquer socket, inclusive na rede
  local — só é usada pelo módulo de impressora) e `POST_NOTIFICATIONS`.
  Tráfego em texto puro desligado (`usesCleartextTraffic="false"`).
- iOS: `NSLocalNetworkUsageDescription`, câmera e fotos (foto da peça/logo).

## Backup

**Mais → Backup**: exporta um snapshot consistente do banco
(`VACUUM INTO`) para compartilhar ou salvar; a restauração confere se o
arquivo é um banco do PrintCost e se não é de uma versão mais nova, e roda as
migrations ao reabrir. Fotos e o código de acesso da impressora não entram no
backup.

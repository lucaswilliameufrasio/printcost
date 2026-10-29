# PrintCost

Calculadora de custo e precificação para impressão 3D. **100% offline**: sem
conta, sem servidor — os dados ficam só no aparelho (SQLite). UI em português
(pt-BR) e inglês, Material 3, tema claro/escuro, moeda padrão BRL
(configurável).

> Compatível com arquivos do Bambu Studio e com impressoras Bambu Lab no modo
> LAN. **Este app não é afiliado, patrocinado ou endossado pela Bambu Lab.**

## Funcionalidades

- **Configuração inicial** em 4 passos na primeira abertura: custos, primeiro
  filamento, impressora (pode pular) e canal de venda.
- **Cadastros**: filamentos (marca, tipo, cor, preço e peso do rolo, estoque,
  alerta de estoque baixo), impressoras (consumo, valor, vida útil,
  manutenção/h), canais de venda e configurações globais (kWh, hora de
  trabalho, impostos, margem, embalagem, arredondamento, dados da loja).
- **Canais de venda** (venda direta, Shopee, Mercado Livre...): comissão em %
  mais valor fixo por venda, com **faixas por preço**. Shopee e Mercado Livre
  vêm com taxas de exemplo (out/2026, de guias públicos para vendedores),
  marcadas como "exemplo" até você conferir e salvar. A calculadora avisa
  quando o canal escolhido ainda está com taxas de exemplo, e a tela do canal
  explica como conferir, com o botão "Ver tarifas oficiais" (links em
  `lib/data/db/seed_channels.dart`). Cada canal pode guardar o próprio link.
- **Calculadora** com vários filamentos por peça (AMS), **várias peças na
  mesma impressão**, detalhamento do custo em gráfico, lucro líquido em R$ e
  %, arredondamento (,90 / ,99 / 0,50 / inteiro), preço com a mesma margem
  nos outros canais, barra fixa com o preço e erro claro quando margem +
  taxas + impostos ≥ 100%.
- **Importar do arquivo (.3mf)**: lê peso por filamento e tempo de
  `Metadata/slice_info.config` (Bambu Studio / compatíveis). Funciona sem
  impressora.
- **Histórico**: nome, foto, cliente, status (orçamento / em produção /
  entregue), custo e preço. "Marcar como impressa" desconta o estoque (com a
  % de desperdício) uma única vez e avisa quando o rolo está acabando.
- **Orçamento em PDF** com logo e nome da loja, para compartilhar.
- **Planilha (CSV)** do histórico para o contador ou controle de vendas
  (separador `;` e vírgula decimal em pt-BR).
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

Ícone e tela de abertura (fontes em `assets/icon/`):

```bash
dart run flutter_launcher_icons && dart run flutter_native_splash:create
```

### Gerar o APK

```bash
flutter build apk --release            # APK universal
flutter build apk --release --split-per-abi   # APKs menores por arquitetura
```

Saída: `build/app/outputs/flutter-apk/`. Sem chave configurada, o build de
release é assinado com a chave de debug. Para assinar com a sua, crie
`android/key.properties` (fora do git):

```properties
storeFile=/caminho/para/chave.jks
storePassword=...
keyAlias=...
keyPassword=...
```

### Versões de teste (CI)

O workflow `.github/workflows/build.yml` roda `flutter analyze`, os testes e
gera o APK em todo pull request e push.

- **A cada push na `main`**, o pré-lançamento `dev` é atualizado. O link para
  baixar é sempre o mesmo:
  <https://github.com/lucaswilliameufrasio/printcost/releases/download/dev/printcost-dev.apk>.
  Ele fica marcado como pré-lançamento, nunca como "Latest".
- **Tags `v*`** (ex.: `v0.1.0`) publicam um pré-lançamento numerado com o APK.

Os APKs do CI são assinados com uma **chave fixa só para testes**, guardada
nos secrets do repositório (`ANDROID_TEST_KEYSTORE_BASE64`,
`ANDROID_TEST_KEYSTORE_PASSWORD`, `ANDROID_TEST_KEY_ALIAS`). Com ela, uma
versão nova instala por cima da anterior sem perder os dados. Ela não é a
chave da Play Store: o app da loja terá outra assinatura, e por isso não
instala por cima de uma versão de teste (é preciso desinstalar antes). Em
forks, sem os secrets, o CI usa a chave de debug.

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
  `test/drift/` testa as migrações v1→v2→v3 (schema e dados). A v3 transforma
  a antiga taxa única do marketplace em um canal e não mostra a configuração
  inicial para quem já usava o app.
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
| Preço | (custo + fixo do canal) / (1 − margem − comissão do canal − impostos) |
| Lucro líquido | preço − custo − comissão − fixo − impostos |

- **Faixas de preço do canal**: o app calcula o preço em cada faixa, sobe
  para o mínimo da faixa quando precisa, e fica com o menor preço que cabe
  na faixa. Depois do arredondamento, as taxas são as da faixa do preço
  final.
- **Várias peças na mesma impressão**: gramas e tempo são da impressão
  inteira; material, energia e desgaste são divididos entre as peças.
  Pós-processamento, embalagem e taxas são por peça. O resultado é por peça,
  com o total do lote. No histórico, o filamento fica guardado por peça, e o
  estoque desconta `peso × quantidade`.

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

## Pendências

Validações com arquivos e impressoras reais, limitações conhecidas e a
proposta de estação local + notificações push estão em
[docs/pendencias.md](docs/pendencias.md).

## Backup

**Mais → Backup**: exporta um snapshot consistente do banco
(`VACUUM INTO`) para compartilhar ou salvar; a restauração confere se o
arquivo é um banco do PrintCost e se não é de uma versão mais nova, e roda as
migrations ao reabrir. Fotos e o código de acesso da impressora não entram no
backup.

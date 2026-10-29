# Pendências e próximos passos

O que ainda falta validar, as limitações conhecidas da versão atual e uma
proposta para as que dependem de algo além do app.

## 1. Validações com dados reais

### 1.1 Parser do `.3mf`

- **Situação:** o parser (`lib/data/slicer/three_mf_parser.dart`) segue o
  formato conhecido do Bambu Studio (`Metadata/slice_info.config` e
  `Metadata/model_settings.config`), mas só foi testado com arquivos de
  exemplo gerados por `tool/make_3mf_fixtures.py`.
- **Como fechar:** coloque arquivos reais em `test/fixtures/real/`, um
  fatiado por placa e um projeto com várias placas e AMS, e rode
  `flutter test`. O teste que hoje fica pulado confere peso e tempo em
  todas as placas.
- **Também vale testar:** um `.gcode.3mf` exportado, um arquivo de outro
  fatiador compatível (OrcaSlicer) e um arquivo salvo antes de fatiar, que
  deve mostrar a mensagem "arquivo não fatiado".

### 1.2 Campos do relatório MQTT

- **Situação:** `gcode_state`, `mc_percent`, `mc_remaining_time`,
  `gcode_file`, `subtask_name` e `print_error` vêm da documentação da
  comunidade e ainda não foram conferidos numa impressora.
- **Como fechar:** ative o módulo, conecte uma impressora e abra o monitor →
  ícone de bug ("Mensagens recebidas"). Copie as mensagens cruas de uma
  impressão completa: início, pausa, fim e, se possível, uma falha. Com elas:
  - confirme os nomes dos campos e os valores de `gcode_state`
    (`IDLE`, `PREPARE`, `RUNNING`, `PAUSE`, `FINISH`, `FAILED`);
  - confirme que `mc_remaining_time` está em minutos;
  - transforme as mensagens em fixtures de `test/printer/` (sem serial real).
- **Modelos:** vale repetir numa série com firmware recente e Developer Mode,
  porque o formato pode variar entre modelos.

## 2. Limitações conhecidas

| Limitação | Motivo | Saída |
|---|---|---|
| Notificação de fim/falha só com o app aberto ou em segundo plano recente | O sistema encerra a conexão MQTT em segundo plano; não há serviço rodando | Seção 3 (estação local + push) ou serviço em primeiro plano no Android |
| Acompanhar fora de casa exige VPN (Tailscale/NetBird) | A impressora só fala na rede local e a porta 8883 nunca deve ir para a internet | Seção 3 |
| Peso do filamento não vem da impressora | O download por FTPS (porta 990) precisa reaproveitar a sessão TLS no canal de dados, e o `dart:io` não oferece isso | Seção 3 (a estação baixa e lê o `.3mf`) ou um plugin nativo |
| APK de release assinado com a chave de debug | Padrão do `flutter create` | Configurar a chave de upload antes de publicar |
| Fotos das peças não entram no backup | O backup é só o arquivo do banco | Backup em `.zip` com banco + fotos |

### 2.1 Antes de publicar nas lojas

- Chave de assinatura do Android e perfil de distribuição do iOS.
- Ícone e telas de abertura próprios (hoje são os padrões do Flutter).
- Política de privacidade e formulários de privacidade das lojas (Data
  safety no Google Play, rótulos de privacidade na App Store). Enquanto o
  app for 100% local, a resposta é "nenhum dado coletado". Se a seção 3 for
  implementada, isso muda para quem ativar o recurso.
- Texto da loja: pode citar "compatível com impressoras Bambu Lab", sempre
  com o aviso de que o app não é afiliado à marca; o nome e o ícone não usam
  a marca.
- Testar o pedido de permissão de rede local no iOS
  (`NSLocalNetworkUsageDescription`) num aparelho real.

## 3. Proposta: estação local + notificações push

Resolve as três primeiras limitações da tabela sem abrir a impressora para a
internet. É **opcional**: o app continua funcionando sozinho e offline para
quem não ativar.

### 3.1 Por que precisa de algo na rede local

A impressora só aceita conexões da rede local. Um servidor na nuvem não
consegue falar com ela, e o celular nem sempre está em casa ou com o app
aberto. Por isso precisa existir uma **estação**: um aparelho ligado o tempo
todo na rede da impressora, que acompanha a impressão e avisa o serviço de
notificações.

Guiar a instalação dentro do app ajuda, mas não basta. O obstáculo não é
seguir passos, é **ter um aparelho sempre ligado ali**. Mesmo com um bom
guia, o usuário leigo esbarra em:

- não ter um PC ou Raspberry Pi sobrando;
- o PC entrar em suspensão no meio da impressão e o aviso nunca chegar;
- terminal, Docker, antivírus e firewall;
- manter a estação atualizada.

Por isso a escolha de onde a estação roda (3.2) importa mais do que o guia.

```
 rede da casa                                    internet
┌───────────────────────────────────┐
│ impressora ◄── MQTT/TLS 8883 ──┐  │
│            ◄── FTPS 990 ───────┤  │
│                                │  │
│                          ┌─────┴─┐│  HTTPS (só saída)  ┌──────────────┐   push   ┌─────────┐
│                          │estação├┼───────────────────►│ serviço de   ├─────────►│ celular │
│                          └───────┘│                    │ notificações │ FCM/APNs └─────────┘
└───────────────────────────────────┘                    └──────────────┘
```

### 3.2 Onde a estação roda

Do mais fácil para o mais difícil, para quem baixou o app na loja:

| Opção | Para quem | Prós | Contras |
|---|---|---|---|
| **1. Celular ou tablet Android antigo** com o próprio PrintCost em "modo estação" (**recomendada**) | Qualquer usuário | Instala pela loja; pareamento por QR code; quase todo mundo tem um aparelho velho na gaveta; reaproveita o `BambuLanAdapter` em Dart | Precisa de um serviço em primeiro plano rodando por muito tempo, e o Google Play exige justificativa para isso (ver 3.4) |
| **2. App de computador** (Windows/macOS, ícone na bandeja) | Quem fatia no PC e o deixa ligado durante a impressão | Instalação com dois cliques; o Flutter compila o mesmo código para desktop | O guia precisa ensinar a desligar a suspensão e liberar o firewall; computador desligado = sem aviso |
| **3. Container Docker ou add-on do Home Assistant** | Público técnico | Roda em NAS, servidor ou Home Assistant que já existem | Fora do alcance do usuário leigo |
| **4. Raspberry Pi já configurado, vendido pronto** | Quem quer zero configuração | Liga na tomada e lê o QR code | Vira um negócio de hardware: estoque, envio, suporte |

Antes de investir, vale confirmar quem precisa disso. Quem usa a nuvem da
fabricante provavelmente já recebe aviso de fim de impressão pelo app
oficial. O recurso interessa mais a quem usa só o modo LAN, que costuma ser
um público mais técnico.

### 3.3 Responsabilidades

**Estação (na casa do usuário)**

- Mantém a conexão MQTT com a impressora, com a mesma lógica do app:
  `pushall` ao conectar, mesclagem dos diffs e reconexão com espera
  crescente (backoff).
- Detecta as transições "imprimindo → concluída" e "imprimindo → falhou" e
  envia um evento ao serviço.
- Opcional: baixa o `.3mf` do trabalho por FTPS e manda junto o peso por
  filamento e o tempo. No Android e no desktop isso precisa de código nativo
  ou de uma biblioteca de FTPS com reaproveitamento de sessão TLS, porque o
  `dart:io` não oferece.
- Envia um sinal de vida (heartbeat) periódico.
- Guarda o código de acesso **só localmente**; ele nunca sai da rede de casa.
- Só faz conexões de saída: nada de porta aberta nem redirecionamento no
  roteador.

**Serviço de notificações (nuvem)**

- Recebe eventos autenticados da estação e entrega o push ao(s) celular(es)
  pareado(s) via FCM (Android) e APNs (iOS). Pode ser um serviço próprio ou
  um serviço de push existente.
- Guarda o mínimo necessário: identificador da estação, tokens de push dos
  aparelhos e o último estado. Não recebe IP, serial nem código de acesso da
  impressora.

**App (celular principal)**

- Pareamento: a estação mostra um QR code com um código temporário; o app lê
  e registra o token de push do aparelho. Sem conta, sem e-mail.
- Ao tocar na notificação, abre "Registrar esta impressão" com tempo, nome
  do arquivo e, se a estação tiver baixado o `.3mf`, o peso por filamento.
- Continua usando a conexão direta quando está na mesma rede.

### 3.4 Riscos do modo estação no Android

Verificar **antes** de implementar:

- **Tipo do serviço em primeiro plano:** desde o Android 14 todo serviço em
  primeiro plano declara um tipo, e alguns tipos têm limite de tempo de
  execução por dia. Para uma conexão que fica aberta horas, o candidato é
  `specialUse`, que exige justificativa aceita na revisão do Google Play.
  Se a revisão recusar, a opção 1 fica inviável e a opção 2 vira a
  principal.
- **Economia de bateria dos fabricantes:** alguns fabricantes encerram
  serviços em segundo plano mesmo em primeiro plano. O guia do modo estação
  precisa pedir para tirar o app da otimização de bateria.
- **Wi-Fi em repouso:** o aparelho deve manter o Wi-Fi ligado com a tela
  apagada; testar em aparelhos antigos (Android 8–10).
- **O heartbeat (3.7) é a rede de segurança:** se a estação for encerrada, o
  usuário é avisado de que o monitoramento parou.

### 3.5 Contrato do evento (rascunho)

```json
{
  "event_id": "01J…",
  "station_id": "a1b2…",
  "type": "print_finished",
  "occurred_at": "2026-10-28T14:03:00Z",
  "job": {
    "name": "suporte_fone",
    "duration_s": 15120,
    "filaments": [{ "type": "PLA", "color": "#FFFFFF", "grams": 48.2 }]
  }
}
```

- `type`: `print_finished`, `print_failed`, `station_heartbeat`.
- `event_id` gerado na estação, para que reenvios não virem notificações
  duplicadas (idempotência).
- `job.filaments` só existe quando o `.3mf` foi baixado.

### 3.6 Segurança

- Estação → serviço: HTTPS com um token por estação, emitido no pareamento,
  que pode ser revogado.
- O conteúdo do push é mínimo (nome do trabalho e estado). Os detalhes podem
  ir criptografados de ponta a ponta com uma chave trocada no pareamento,
  para que o serviço não consiga ler.
- Limite de taxa por estação no serviço, para que uma estação com defeito não
  dispare notificações sem parar.
- A estação mantém a regra do app: aceita o certificado autoassinado só do IP
  cadastrado e fixa o certificado na primeira conexão.

### 3.7 Operação (SRE)

- **SLI principal:** atraso entre a impressora mudar de estado e o push
  chegar ao aparelho. Proposta de SLO: 99% em menos de 30 s.
- **Detecção de estação parada (dead man's switch):** se não chegar heartbeat
  por N minutos durante uma impressão, o serviço avisa o usuário de que o
  monitoramento parou. Assim o silêncio nunca é confundido com "tudo certo".
- **Entrega:** fila com retentativas, backoff e fila de mensagens com falha
  (dead letter). Tokens de push inválidos (app desinstalado) são removidos
  quando FCM ou APNs os recusarem.
- **Métricas:** eventos recebidos/entregues/falhos por tipo, estações ativas,
  estações sem heartbeat e latência de ponta a ponta.
- **Atualização da estação:** versão informada no heartbeat, para saber
  quando dá para mudar o contrato e para avisar quem estiver com versão
  antiga.


### 3.8 Alternativa sem backend

No Android, o próprio celular principal pode manter o MQTT vivo com um
serviço em primeiro plano (com notificação fixa) e avisar localmente. É mais
simples, mas gasta bateria, só funciona com o celular na mesma rede da
impressora e não existe equivalente no iOS. Serve como primeiro passo e
reaproveita o mesmo serviço do modo estação.

### 3.9 Ordem sugerida

1. Confirmar com a revisão do Google Play o tipo de serviço em primeiro
   plano (3.4) e confirmar a demanda (3.2).
2. Serviço em primeiro plano no Android com aviso local (3.8): valida a
   conexão longa e os campos do MQTT (fecha o item 1.2).
3. Modo estação + serviço de notificações + pareamento por QR code.
4. Heartbeat, painel e alertas do serviço (SLO, estações paradas).
5. App de computador (opção 2) reaproveitando o mesmo código.
6. Download do `.3mf` por FTPS na estação e peso no evento.

# Patches do Flutter e do seletor Android

O projeto mantém cópias locais do plugin Gradle do Flutter 3.50.0
(`ab2912035e160d9cad6306df307576da6128ebdb`) e do `android_file_picker`
2.1.6 para corrigir avisos de compilação sem desativar diagnósticos. A decisão
de manter esses patches foi autorizada pelo responsável pelo projeto.

- `third_party/flutter_gradle/` substitui apenas o plugin Gradle, não o SDK.
  A configuração Android confere a versão e o revisionamento do SDK antes de
  carregá-lo. Foram ajustadas anotações Kotlin, uma condição redundante e a
  obtenção de `ExecOperations` por injeção do Gradle.
- `third_party/android_file_picker/` é selecionado por `dependency_overrides`.
  Os ajustes removem chamadas redundantes e um cast não verificado, atualizam
  o manifesto e usam `WEBP_LOSSY` a partir do Android 11, mantendo o formato
  legado nas versões anteriores.

As licenças originais estão em cada diretório. Essas cópias exigem manutenção:
ao atualizar Flutter ou o pacote, compare com as fontes oficiais, reavalie e
remova patches já incorporados, atualize a verificação de versão, e execute
análise, testes Flutter e nativos, além do build release sem cache. A seleção,
importação e gravação de arquivos e imagens deve ser verificada em dispositivos
Android, incluindo versões anteriores e posteriores ao Android 11.

Alternativas consideradas foram ignorar os avisos, aguardar o upstream ou
modificar o SDK instalado. Nenhuma foi escolhida: elas ocultariam os avisos,
deixariam o pedido pendente ou tornariam o build dependente de mudanças locais.

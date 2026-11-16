.DEFAULT_GOAL := help

FLUTTER ?= flutter
DART ?= dart
GO ?= go
PYTHON ?= python3
DEVICE ?=
ARGS ?=

.PHONY: help get doctor devices run dev analyze format format-check test test-coverage \
	check signing-check generate generate-db generate-l10n icons build-apk \
	build-apk-split build-aab build-ios build-ipa clean

help:
	@echo "PrintCost - comandos disponíveis:"
	@echo "  make get              Instala as dependências Flutter"
	@echo "  make doctor           Diagnostica o ambiente Flutter"
	@echo "  make devices          Lista dispositivos disponíveis"
	@echo "  make run              Escolhe um dispositivo e executa o app"
	@echo "  make analyze          Executa a análise estática"
	@echo "  make format           Formata o código Dart"
	@echo "  make format-check     Verifica a formatação sem alterar arquivos"
	@echo "  make test             Executa os testes Flutter"
	@echo "  make test-coverage    Executa os testes Flutter com cobertura"
	@echo "  make signing-check    Verifica e testa a ferramenta de assinatura Go"
	@echo "  make check            Executa analyze, test, testes do menu e signing-check"
	@echo "  make generate         Gera código Drift e traduções"
	@echo "  make generate-db      Gera código Drift"
	@echo "  make generate-l10n    Gera arquivos de tradução"
	@echo "  make icons            Gera ícones e tela de abertura"
	@echo "  make build-apk        Gera APK release universal"
	@echo "  make build-apk-split  Gera APKs release por arquitetura"
	@echo "  make build-aab        Gera Android App Bundle release"
	@echo "  make build-ios        Compila release para iOS"
	@echo "  make build-ipa        Gera IPA release"
	@echo "  make clean            Limpa artefatos Flutter"

get:
	$(FLUTTER) pub get

doctor:
	$(FLUTTER) doctor

devices:
	$(FLUTTER) devices

run dev:
	@DEVICE="$(DEVICE)" $(PYTHON) tool/run.py "$(FLUTTER)" $(ARGS)

analyze:
	$(FLUTTER) analyze

format:
	$(DART) format lib test

format-check:
	$(DART) format --output=none --set-exit-if-changed lib test

test:
	$(FLUTTER) test $(ARGS)

test-coverage:
	$(FLUTTER) test --coverage $(ARGS)

signing-check:
	@cd tool/signing-key && test -z "$$(gofmt -l .)"
	cd tool/signing-key && $(GO) vet ./...
	cd tool/signing-key && $(GO) test ./...

check: analyze test signing-check
	$(PYTHON) -m unittest discover -s tool -p 'test_*.py'

generate: generate-db generate-l10n

generate-db:
	$(DART) run build_runner build --delete-conflicting-outputs

generate-l10n:
	$(PYTHON) tool/gen_arb.py
	$(FLUTTER) gen-l10n

icons:
	$(DART) run flutter_launcher_icons
	$(DART) run flutter_native_splash:create

build-apk:
	$(FLUTTER) build apk --release $(ARGS)

build-apk-split:
	$(FLUTTER) build apk --release --split-per-abi $(ARGS)

build-aab:
	$(FLUTTER) build appbundle --release $(ARGS)

build-ios:
	$(FLUTTER) build ios --release $(ARGS)

build-ipa:
	$(FLUTTER) build ipa --release $(ARGS)

clean:
	$(FLUTTER) clean

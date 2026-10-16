PYTHON ?= python
PIP ?= $(PYTHON) -m pip

.PHONY: help install test lint clean

help: ## Wyświetla dostępne polecenia
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "} {printf "%-10s %s\n", $$1, $$2}'

install: ## Instaluje zależności z requirements.txt
	$(PIP) install -r requirements.txt

test: ## Uruchamia testy
	$(PYTHON) -m pytest

lint: ## Sprawdza składnię plików Pythona
	$(PYTHON) -m compileall -q .

clean: ## Usuwa cache Pythona oraz wyniki testów
	$(PYTHON) -c "import pathlib, shutil; [shutil.rmtree(p) for p in pathlib.Path('.').rglob('__pycache__') if p.is_dir()]; shutil.rmtree('.pytest_cache', ignore_errors=True)"

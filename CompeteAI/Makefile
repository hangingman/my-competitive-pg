SHELL=/usr/bin/env bash

.PHONY: install
install:
	pip install pip-tools
	pip-sync requirements.txt
	pip install .

.PHONY: install-dev
install-dev:
	pip install pip-tools
	pip-sync requirements.txt requirements-dev.txt
	pip install -e .

.PHONY: pin
pin:
	pip-compile requirements.in -o requirements.txt
	pip-compile requirements-dev.in -o requirements-dev.txt

.PHONY: lint
lint:
	black --check src/CompeteAI/ tests/
	flake8 src/CompeteAI/ tests/
	isort --check-only src/CompeteAI/ tests/
	mypy src/CompeteAI/ tests/

.PHONY: format
format:
	black src/CompeteAI/ tests/
	isort src/CompeteAI/ tests/

.PHONY: test
test:
	pytest tests/

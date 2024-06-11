SHELL=/usr/bin/env bash

# venvが有効化されているかを確認し、有効化されていなければ有効化する
activate_venv = \
	if [ -z "$$VIRTUAL_ENV" ]; then \
		source .venv/bin/activate; \
	fi

.PHONY: install install-dev pin lint format test

install:
	$(activate_venv) && \
	pip install pip-tools && \
	pip-sync requirements.txt && \
	pip install .

install-dev:
	$(activate_venv) && \
	pip install pip-tools && \
	pip-sync requirements.txt requirements-dev.txt && \
	pip install -e .

pin:
	$(activate_venv) && \
	pip-compile requirements.in -o requirements.txt && \
	pip-compile requirements-dev.in -o requirements-dev.txt

lint:
	$(activate_venv) && \
	black --check src/CompeteAI/ tests/ && \
	flake8 src/CompeteAI/ tests/ && \
	isort --check-only src/CompeteAI/ tests/ && \
	mypy src/CompeteAI/ tests/

format:
	$(activate_venv) && \
	black src/CompeteAI/ tests/ && \
	isort src/CompeteAI/ tests/

test:
	$(activate_venv) && \
	pytest tests/

# Objetivos del repositorio. `make help` los lista.
#
# Los objetivos del prototipo se agregan en el paso 6 de la metodología
# (notas/metodologia-y-pasos.md), cuando el stack esté fijado.

.DEFAULT_GOAL := help
.PHONY: help gates wiki wiki-build

help: ## Lista los objetivos disponibles
	@printf '\nObjetivos de arqsoft-reto-3:\n\n'
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "} {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'
	@printf '\n'

gates: ## Corre las compuertas de verificación de la metodología
	@./notas/verificar-gates.sh

wiki: ## Vista previa local de la wiki (requiere Ruby 3.x)
	@cd docs && bundle exec jekyll serve --livereload

wiki-build: ## Construye la wiki para verificar que compila
	@cd docs && bundle exec jekyll build

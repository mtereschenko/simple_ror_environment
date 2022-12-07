.PHONY: help
# Make stuff

-include .env

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

.DEFAULT_GOAL := help

ARTIFACTS_DIRECTORY := "./artifacts"

CURRENT_PATH :=${abspath .}

SHELL_CONTAINER_NAME := $(if $(c),$(c),node)
BUILD_TARGET := $(if $(t),$(t),development)

help: ## Help.
	@grep -E '^[a-zA-Z-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-27s[0m %s\n", $$1, $$2}'

init: ## Project installation.
	@rm -f ./.env
	@cp .env.example .env
	@make init_app_directory
	@docker-compose -f docker-compose.init.yml build
	@docker-compose -f docker-compose.init.yml up

build: ## Build images.
	@make create_project_artifacts
	@docker-compose -f docker-compose.$(BUILD_TARGET).yml build

shell: ## Internal image bash command line.
	@if [[ -z `docker ps | grep ${SHELL_CONTAINER_NAME}` ]]; then \
		echo "${SHELL_CONTAINER_NAME} is NOT running (make start)."; \
	else \
		docker-compose -f docker-compose.$(BUILD_TARGET).yml exec $(SHELL_CONTAINER_NAME) /bin/ash; \
	fi
	
start: ## Start previously builded application images.
	@make create_project_artifacts
	@make start_node
	@make start_nginx

run: ## Run ruby debugger session.
	@docker-compose -f docker-compose.$(BUILD_TARGET).yml exec node /bin/ash /entrypoint/runner.sh

start_node: ## Start node image.
	@if [[ -z `docker ps | grep node` ]]; then \
		docker-compose -f docker-compose.$(BUILD_TARGET).yml up -d node; \
	else \
		echo "Node is running."; \
	fi

start_nginx: ## Start nginx image.
	@if [[ -z `docker ps | grep nginx` ]]; then \
		docker-compose -f docker-compose.$(BUILD_TARGET).yml up -d nginx; \
	else \
		echo "Nginx is running."; \
	fi

stop: ## Stop all images.
	@docker-compose -f docker-compose.$(BUILD_TARGET).yml stop

create_project_artifacts:
	mkdir -p ./artifacts/node

init_app_directory:
	@mkdir -p ${APP_PATH}

.PHONY: help
# Make stuff

-include .env

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

.DEFAULT_GOAL := help

ARTIFACTS_DIRECTORY := "./artifacts"

CURRENT_PATH :=${abspath .}

SHELL_CONTAINER_NAME := $(if $(c),$(c),ruby)
BUILD_TARGET := $(if $(t),$(t),development)

help: ## Help.
	@grep -E '^[a-zA-Z-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-27s[0m %s\n", $$1, $$2}'

init: ## Project installation.
	@rm -f ./.env
	@cp .env.example .env
	@make init_app_directory
	@make create_postgress_volume
	@docker-compose -f docker-compose.init.yml build
	@docker-compose -f docker-compose.init.yml up

build: ## Build images.
	@make create_project_artifacts
	@cp ${APP_PATH}/Gemfile "${ARTIFACTS_DIRECTORY}/rails/Gemfile"
	@cp ${APP_PATH}/Gemfile.lock "${ARTIFACTS_DIRECTORY}/rails/Gemfile.lock"
	@docker-compose -f docker-compose.$(BUILD_TARGET).yml build

shell: ## Internal image bash command line.
	@if [[ -z `docker ps | grep ${SHELL_CONTAINER_NAME}` ]]; then \
		echo "${SHELL_CONTAINER_NAME} is NOT running (make start)."; \
	else \
		docker-compose -f docker-compose.$(BUILD_TARGET).yml exec $(SHELL_CONTAINER_NAME) /bin/ash; \
	fi
	
start: ## Start previously builded application images.
	@make create_project_artifacts
	@make start_postgres
	@make start_ruby
	@make start_nginx

run: ## Run ruby debugger session.
	@docker-compose -f docker-compose.$(BUILD_TARGET).yml exec ruby /bin/ash /rdebug_ide/runner.sh

start_ruby: ## Start ruby image.
	@if [[ -z `docker ps | grep ruby` ]]; then \
		docker-compose -f docker-compose.$(BUILD_TARGET).yml up -d ruby; \
	else \
		echo "Ruby is running."; \
	fi

start_postgres: ## Start postgres image.
	@if [[ -z `docker ps | grep postgres` ]]; then \
		docker-compose -f docker-compose.$(BUILD_TARGET).yml up -d postgres; \
	else \
		echo "Postgres is running."; \
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
	mkdir -p ./artifacts/rails
	mkdir -p ./artifacts/db

init_app_directory:
	@mkdir -p ${APP_PATH}

create_postgress_volume:
	@sed -i '' -r  "s/postgres_volume:/${PROJECT_NAME}_db_volume:/g" docker-compose.development.yml

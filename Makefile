# Makefile

# Variables
DOCKER_COMPOSE = docker-compose

# Commands
.PHONY: build
build:
	@$(DOCKER_COMPOSE) build

.PHONY: up
up:
	@$(DOCKER_COMPOSE) up -d

.PHONY: down
down:
	@$(DOCKER_COMPOSE) down

.PHONY: artisan
artisan:
	@$(DOCKER_COMPOSE) exec app php artisan

.PHONY: composer
composer:
	@$(DOCKER_COMPOSE) exec app composer

.PHONY: install
install: build up
	@sleep 10 # wait for services to start
	@$(DOCKER_COMPOSE) exec app composer create-project --prefer-dist laravel/laravel /var/www/html/laravel

.PHONY: migrate
migrate:
	@$(DOCKER_COMPOSE) exec app php artisan migrate

.PHONY: seed
seed:
	@$(DOCKER_COMPOSE) exec app php artisan db:seed

.PHONY: start stop ps prepare test cache-clear
.DEFAULT_GOAL= help

help:
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

ps: ## Run docker-compose ps
	docker-compose ps

start: ## Run docker-compose up -d
	docker-compose up -d

stop: ## Run docker-compose down
	docker-compose down

dbtest: ## Build the DB test, control the schema validity, load fixtures and check the migration status
	php bin/console cache:clear --env=test
	php bin/console doctrine:database:drop --if-exists -f --env=test
	php bin/console doctrine:database:create --env=test
	php bin/console doctrine:schema:update -f --env=test
	php bin/console doctrine:fixtures:load -n --env=test

dbtest-local: ## Build the DB test, control the schema validity, load fixtures and check the migration status
	symfony console cache:clear --env=test
	symfony console doctrine:database:drop --if-exists -f --env=test
	symfony console doctrine:database:create --env=test
	symfony console doctrine:schema:update -f --env=test
	symfony console doctrine:fixtures:load -n --env=test

phpunit: ## Run PHPUnit
	${CURDIR}/vendor/bin/simple-phpunit

stan: ## Run PHPStan
	${CURDIR}/vendor/bin/phpstan analyse  -c phpstan.neon

phpcs: ## Run Codesniffer
	${CURDIR}/vendor/bin/phpcs

phpcbf: ## Run Codesniffer Beautify
	${CURDIR}/vendor/bin/phpcbf

dbdev: ## Build the DB, control the schema validity, load fixtures and check the migration status
	docker-compose exec php7.4 php bin/console doctrine:cache:clear-metadata
	docker-compose exec php7.4 php bin/console doctrine:database:create --if-not-exists
	docker-compose exec php7.4 php bin/console doctrine:schema:drop --force
	docker-compose exec php7.4 php bin/console doctrine:schema:create
	docker-compose exec php7.4 php bin/console doctrine:schema:validate
	docker-compose exec php7.4 php bin/console doctrine:fixtures:load -n

dbdev-local: ## Build the DB, control the schema validity, load fixtures and check the migration status
	symfony console doctrine:cache:clear-metadata
	symfony console doctrine:database:create --if-not-exists
	symfony console doctrine:schema:drop --force
	symfony console doctrine:schema:create
	symfony console doctrine:schema:validate
	symfony console doctrine:fixtures:load -n

cache-clear: ## Run cache:clear
	docker-compose exec php7.4 php bin/console cache:clear

clean: ## Run clean
	rm -f *.dat

cur: ## Run clean
	echo DIR := ${CURDIR}
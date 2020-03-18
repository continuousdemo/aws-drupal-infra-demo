default:help;

GREEN = \033[0;32m
YELLOW = \x1b[33m
NC = \033[0m

DRUSH_BIN=${PWD}/vendor/bin/drush

MYSQL_DB_ROOT_USER?=root
MYSQL_DB_ROOT_PASSWORD?=123456
MYSQL_DB_USER?=${MYSQL_DB_ROOT_USER}
MYSQL_DB_PASSWORD?=${MYSQL_DB_ROOT_PASSWORD}
MYSQL_DB_HOST?=localhost
MYSQL_DB_NAME?=demo
SITENAME?=DRUPAL-EPHEMERAL-DEMO
ACCOUNT_NAME?=admin
ACCOUNT_PASS?=123456
ACCOUNT_MAIL?=drupa-demo@continuousphp.com

## Display this help dialog
help:
	@echo -e "${YELLOW}Usage:${NC}\n  make [command]:\n\n${YELLOW}Available commands:${NC}"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
	helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${GREEN}%-30s${NC} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Install site
install:
	@${DRUSH_BIN} -y si standard \
		--db-url=mysql://${MYSQL_DB_USER}:${MYSQL_DB_PASSWORD}@${MYSQL_DB_HOST}/${MYSQL_DB_NAME} \
		--db-su=${MYSQL_DB_ROOT_USER} \
		--db-su-pw=${MYSQL_DB_ROOT_PASSWORD} \
		--site-name="${SITENAME}" \
		--account-name=${ACCOUNT_NAME} \
        --account-pass=${ACCOUNT_PASS} \
        --account-mail=${ACCOUNT_MAIL}

## Migrate site
migrate:
	${DRUSH_BIN} -y cr
	${DRUSH_BIN} -y updb --cache-clear
	${DRUSH_BIN} -y cr

## Status report
status:
	${DRUSH_BIN} status

## Setup behat for continuousphp
cphp-setup-behat:
	sed 's/http:\/\/web\//http:\/\/apache24\//' behat.yml > behat-cphp.yml

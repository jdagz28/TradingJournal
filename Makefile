SRCS_DIR    := ./srcs/
DB_DIR      := /home/tradingjournal/data/postgresql/
WEB_DIR		:= /home/tradingjournal/data/website/

COMPOSE_FILE := $(SRCS_DIR)docker-compose.yml

all: up

up:
	sudo mkdir -p $(DB_DIR)
	sudo mkdir -p $(WEB_DIR)
	@docker compose -f $(COMPOSE_FILE) up -d

down:
	@docker compose -f $(COMPOSE_FILE) down

start: up
	@docker compose -f $(COMPOSE_FILE) start

stop:
	@docker compose -f $(COMPOSE_FILE) stop

build:
	@docker compose -f $(COMPOSE_FILE) build

accessnginx:
	@docker exec -it nginx zsh

accesspostgresql:
	@docker exec -it mariadb zsh

accesswebsite:
	@docker exec -it website zsh

stop-containers:
	@if [ -n "$$(docker container ls -aq)" ]; then \
		docker container stop $$(docker container ls -aq); \
	fi

remove-containers:
	@if [ -n "$$(docker container ls -aq)" ]; then \
		docker container rm $$(docker container ls -aq); \
	fi

remove-images:
	@if [ -n "$$(docker images -aq)" ]; then \
		docker rmi -f $$(docker images -aq); \
	fi

remove-networks:
	@docker network ls --format '{{.Name}}' | \
		grep -vE '^(bridge|host|none|system)' | \
		xargs -r docker network rm

clean: down stop-containers remove-containers remove-images remove-networks
	@sudo rm -rf $(WP_DIR)
	@sudo rm -rf $(DB_DIR)
	@sudo rm -rf $(WEB_DIR)

prune: clean
	@docker system prune -a --volumes

re: cleanhome all

.PHONY: all up down start stop build accessnginx accesspostgresql accesswebsite clean prune re 
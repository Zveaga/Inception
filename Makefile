COMPOSE = docker compose -f srcs/docker-compose.yml

WP_DATA_VOL = ${HOME}/data/wordpress
DB_DATA_VOL = ${HOME}/data/mariadb

all: build

run:
	@mkdir -p $(WP_DATA_VOL)
	@mkdir -p $(DB_DATA_VOL)
	@${COMPOSE} up --build

build:
	@mkdir -p $(WP_DATA_VOL)
	@mkdir -p $(DB_DATA_VOL)
	@${COMPOSE} build --no-cache --pull

run_b: build run
	
down:
	@${COMPOSE} down

clean:
	@${COMPOSE} down --volumes --rmi all --remove-orphans

fclean: clean
	@echo $(DB_DATA_VOL) $(WP_DATA_VOL)
	@docker system prune --all
	@docker builder prune --all
	@sudo rm -rf $(DB_DATA_VOL)
	@sudo rm -rf $(WP_DATA_VOL)

re: fclean run

.PHONY: all run build run_b down clean fclean re

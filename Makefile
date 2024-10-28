COMPOSE=docker compose -f srcs/docker-compose.yml

VOL_WP_PATH = ${HOME}/data/wordpress
VOL_DB_PATH = ${HOME}/data/mariadb

all: build

run:
	@mkdir -p $(VOL_WP_PATH)
	@mkdir -p $(VOL_DB_PATH)
	@${COMPOSE} up --build

build:
	@mkdir -p $(VOL_WP_PATH)
	@mkdir -p $(VOL_DB_PATH)
	@${COMPOSE} build --no-cache --pull

run_b: build run
	
down:
	@${COMPOSE} down

clean:
	@${COMPOSE} down --volumes --rmi all --remove-orphans

fclean: clean
	@echo $(VOL_DB_PATH) $(VOL_WP_PATH)
	@docker system prune --all
	@docker builder prune --all
	@sudo rm -rf $(VOL_DB_PATH)
	@sudo rm -rf $(VOL_WP_PATH)

re: fclean run

.PHONY: all run build run_b down clean fclean re

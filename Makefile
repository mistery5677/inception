# --- COnfiguration ---
NAME = inception
LOGIN = miafonso
# Paths for the host volume
DATA_PATH = /home/$(LOGIN)/data
WP_DATA = $(DATA_PATH)/wordpress
DB_DATA = $(DATA_PATH)/mariadb

# Path for the docker-compose
COMPOSE_FILE = ./srcs/docker-compose.yml

GREEN = \033[0;32m
RESET = \033[0m

all: build

# Create the data directorys if they don't exist and start the containers
build:
	@echo "$(GREEN)Criating data directorys in $(DATA_PATH)...$(RESET)"
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	@echo "$(GREEN)Building and starting the containers ...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) up --build -d

# For containers and remove the network
down:
	@echo "$(GREEN)Stopping containers ...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) down

# For containers, remove the images and the docker volumes
clean: down
	@echo "$(GREEN)Removing images and docker volumes...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) down --rmi all -v

# Remove all docker and delete the disk data
fclean: clean
	@echo "$(GREEN)Removendo TODOS os dados persistentes (requer sudo)...$(RESET)"
	@sudo rm -rf $(DATA_PATH)
	@echo "$(GREEN)Limpando sistema Docker (prune)...$(RESET)"
	@docker system prune -af

# Restart everything
re: fclean all

.PHONY: all build down clean fclean re
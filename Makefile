# --- Configuração ---
NAME = inception
LOGIN = miafonso
# Caminhos para os volumes no host (exigido pelo subject)
DATA_PATH = /home/$(LOGIN)/data
WP_DATA = $(DATA_PATH)/wordpress
DB_DATA = $(DATA_PATH)/mariadb

# Caminho para o docker-compose
COMPOSE_FILE = ./srcs/docker-compose.yml

# --- Cores (opcional, para ficar bonito) ---
GREEN = \033[0;32m
RESET = \033[0m

# --- Regras ---

all: build

# Cria os diretórios de dados se não existirem e inicia os containers
build:
	@echo "$(GREEN)Criando diretórios de dados em $(DATA_PATH)...$(RESET)"
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	@echo "$(GREEN)Construindo e iniciando os containers...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) up --build -d

# Para os containers e remove a rede
down:
	@echo "$(GREEN)Parando containers...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) down

# Para os containers, remove imagens criadas e volumes do docker
clean: down
	@echo "$(GREEN)Removendo imagens e volumes do Docker...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) down --rmi all -v

# Limpeza profunda: remove tudo do Docker e APAGA os dados no disco
fclean: clean
	@echo "$(GREEN)Removendo TODOS os dados persistentes (requer sudo)...$(RESET)"
	@sudo rm -rf $(DATA_PATH)
	@echo "$(GREEN)Limpando sistema Docker (prune)...$(RESET)"
	@docker system prune -af

# Reinicia tudo do zero
re: fclean all

# Garante que o make não confunda estas regras com ficheiros
.PHONY: all build down clean fclean re
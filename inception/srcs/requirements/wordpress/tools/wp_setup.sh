#!/bin/sh

# Aguarda o MariaDB estar pronto (opcional, mas recomendado)
# Pode ser feito com um loop verificando a conexão

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Instalando WordPress..."

    # Baixa o core do WordPress
    wp core download --allow-root

    # Cria o arquivo de configuração usando variáveis de ambiente (.env)
    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root

    # Instala o site (Cria admin)
    wp core install \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    # Cria um usuário normal (obrigatório pelo subject)
    wp user create \
        $WP_USER \
        $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        --allow-root
fi

echo "Iniciando PHP-FPM..."
# Inicia PHP-FPM em modo foreground (-F)
exec php-fpm82 -F
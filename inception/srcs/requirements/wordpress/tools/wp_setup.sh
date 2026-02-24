#!/bin/sh

# Espera uns segundos para garantir que o MariaDB já arrancou completamente
sleep 10

# Só instala o WordPress se ele ainda não estiver lá
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "A descarregar o WordPress..."
    wp core download --allow-root

    echo "A configurar a ligação à base de dados..."
    wp config create --dbname=$MYSQL_DATABASE \
                     --dbuser=$MYSQL_USER \
                     --dbpass=$MYSQL_PASSWORD \
                     --dbhost=mariadb \
                     --allow-root

    echo "A instalar o WordPress..."
    wp core install --url=https://$DOMAIN_NAME \
                    --title="$WP_TITLE" \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --allow-root

    echo "A criar o segundo utilizador..."
    # Cria o segundo utilizador obrigatório do projeto [cite: 106]
    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
    
    echo "WordPress instalado com sucesso!"
fi

echo "A arrancar o PHP-FPM..."
# Executa o PHP-FPM em foreground para cumprir a regra do PID 1 do projeto [cite: 102-105]
exec /usr/sbin/php-fpm83 -F
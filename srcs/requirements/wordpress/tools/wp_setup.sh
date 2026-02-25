#!/bin/sh

# Garants that the MariaDB is initialized
sleep 10

# Start the WordPress if he is not there
if [ ! -f /var/www/html/wp-config.php ]; then
    
    # Read the passwords
    MYSQL_PASSWORD=$(cat /run/secrets/db_password)
    WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
    WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

    echo "Downloading Wordpress..."
    php -d memory_limit=512M /usr/bin/wp core download --allow-root

    echo "Configuring bridge to data base..."
    wp config create --dbname=$MYSQL_DATABASE \
                     --dbuser=$MYSQL_USER \
                     --dbpass=$MYSQL_PASSWORD \
                     --dbhost=mariadb \
                     --allow-root

    echo "Installing WordPress..."
    wp core install --url=https://$DOMAIN_NAME \
                    --title="$WP_TITLE" \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --allow-root

    echo "Criating the second user ..."
    # Criates the second user, like says in the subject
    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
    
    echo "WordPress is installed!"
fi

echo "Initializing PHP-FPM..."
# Executes the PHP-FPM in foreground according to PID 1 rule of the project
exec /usr/sbin/php-fpm83 -F
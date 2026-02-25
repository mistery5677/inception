FROM alpine:3.19

# Install the PHP and his packages
RUN apk update && apk add --no-cache php83 php83-fpm php83-mysqli php83-json php83-curl \
    php83-dom php83-exif php83-fileinfo php83-mbstring php83-openssl php83-xml php83-zip \
    curl mariadb-client php83-phar

# Criates the shortcut for the PHP and the wp-cli to work
RUN ln -s /usr/bin/php83 /usr/bin/php

# Download and install the WP-CLI using wget and paste for the main folder
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/bin/wp

# Criate the web directory
RUN mkdir -p /var/www/html && chown -R nobody:nobody /var/www/html

# Copy the configurations
COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./tools/wp_setup.sh /tmp/wp_setup.sh
RUN chmod +x /tmp/wp_setup.sh

# The working directory is the shared volume
WORKDIR /var/www/html

# Expose the port 9000 to connect NGINX with PHP-FPM
EXPOSE 9000

ENTRYPOINT ["/tmp/wp_setup.sh"]
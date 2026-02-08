FROM alpine:3.19

# Instala PHP 8.2 e extensões necessárias, mais mariadb-client (para o WP se conectar ao DB)
RUN apk update && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-mbstring \
    php82-openssl \
    php82-xml \
    php82-zip \
    php82-phar \
    curl \
    mariadb-client

# Configura o PHP-FPM para ouvir na porta 9000 em vez de socket
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php82/php-fpm.d/www.conf

# Baixa o WP-CLI (ferramenta de linha de comando para gerir WP)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/wp_setup.sh /tmp/wp_setup.sh
RUN chmod +x /tmp/wp_setup.sh

WORKDIR /var/www/html

ENTRYPOINT ["/tmp/wp_setup.sh"]
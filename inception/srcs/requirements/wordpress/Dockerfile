FROM alpine:3.19

# Instala o PHP e os pacotes
RUN apk update && apk add --no-cache php83 php83-fpm php83-mysqli php83-json php83-curl \
    php83-dom php83-exif php83-fileinfo php83-mbstring php83-openssl php83-xml php83-zip \
    curl mariadb-client php83-phar

# 👉 ADICIONA ESTA LINHA: Cria o atalho para o php para o wp-cli funcionar
RUN ln -s /usr/bin/php83 /usr/bin/php

# Descarrega e instala o WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# ... (o resto do ficheiro fica igual)
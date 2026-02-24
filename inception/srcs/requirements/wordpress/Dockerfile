FROM alpine:3.19

# Instala o PHP e os pacotes
RUN apk update && apk add --no-cache php82 php82-fpm php82-mysqli php82-json php82-curl \
    php82-dom php82-exif php82-fileinfo php82-mbstring php82-openssl php82-xml php82-zip \
    curl mariadb-client php82-phar

# 👉 ADICIONA ESTA LINHA: Cria o atalho para o php para o wp-cli funcionar
RUN ln -s /usr/bin/php82 /usr/bin/php

# Descarrega e instala o WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# ... (o resto do ficheiro fica igual)
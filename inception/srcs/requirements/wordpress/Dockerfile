FROM alpine:3.19

# Instala o PHP, as extensões necessárias para o WordPress e o cliente MariaDB
RUN apk update && apk add --no-cache php83 php83-fpm php83-mysqli php83-json php83-curl \
    php83-dom php83-exif php83-fileinfo php83-mbstring php83-openssl php83-xml php83-zip \
    curl mariadb-client php83-phar

# Descarrega e instala o WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Cria a diretoria web e ajusta os donos
RUN mkdir -p /var/www/html && chown -R nobody:nobody /var/www/html

# Copia as nossas configurações
COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./tools/wp_setup.sh /tmp/wp_setup.sh
RUN chmod +x /tmp/wp_setup.sh

# A diretoria de trabalho passa a ser a do volume partilhado
WORKDIR /var/www/html

# Expõe a porta para o NGINX falar com o PHP-FPM
EXPOSE 9000

ENTRYPOINT ["/tmp/wp_setup.sh"]
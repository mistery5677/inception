#!/bin/bash

# Gera o certificado SSL autoassinado se não existir
if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    echo "Gerando certificado SSL..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42/OU=Inception/CN=miafonso.42.fr"
fi

# Inicia o NGINX em primeiro plano (daemon off)
exec nginx -g 'daemon off;'
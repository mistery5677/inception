#!/bin/sh

# Generate the SSL certificates signed ... if they don't exist
if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    echo "Generating SSL certificates ..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42/OU=Inception/CN=miafonso.42.fr"
fi

# Start NGINX in first plan 
exec nginx -g 'daemon off;'
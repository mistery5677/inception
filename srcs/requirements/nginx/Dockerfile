FROM alpine:3.19

# Install NGINX and OpenSSL
RUN apk update && apk add --no-cache nginx openssl

# Criate the folder to save the SSL certificates 
RUN mkdir -p /etc/nginx/ssl

# Copy the inicialization script and configuration
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf
COPY ./tools/nginx_start.sh /var/www/nginx_start.sh

# Give permissions to execute the script
RUN chmod +x /var/www/nginx_start.sh

# Expose the port 443
EXPOSE 443

# Entry command
ENTRYPOINT ["/var/www/nginx_start.sh"]
FROM alpine:3.19

# Instala NGINX e OpenSSL
RUN apk update && apk add --no-cache nginx openssl

# Cria a pasta para guardar o certificado SSL
RUN mkdir -p /etc/nginx/ssl

# Copia o script de inicialização e a configuração
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf
COPY ./tools/nginx_start.sh /var/www/nginx_start.sh

# Dá permissão de execução ao script
RUN chmod +x /var/www/nginx_start.sh

# Expõe a porta 443
EXPOSE 443

# Comando de entrada
ENTRYPOINT ["/var/www/nginx_start.sh"]
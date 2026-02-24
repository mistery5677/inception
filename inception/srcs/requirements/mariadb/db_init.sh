#!/bin/sh

# Verifica se o banco de dados já foi inicializado
if [ ! -d "/var/lib/mysql/mysql" ]; then
    
    echo "Inicializando MariaDB..."
    # Instala as tabelas base do sistema
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Inicia o servidor temporariamente para criar usuários
    /usr/bin/mysqld_safe --datadir=/var/lib/mysql &
    
    # Espera o servidor subir
    sleep 5

    # Cria script SQL temporário para configuração
    cat << EOF > /tmp/init_db.sql
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
    
	# Executa o SQL
    mysql -u root --password="" < /tmp/init_db.sql
    
    # Para o servidor temporário de forma segura
    mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
    sleep 2
fi

echo "Iniciando MariaDB Safe..."
exec /usr/bin/mysqld_safe --datadir=/var/lib/mysql
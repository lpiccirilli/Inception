#!/bin/bash
set -e

mkdir -p /var/lib/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    echo "Database initialized."
fi

mysqld_safe --datadir=/var/lib/mysql &
PID=$!

until mariadb -u root -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 2
done

mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB_NAME}\`;
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root shutdown

exec mysqld_safe --datadir=/var/lib/mysql

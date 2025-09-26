#!/bin/bash
set -e

# Prepare data directory and permissions
mkdir -p /var/lib/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Initialize database if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    echo "Database initialized."
fi

# Start MariaDB in the background for initial setup
mysqld_safe --datadir=/var/lib/mysql &
PID=$!

# Wait for MariaDB to be ready
until mariadb -u root -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 2
done

# Create WordPress database and user if they don't exist
mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB_NAME}\`;
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop temporary instance
mysqladmin -u root shutdown

# Start MariaDB normally
exec mysqld_safe --datadir=/var/lib/mysql

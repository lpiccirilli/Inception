#!/bin/bash

mariadbd-safe --skip-networking &
pid="$!"

until mariadb -u root -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 2
done

# Create database
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB_NAME}\`;"

# Create user for both localhost and remote connections
mariadb -e "CREATE USER IF NOT EXISTS \`${WORDPRESS_DB_USER}\`@'localhost' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
mariadb -e "CREATE USER IF NOT EXISTS \`${WORDPRESS_DB_USER}\`@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"

# Grant privileges to both user instances
mariadb -e "GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO \`${WORDPRESS_DB_USER}\`@'localhost';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO \`${WORDPRESS_DB_USER}\`@'%';"

# Flush privileges before changing root password
mariadb -e "FLUSH PRIVILEGES;"

# Change root password (do this last)
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Final flush with new root password
mariadb -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Shutdown MariaDB service
mariadb-admin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Start MariaDB in safe mode
exec mariadbd-safe

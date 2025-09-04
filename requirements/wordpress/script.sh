#!/bin/bash

sleep 5s

# Change directory to the WordPress root directory
cd /var/www/html

# Download wp-cli.phar if not already present
if [ ! -f wp-cli.phar ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
fi

# Download WordPress core files if not already downloaded
if [ ! -d "wp-includes" ]; then
  ./wp-cli.phar core download --allow-root
fi

# Create wp-config.php file with database credentials
./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root

# Install WordPress with specified parameters
./wp-cli.phar core install --url=http://localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root

# Run PHP-FPM in the foreground
php-fpm8.4 -F

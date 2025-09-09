#!/bin/bash

sleep 5s

cd /var/www/html

if [ ! -f wp-cli.phar ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
fi

if [ ! -d "wp-includes" ]; then
  ./wp-cli.phar core download --allow-root
fi

./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root

./wp-cli.phar core install --url=https://lpicciri.42.fr --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root

php-fpm8.4 -F

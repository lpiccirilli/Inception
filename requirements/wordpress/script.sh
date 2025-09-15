#!/bin/bash

sleep 5s

cd /var/www/html

until nc -z "$WORDPRESS_DB_HOST" 3306; do
  echo "Waiting for MariaDB..."
  sleep 5
done


if [ ! -f wp-cli.phar ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
fi

if [ ! -d "wp-includes" ]; then
  ./wp-cli.phar core download --allow-root
fi

./wp-cli.phar config create --allow-root \
    --dbname=$WORDPRESS_DB_NAME \
    --dbuser=$WORDPRESS_DB_USER \
    --dbpass=$WORDPRESS_DB_PASSWORD \
    --dbhost=$WORDPRESS_DB_HOST:3306 \
    --path='/var/www/html'

./wp-cli.phar core install \
    --url=$DOMAIN_NAME/ \
	--title=$WP_SITE_TITLE \
    --admin_user=$WP_ADMIN_USR \
    --admin_password=$WP_ADMIN_PWD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email \
    --allow-root

/usr/sbin/php-fpm7.4 -F

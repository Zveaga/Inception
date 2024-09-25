#!/bin/bash

if [ ! -f ./wp-config.php ]; then 

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	sed -i "s/username_here/$DB_USER/g" wp-config-sample.php
	sed -i "s/password_here/$DB_USER_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$DB_HOST/g" wp-config-sample.php
	sed -i "s/database_name_here/$DB_NAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	chown -R www-data:www-data /var/www/html
	chmod -R 755 /var/www/html
	chown www-data:www-data wp-config.php
	chmod 644 wp-config.php

	wp core install --allow-root --url="$DOMAIN_NAME" --title=Inception \
        --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" --skip-email

	wp user create \
	--allow-root \
	"$WP_USER" \
	"$WP_USER_EMAIL" \
        --role=author \
	--user_pass="$WP_USER_PASSWORD"

fi

/usr/sbin/php-fpm7.4 -F

# cd /var/www/html
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# ./wp-cli.phar core download --allow-root
# # ./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=test --dbhost=mariadb --allow-root
# ./wp-cli.phar config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASS}" --dbhost="${DB_HOST}" --allow-root
# # ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
# ./wp-cli.phar core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASS}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root

# php-fpm8.2 -F
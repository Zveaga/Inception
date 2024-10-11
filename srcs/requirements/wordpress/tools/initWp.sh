#!/bin/bash

# if [ ! -e /var/www/html/$DOMAIN_NAME/.wordpress_setup_done ]; then	
# 	cd /var/www/html/$DOMAIN_NAME

# 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# 	mv wp-cli.phar /usr/local/bin/wp
# 	chmod +x /usr/local/bin/wp

#     chown -R www-data:www-data /var/www/html/$DOMAIN_NAME

# 	sleep 10
# 	until nc -z $DB_HOST $DB_PORT; do echo 'Waiting db...' >>output && sleep 5; done
#     # Download the WordPress core files
# 	wp core download --allow-root

# 	# Create the WordPress configuration file with the provided database credentials and host
# 	wp config create	--allow-root \
# 						--dbname="$DB_NAME" \
# 						--dbuser="$WP_USER" \
# 						--dbpass="$WP_USER_PASSWORD" \
# 						--dbhost="$DB_HOST:$DB_PORT"
	
# 	# Install WordPress with the provided site information and admin credentials
# 	wp core install	--allow-root \
# 					--url="https://$DOMAIN_NAME/" \
# 					--title="inception" \
# 					--admin_user="$WP_ADMIN" \
# 					--admin_password="$WP_ADMIN_PASSWORD" \
# 					--admin_email="$WP_ADMIN_EMAIL" \
# 					--skip-email

# 	# Create a new WordPress user with the provided credentials and role
# 	wp user create	"$WP_USER" "$WP_USER_EMAIL" \
# 					--allow-root  \
# 					--user_pass="$WP_USER_PASSWORD" \
# 					--role=author

#     touch .wordpress_setup_done
# fi

# exec "$@"



#!/bin/bash
if [ ! -f ./wp-config.php ]; then
	cd /var/www/html/$DOMAIN_NAME
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
	chown -R www-data:www-data /var/www/html/$DOMAIN_NAME
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

/usr/sbin/php-fpm8.2 -F

# cd /var/www/html
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# chmod +x wp-cli.phar
# ./wp-cli.phar core download --allow-root
# # ./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=test --dbhost=mariadb --allow-root
# ./wp-cli.phar config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASS}" --dbhost="${DB_HOST}" --allow-root
# # ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
# ./wp-cli.phar core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASS}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root

# php-fpm8.2 -F
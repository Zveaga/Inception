#!/bin/bash

echo "Starting WordPress setup..."

# if [ ! -f "/usr/local/bin/wp" ]; then
# if [ ! -f "/var/www/html/$DOMAIN_NAME/wp-config.php" ]; then
if [ ! -f "/var/www/html/$DOMAIN_NAME/.wp_setup_done" ]; then
	cd /var/www/html/$DOMAIN_NAME

	echo "Downloading WP-CLI..."
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	chmod +x /usr/local/bin/wp

    echo "Changing ownership of the WordPress directory..."
    chown -R www-data:www-data /var/www/html/$DOMAIN_NAME

	# echo "Waiting for database to be ready..."
	
	# sleep 10

	until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_USER_PASSWORD" -e "status" >/dev/null 2>&1; do
        echo "Waiting for MySQL to be ready..."
        sleep 5
    done

	# # Check database connectivity
	# until nc -z $DB_HOST $DB_PORT; do 
    #     echo 'Waiting for the database...'
    #     sleep 5 
    # done

    echo "Downloading WordPress core files..."
	wp core download --allow-root || { echo "Failed to download WordPress"; exit 1; }

	echo "Creating wp-config.php..."
	wp config create --allow-root \
						--dbname="$DB_NAME" \
						--dbuser="$DB_USER" \
						--dbpass="$DB_USER_PASSWORD" \
						--dbhost="$DB_HOST:$DB_PORT" || { echo "Failed to create wp-config.php"; exit 1; }
	
	echo "Installing WordPress..."
	wp core install --allow-root \
					--url="https://$DOMAIN_NAME/" \
					--title="inception" \
					--admin_user="$WP_ADMIN" \
					--admin_password="$WP_ADMIN_PASSWORD" \
					--admin_email="$WP_ADMIN_EMAIL" \
					--skip-email || { echo "Failed to install WordPress"; exit 1; }

	echo "Creating a new WordPress user..."
	wp user create "$WP_USER" "$WP_USER_EMAIL" \
					--allow-root  \
					--user_pass="$WP_USER_PASSWORD" \
					--role=author || { echo "Failed to create user $WP_USER"; exit 1; }

	# touch /var/www/html/$DOMAIN_NAME/.wp_setup_done
	touch .wp_setup_done
	echo "WordPress setup completed."
else
	echo "Wordpress is already installed!"
fi

exec "$@"


# if [ ! -f "/var/www/html/wp-config.php" ]; then
# 	echo "Installing wordpress from the $(whoami) user!"

# 	until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_USER_PASSWORD" -e "status" >/dev/null 2>&1; do
#         echo "Waiting for MySQL to be ready..."
#         sleep 5
#     done

# 	wp --allow-root core download --path=/var/www/html
# 	wp --allow-root config create --dbname=$DB_NAME \
# 									--dbuser=$DB_USER \
# 									--dbpass=$DB_USER_PASSWORD \
# 									--dbhost=$DB_HOST \
# 									--dbcharset='utf8'
# 	wp --allow-root core install --url=$DOMAIN_NAME \
# 								 --title=$WP_TITLE \
# 								 --admin_user=$WP_ADMIN \
# 								 --admin_email=$WP_ADMIN_EMAIL \
# 								 --admin_password=$WP_ADMIN_PASSWORD \
# 								 --allow-root

# 	wp user create "$WP_USER" raanghel@student.codam.nl \
# 								--path="/var/www/html" \
# 								--user_pass="$WP_USER_PASSWORD" \
# 								--allow-root
# else
# 	echo "Wordpress is installed!"
# fi

# exec "$@"
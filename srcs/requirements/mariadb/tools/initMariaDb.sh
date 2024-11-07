#!/bin/bash

cd /var/lib/mysql

# Check if the database is initialized
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    # Create the SQL initialization file if not exists
    if [ ! -f db.sql ]; then
        echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db.sql
        echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> db.sql
        echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> db.sql
        echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> db.sql
		echo "FLUSH PRIVILEGES;" >> db.sql
    fi

    # Start MariaDB in the background
    service mariadb start
    sleep 2

	# Set the root password (this ensures that the root user will require a password)
    # mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" || { echo "Failed to set root password"; exit 1; }

    # # Run the SQL commands
    mysql < db.sql || { echo "Failed to initialize database"; exit 1; }

	# Run the SQL commands to create the database and user
    # mysql -u root -p"$MYSQL_ROOT_PASSWORD" < db.sql || { echo "Failed to initialize database"; exit 1; }
fi

# Start mysqld_safe as the main process
exec mysqld_safe






# if [[ `service mariadb status | wc -l` == 1 ]]; then
#     service mariadb start

#     if [[ $? != 0 ]]; then
#         echo "error while starting mariadb"
#         exit 1
#     fi

#     sleep 5
# fi

# if [ ! -e "/var/lib/mysql/.mysql_setup_done" ]; then
#     mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
#     mysql -u root -e "CREATE USER '$WP_USER'@'%' IDENTIFIED BY '$WP_USER_PWD';"
#     mysql -u root -e "GRANT ALL ON $DB_NAME.* TO '$WP_USER'@'%';"
#     mysql -u root -e "FLUSH PRIVILEGES;"

#     touch /var/lib/mysql/.mysql_setup_done
# fi

# service mariadb stop

# exec "$@"
#!/bin/bash

cd /var/lib/mysql

# Check if the database is initialized
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    # Create the SQL initialization file if not exists
    if [ ! -f db.sql ]; then
        echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db.sql
        echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> db.sql
        echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> db.sql
        echo "FLUSH PRIVILEGES;" >> db.sql
    fi

    # Start MariaDB in the background
    service mariadb start
    sleep 2
    # Run the SQL commands
    mysql < db.sql || { echo "Failed to initialize database"; exit 1; }
fi

# Start mysqld_safe as the main process
exec mysqld

z#!/bin/bash

cd /var/lib/mysql

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

	if [ ! -f db.sql ]; then

		echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db.sql
		echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> db.sql
		echo "ALTER USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> db.sql
		echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> db.sql
		echo "FLUSH PRIVILEGES;" >> db.sql
	fi
	sleep 2

	service mariadb start
	mysql < db.sql

	sleep 2
	service mariadb stop
fi

# echo "Starting mysqld_safe" >> /var/log/initMariaDb.log
mysqld_safe


# #!/bin/bash

# cd /var/lib/mysql

# if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
#     if [ ! -f db.sql ]; then
#         echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db.sql
#         echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> db.sql
#         echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';" >> db.sql
#         echo "FLUSH PRIVILEGES;" >> db.sql
#     fi
    
#     # Wait a moment to ensure the service can start properly
#     sleep 2
    
#     # Start the service and wait for it to be fully up
#     service mariadb start
#     sleep 5  # Adjust the sleep duration as needed for initialization
    
#     # Execute the SQL commands
#     mysql < db.sql
    
#     # Stop the service
#     service mariadb stop
# fi

# # Start the MariaDB server
# mysqld_safe

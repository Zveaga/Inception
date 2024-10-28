#!/bin/bash
set -e

# Set permissions
chown -R mysql:mysql /var/lib/mysql
chmod 755 /var/lib/mysql
chmod 755 /run/mysqld

# Start MariaDB
exec mysqld

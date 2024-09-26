FROM debian:latest

RUN mkdir -p /run/mysqld

RUN apt update && apt upgrade -y && apt install -y mariadb-server

RUN chown -R mysql:mysql /run/mysqld

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# COPY init.sql /etc/mysql/init.sql

# COPY script.sh .

# RUN mkdir /run/mysqld && chmod 755 script.sh

# EXPOSE 3306

# CMD ["./script.sh"]
CMD ["mysqld_safe"]

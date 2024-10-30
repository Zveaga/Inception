FROM debian:latest

EXPOSE 3306

RUN apt update && apt install -y mariadb-server

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/initMariaDb.sh /initMariaDb.sh
COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /initMariaDb.sh /entrypoint.sh

ENTRYPOINT ["/initMariaDb.sh"]

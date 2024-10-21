FROM debian:bullseye

EXPOSE 3306

RUN mkdir -p /run/mysqld

RUN apt update && apt upgrade -y && apt install -y mariadb-server

RUN chown -R mysql:mysql /run/mysqld

RUN chmod 777 /run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/initMariaDb.sh /initMariaDb.sh

RUN chmod +x /initMariaDb.sh

# COPY init.sql /etc/mysql/init.sql

# COPY script.sh .

# RUN mkdir /run/mysqld && chmod 755 script.sh

ENTRYPOINT [ "/initMariaDb.sh" ]

CMD ["mysqld"]
# CMD ["mysqld_safe"]

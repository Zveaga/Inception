FROM debian:latest

# RUN apt update && apt upgrade -y && apt install -y php-fpm php-mysqli curl
RUN apt update && apt upgrade -y && apt install -y php-fpm

COPY /conf/www.conf /etc/php/8.2/fpm/pool.d/

# COPY script.sh .

# RUN chmod 755 script.sh

# CMD ["./script.sh"]
# CMD [ "php-fpm8.2", "-F" ]


CMD ["php-fpm8.2", "-F"]
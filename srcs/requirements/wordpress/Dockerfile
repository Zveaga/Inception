FROM debian:bullseye

EXPOSE	9000
EXPOSE	3306

ARG DOMAIN_NAME
ENV DOMAIN_NAME=$DOMAIN_NAME

# RUN apt update && apt upgrade -y && apt install -y \
# php-fpm \
# php-mysqli \
# curl \
# wget

# RUN apt install -y php8.2 php8.2-common php8.2-fpm php8.2-mysql php8.2-cgi php8.2-gd php8.2-xml mariadb-client wget curl

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
	mariadb-client \
	curl \
    php-cgi \
    php-common \
    php-fpm \
    php-pear \
    php-mbstring \
    php-zip \
    php-net-socket \
    php-gd \
    php-xml-util \
    php-mysql \
    php-bcmath \
    wget \
    netcat

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp


RUN mkdir -p /var/www/html/$DOMAIN_NAME

RUN mkdir -p /run/php
# RUN	mkdir /run/php

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

COPY ./tools/initWp.sh /usr/local/bin/

RUN	chmod +x /usr/local/bin/initWp.sh

ENTRYPOINT [ "/usr/local/bin/initWp.sh" ]

CMD [ "php-fpm7.4", "-F" ]

# RUN apt update && apt upgrade -y && apt install -y php-fpm php-mysqli curl
# COPY script.sh .
# RUN chmod 755 script.sh
# CMD ["./script.sh"]
# CMD [ "php-fpm8.2", "-F" ]
# EXPOSE 9000
# CMD ["php-fpm8.2", "-F"]








# FROM	debian:bullseye

# RUN	apt-get update && apt-get -y install \
# 	wget \
# 	curl \
# 	php7.4 \
# 	php7.4-fpm \
# 	php7.4-mysql \
# 	php7.4-pdo \
# 	php7.4-gd \
# 	php7.4-mbstring \
# 	&& rm -rf /var/lib/apt/lists/*

# RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
# 	&& chmod +x wp-cli.phar \
# 	&& mv wp-cli.phar /usr/local/bin/wp

# COPY	./requirements/wordpress/conf/www.conf /etc/php/7.4/fpm/pool.d

# RUN	mkdir /run/php

# COPY	./requirements/wordpress/tools/wordpress_setup.sh /usr/local/bin/

# RUN	chmod +x /usr/local/bin/wordpress_setup.sh

# EXPOSE	9000

# CMD ["/usr/local/bin/wordpress_setup.sh"]
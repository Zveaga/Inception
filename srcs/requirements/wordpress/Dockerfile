FROM debian:latest

RUN apt update && apt upgrade -y && apt install -y \
php-fpm \
php-mysqli \
curl \
wget

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/

# RUN	mkdir /run/php

COPY ./tools/initWp.sh /usr/local/bin/

RUN	chmod +x /usr/local/bin/initWp.sh

EXPOSE	9000

CMD ["/usr/local/bin/initWp.sh"]





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
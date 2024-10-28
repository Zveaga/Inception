FROM debian:bookworm

# Expose necessary ports
EXPOSE 9000
EXPOSE 3306

# Define domain name as build argument and environment variable
ARG DOMAIN_NAME
ENV DOMAIN_NAME=$DOMAIN_NAME

# Update package lists, upgrade installed packages, and install required packages
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        mariadb-client \
        curl \
        php8.2 \
        php8.2-common \
        php8.2-fpm \
        php8.2-mysql \
        php8.2-mbstring \
        php8.2-zip \
        php8.2-gd \
        php8.2-xml \
        php8.2-bcmath \
        wget \
		ncat

# Download wp-cli.phar, make it executable, and move it to the local bin
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create the necessary directory for the WordPress site
RUN mkdir -p /var/www/html/$DOMAIN_NAME

# Create the PHP run directory if it doesn't exist
RUN mkdir -p /run/php

# Copy PHP configuration for the FPM pool
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/

# Copy the WordPress initialization script
COPY ./tools/initWp.sh /usr/local/bin/

# Ensure the init script is executable
RUN chmod +x /usr/local/bin/initWp.sh

# Set the entrypoint to the initialization script
ENTRYPOINT ["/usr/local/bin/initWp.sh"]

# Start PHP-FPM when the container is run
CMD ["php-fpm8.2", "-F"]

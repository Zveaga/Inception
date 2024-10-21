FROM debian:bullseye

EXPOSE 443
EXPOSE 9000

ARG DOMAIN_NAME
ENV DOMAIN_NAME=$DOMAIN_NAME

RUN apt update && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /var/www/html/$DOMAIN_NAME

RUN mkdir -p /etc/nginx/ssl


# RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
# 				-out /etc/ssl/certs/raanghel.42.fr.crt \
# 				-keyout /etc/ssl/certs/raanghel.42.fr.key \
# 				-subj "/C=NL/ST=North-Holland/L=Amsterdam/O=Codam/OU=raanghel/CN=raanghel/"

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/ssl_cert.key -out /etc/nginx/ssl/ssl_cert.crt -subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=42/OU=Codam/CN=localhost"


# COPY default /etc/nginx/sites-available/
COPY default /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

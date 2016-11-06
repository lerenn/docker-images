FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Update distrib
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get update

# Install certbot and nginx
RUN apt-get install -y nginx dnsmasq
RUN apt-get install -y certbot -t jessie-backports

# Copy files
COPY docker /docker

# Copy configuration files
RUN cp /docker/config/nginx.conf /etc/nginx/ && \
    cp /docker/config/proxy.conf /etc/nginx/conf.d/

# Volumes
VOLUME /etc/nginx/sites-enabled
VOLUME /etc/letsencrypt

# Environment variables
ENV LETSENCRYPT_EMAIL none
ENV RSA_KEY_SIZE 4096
ENV STARTUP_WAIT 0

# Command
CMD ["bash", "/docker/scripts/entrypoint.sh" ]

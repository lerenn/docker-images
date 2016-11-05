FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Update distrib
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get update

# Install certbot and nginx
RUN apt-get install -y cron nginx dnsmasq
RUN apt-get install -y certbot -t jessie-backports

# Copy files
COPY docker /docker

# Copy configuration files
RUN cp /docker/config/nginx.conf /etc/nginx/ && \
    cp /docker/config/proxy.conf /etc/nginx/conf.d/

# Volumes
VOLUME /etc/nginx/sites-enabled

# Command
CMD ["bash", "/docker/scripts/entrypoint.sh" ]

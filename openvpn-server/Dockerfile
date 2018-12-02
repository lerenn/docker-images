FROM debian:stretch
MAINTAINER Louis Fradin <louis.fradin@gmail.com

# This image is adapted from the tutorial made by Nicolargo at
# http://blog.nicolargo.com/2010/10/installation-dun-serveur-openvpn-sous-debianubuntu.html
# to Debian jessie

# Copy files
COPY docker/ /docker

# Install system
RUN bash /docker/install/install.sh && \
    bash /docker/install/clean.sh

# Ports
EXPOSE 443

# Volumes
VOLUME /etc/openvpn

# Command and healthcheck
CMD ["bash", "/docker/scripts/entrypoint.sh"]
HEALTHCHECK CMD [ "$(curl -I -q localhost:443 | grep 400 | wc -l)" == 1 ] || exit 1

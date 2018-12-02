FROM debian:stretch
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Update System
RUN apt-get update && apt-get upgrade -y

# Requirements installation
RUN apt-get install -y transmission-daemon ssh openssh-server whois sudo apache2 curl

# Copy files
COPY docker /docker

# Configuration
RUN bash /docker/scripts/static-configuration.sh && \
  cp /docker/configurations/sshd_config /etc/ssh/sshd_config && \
  addgroup sftp && touch /var/log/transmission.log

# Create Volume
VOLUME /data

# Environment variables
ENV PEER_PORT=51413 USERNAME=admin PASSWORD=admin RATIO_LIMIT=999999

# Ports
EXPOSE 22 80 9091

# Command
CMD [ "bash", "/docker/scripts/entrypoint.sh" ]
HEALTHCHECK CMD [ "$(curl -I -q localhost:9091 | grep 401 | wc -l)" == 1 ] || exit 1

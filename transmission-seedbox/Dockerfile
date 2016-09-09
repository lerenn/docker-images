FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Update System
RUN apt-get update && apt-get upgrade -y

# Requirements installation
RUN apt-get install transmission-daemon ssh openssh-server whois -y
RUN apt-get install sudo -y

# Create Volume
VOLUME /data

# Environment variables
ENV PEER_PORT=51413 USERNAME=admin PASSWORD=admin RATIO_LIMIT=999999

# Ports
EXPOSE 22 9091

# Command
CMD [ "bash", "/docker/scripts/entrypoint.sh" ]

# Copy files
COPY docker /docker

# Configuration
RUN cp /docker/configurations/sshd_config /etc/ssh/sshd_config && \
    addgroup sftp && touch /var/log/transmission.log

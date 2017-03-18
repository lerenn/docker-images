FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Update system
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y openssh-server whois -y

# Copy data
COPY docker /docker
RUN chmod +x /docker/scripts/* && \
    addgroup sftp && \
    touch /var/log/auth.log && \
    cp /docker/config/sshd_config /etc/ssh/sshd_config

# Volumes
VOLUME /docker/authorized_keys

# Ports
EXPOSE 22

# Command
CMD /docker/scripts/docker-entrypoint.sh

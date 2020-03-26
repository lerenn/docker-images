FROM centos:8
MAINTAINER Louis FRADIN <louis.fradin@gmail.com>

# Install fold-at-home
RUN dnf install -y https://download.foldingathome.org/releases/public/release/fahclient/centos-6.7-64bit/v7.5/latest.rpm

# Copy data
COPY docker /docker

# Volumes
VOLUME /var/lib/fahclient

# Environment variables
ENV USERNAME Anonymous
ENV TEAM 0
ENV POWER medium
ENV PASSKEY none

# Port
EXPOSE 36330

# Command
CMD ["bash", "/docker/scripts/entrypoint.sh" ]
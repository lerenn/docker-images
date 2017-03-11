FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install requirements
RUN apt-get update \
  && apt-get install -y rsync cron openssh-client

# Environment variables
ENV BACKUP_DIR " "
ENV CRON_SCHEME "0 3 * * *"

# Volumes
VOLUME /backup
VOLUME /keys

# Copy files
COPY docker /docker

# Command
CMD [ "bash", "/docker/scripts/entrypoint.sh"]

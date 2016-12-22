FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install requirements
RUN apt-get update && apt-get install -y curl cron cadaver

# Prepare files
RUN mkdir /var/archives && \
    touch /var/log/cron.log

# Variables
ENV BOX_EMAIL ""
ENV BOX_PASSWORD ""
ENV ENCRYPTION false
ENV ENCRYPTION_PASSWORD ""
ENV SPLIT false
ENV SPLIT_SIZE 500M
ENV BACKUP_NBR -1
ENV DESTINATION_FOLDER Test
ENV CRON true
ENV CRON_SCHEME "0 3 * * *"

# Volume
VOLUME /data

# Command
CMD ["bash", "/docker/scripts/entrypoint.sh"]

# Copy files
COPY docker /docker

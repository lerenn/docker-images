FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install requirements
RUN apt-get update
RUN apt-get install -y cadaver
RUN apt-get install -y cron

# Prepare files
RUN mkdir /var/archives && \
    touch /var/log/cron.log

# Variables
ENV BOX_EMAIL ""
ENV BOX_PASSWORD ""
ENV ENCRYPTION false
ENV ENCRYPTION_PASSWORD ""
ENV BACKUP_NBR 0
ENV DESTINATION_FOLDER Test
ENV CRON_SCHEME "0 3 * * *"

# Volume
VOLUME /data

# Command
CMD ["bash", "/docker/scripts/entrypoint.sh"]

# Copy files
COPY docker /docker

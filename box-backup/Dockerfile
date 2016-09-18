FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install requirements
RUN apt-get update
RUN apt-get install -y cadaver

# Prepare files
RUN mkdir /var/archives

# Variables
ENV BOX_EMAIL ""
ENV BOX_PASSWORD ""
ENV ENCRYPTION false
ENV ENCRYPTION_PASSWORD ""
ENV BACKUP_NBR 0
ENV DESTINATION_FOLDER Test

# Volume
VOLUME /data

# Command
CMD ["bash", "/docker/scripts/entrypoint.sh"]

# Copy files
COPY docker /docker

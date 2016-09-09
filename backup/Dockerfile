FROM alpine
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install requirements
RUN apk update
RUN apk add rsync bash openssh

# Environment variables
ENV BACKUP_PERIOD 24
ENV BACKUP_DIR ""

# Volumes
VOLUME /backup
VOLUME /keys

# Copy files
COPY docker /docker

# Command
CMD [ "bash", "/docker/scripts/entrypoint.sh"]

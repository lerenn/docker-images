FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Copy files
COPY docker/ /docker

# Install
RUN bash /docker/install/install.sh && \
    bash /docker/install/clean.sh

# Ports
EXPOSE 27017

# Command
CMD [ "bash", "/docker/scripts/entrypoint.sh" ]

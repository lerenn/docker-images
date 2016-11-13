FROM alpine
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install requirements
RUN apk update
RUN apk add wget git tar rsync bash

# Install hugo
RUN wget https://github.com/spf13/hugo/releases/download/v0.17/hugo_0.17_linux-64bit.tgz && \
    mkdir -p /tmp/hugo && \
    tar -C /tmp/hugo -xvzf hugo_0.17_linux-64bit.tgz && \
    mv /tmp/hugo/hugo /bin && \
    rm -rf /tmp/hugo hugo_0.17_linux-64bit.tgz

# Environment variables
ENV CONFIG_FILE "config.toml"
ENV PERIOD 10
ENV PUBLISH_DIR "public"
ENV REPO_LINK ""
ENV BASE_URL "localhost"

# Ports
EXPOSE 80

# Copy files
COPY docker/ /docker

# Command
CMD ["bash", "/docker/scripts/entrypoint.sh"]

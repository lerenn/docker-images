FROM alpine
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install requirements
RUN apk update
RUN apk add wget git tar rsync bash

# Install hugo
RUN wget https://github.com/spf13/hugo/releases/download/v0.17/hugo_0.17_Linux-64bit.tar.gz && \
    tar -C /tmp -xvzf hugo_0.17_Linux-64bit.tar.gz && \
    mv /tmp/hugo_0.17_linux_amd64/hugo_0.17_linux_amd64 /bin/hugo && \
    chmod +x /bin/hugo && \
    rm -rf /tmp/hugo* hugo*

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

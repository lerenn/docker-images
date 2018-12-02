FROM debian:stretch
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Updating system
RUN apt-get update && apt-get upgrade -y

# Installation of nginx
RUN apt-get install -y nginx wget git tar curl

# Install hugo
RUN wget https://github.com/spf13/hugo/releases/download/v0.17/hugo_0.17_Linux-64bit.tar.gz && \
    tar -C /tmp -xvzf hugo_0.17_Linux-64bit.tar.gz && \
    mv /tmp/hugo_0.17_linux_amd64/hugo_0.17_linux_amd64 /bin/hugo && \
    chmod +x /bin/hugo && \
    rm -rf /tmp/hugo* hugo*

# Copy files
COPY docker/ /docker

# Add default config
RUN sed -i '/^\troot/aerror\_page 404 \= \/404\.html;' /etc/nginx/sites-enabled/default

# Environment variables
ENV CONFIG_FILE "config.toml"
ENV PERIOD 10
ENV REPO_LINK ""

# Ports
EXPOSE 80

# Command and healthcheck
CMD ["bash", "/docker/scripts/entrypoint.sh"]
HEALTHCHECK CMD curl --fail http://localhost || exit 1

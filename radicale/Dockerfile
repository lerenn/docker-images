FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install pre-requis
RUN apt-get update && \
    apt-get install python2.7 python-pip -y

# Install radicale
RUN pip install radicale

# Create volume for data
VOLUME /data

# Ports
EXPOSE 5232

# Copy files
COPY docker /docker

# Command
CMD ["bash", "/docker/scripts/entrypoint.sh"]

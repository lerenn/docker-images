FROM ubuntu:16.04
MAINTAINER Louis FRADIN <louis.fradin@gmail.com>

# Requirements
RUN apt-get update && \
  apt-get install -qq --no-install-recommends -y wget gnupg ca-certificates && \
  rm -r /var/lib/apt/lists/*

# Install minergate-cli
RUN wget -q --content-disposition https://minergate.com/download/deb-cli && \
  dpkg -i *.deb && \
  rm *.deb
COPY entrypoint.sh /entrypoint.sh

# Environment variables
ENV USER "louis.fradin@gmail.com"
ENV CURRENCY "xmr"

CMD [ "bash", "/entrypoint.sh" ]

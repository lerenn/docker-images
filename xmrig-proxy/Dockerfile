FROM ubuntu:xenial
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install tools
RUN apt update && apt install -y wget

# Install XMRig-proxy
RUN wget https://github.com/xmrig/xmrig-proxy/releases/download/v2.9.1/xmrig-proxy-2.9.1-xenial-x64.tar.gz && \
  tar xvf xmrig-proxy-2.9.1-xenial-x64.tar.gz && \
  rm xmrig-proxy-2.9.1-xenial-x64.tar.gz && \
  mv xmrig-proxy-2.9.1/ /xmrig-proxy/ && \
  rm /xmrig-proxy/config.json

# Add workdir to xmrig-proxy
WORKDIR xmrig-proxy

# Environment variables
ENV POOL ""
ENV USERNAME ""
ENV PASSWORD "x"
ENV MODE "nicehash"
ENV DONATE_LEVEL 2

# CMD
COPY entrypoint.sh .
CMD [ "bash", "entrypoint.sh" ]

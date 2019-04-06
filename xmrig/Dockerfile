FROM ubuntu:xenial
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# Install tools
RUN apt update && apt install -y wget

# Install XMRig
RUN wget https://github.com/xmrig/xmrig/releases/download/v2.14.1/xmrig-2.14.1-xenial-x64.tar.gz && \
  tar xvf xmrig-2.14.1-xenial-x64.tar.gz && \
  rm xmrig-2.14.1-xenial-x64.tar.gz && \
  mv xmrig-2.14.1/ /xmrig/ && \
  rm /xmrig/config.json

# Add workdir to xmrig
WORKDIR xmrig

# Environment variables
ENV POOL ""
ENV USERNAME ""
ENV PASSWORD "x"
ENV THREADS 1
ENV DONATE_LEVEL 5

# CMD
COPY entrypoint.sh .
CMD [ "bash", "entrypoint.sh" ]

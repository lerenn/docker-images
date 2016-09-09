FROM debian:jessie
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# System update
RUN apt-get update && apt-get upgrade -y

# Requirements installation
RUN apt-get install sudo openssh-server whois -y

# OpenSSH configuration
RUN sed -Ei 's/^PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config

# Launch script configuration
COPY start.sh /
RUN chmod +x /start.sh

# Environment variables
ENV USERNAME admin
ENV PASSWORD admin

EXPOSE 22
CMD /start.sh

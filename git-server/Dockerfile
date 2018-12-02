FROM debian:stretch
MAINTAINER Louis Fradin <louis.fradin@gmail.com>

# System Update
RUN apt-get update && apt-get upgrade -y

# Installation of ZSH
# Go here for more informations (http://formation-debian.via.ecp.fr/shell.html)
RUN apt-get install zsh wget -y
RUN wget http://formation-debian.via.ecp.fr/fichiers-config/zshrc
RUN wget http://formation-debian.via.ecp.fr/fichiers-config/zshenv
RUN wget http://formation-debian.via.ecp.fr/fichiers-config/zlogin
RUN wget http://formation-debian.via.ecp.fr/fichiers-config/zlogout
RUN wget http://formation-debian.via.ecp.fr/fichiers-config/dir_colors
RUN mv zshrc zshenv zlogin zlogout /etc/zsh/
RUN mv dir_colors /etc/

# Requirements
RUN apt-get install openssh-server -y
RUN sed -Ei "s/^PermitRootLogin.*/PermitRootLogin no/" /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

# Git install
RUN apt-get install git -y
RUN adduser --system --shell /bin/zsh --group --disabled-password --home /var/git/ git
RUN chown git:git /var/git

# Init script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

# Copy tools
COPY tools/create-repository.sh /bin/create-repository
RUN chmod +x /bin/create-repository
COPY tools/delete-repository.sh /bin/delete-repository
RUN chmod +x /bin/delete-repository

# Volumes
VOLUME /var/git

# Ports
EXPOSE 22

# Command
CMD /docker-entrypoint.sh

#!/bin/bash
USERNAME=$1
PASSWORD=$2

# Add user for ftp
if [ "$PASSWORD" != "" ]; then
  ENCRYPT_PASSWORD=`mkpasswd --method=SHA-512 $PASSWORD`
  useradd $USERNAME -p $ENCRYPT_PASSWORD -m
else
  useradd $USERNAME -m
fi
adduser $USERNAME sftp

# Change directory infos
chown root:root /home/$USERNAME
mkdir -p /home/$USERNAME/data
chown $USERNAME:$USERNAME /home/$USERNAME/data

# Check certificate
if [ -f /docker/authorized_keys/$USERNAME ]; then
  mkdir -p /home/$USERNAME/.ssh
  cp /docker/authorized_keys/$USERNAME /home/$USERNAME/.ssh/authorized_keys
  chmod 600 /home/$USERNAME/.ssh/authorized_keys
  chown $USERNAME:$USERNAME /home/$USERNAME/.ssh/authorized_keys
fi

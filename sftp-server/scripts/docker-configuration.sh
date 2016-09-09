#!/bin/bash

# Add user for ftp
ENCRYPT_PASSWORD=`mkpasswd --method=SHA-512 $PASSWORD`
useradd $USERNAME -p $ENCRYPT_PASSWORD --no-create-home --home-dir /server
adduser $USERNAME sftp
chown -R $USERNAME:$USERNAME /server/data

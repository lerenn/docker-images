#!/bin/bash

# Verificaton of the initialisation of the home
if [ -f "/var/git/.ssh)" ]; then
     echo "The directory .ssh exists. Nothing to do."
else
    echo "The directory .ssh doesn't exist, generating files..."

    # Creating authorized_keys file
    mkdir /var/git/.ssh
    touch /var/git/.ssh/authorized_keys

    echo "Done."
fi

# Rights
chmod 755 /var/git/.ssh
chmod 644 /var/git/.ssh/authorized_keys
chown -R git:git /var/git

# Launching open-ssh server
/usr/sbin/sshd -D

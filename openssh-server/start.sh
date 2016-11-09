#!/bin/bash

# Add the user to ssh
encryptedPassword=`mkpasswd --method=SHA-512 $PASSWORD`
useradd -m -s /bin/bash -p $encryptedPassword $USERNAME

# Add as sudo user
if [ "$SUDO" == "yes" ]; then
  adduser $USERNAME sudo
fi

# Create the PrivSep empty dir if necessary
if [ ! -d /var/run/sshd ]; then
  mkdir /var/run/sshd
  chmod 0755 /var/run/sshd
fi

# Launch the ssh server
/usr/sbin/sshd -D

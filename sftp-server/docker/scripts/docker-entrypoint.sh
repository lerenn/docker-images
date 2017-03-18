#!/bin/bash

# Check if authorized_keys for root exists
if [ -f /docker/authorized_keys/root ]; then
  mkdir -p /root/.ssh/
  cp /docker/authorized_keys/root /root/.ssh/authorized_keys
  chmod 600 /root/.ssh/authorized_keys
  chown root:root /root/.ssh/authorized_keys
fi

# Launch config script
i=1
un=USERNAME1
pw=PASSWORD1
while [ "${!un}" ]; do
  # Add user/password
  /docker/scripts/adduser.sh ${!un} ${!pw}

  # Next username
  i=$((i+1))
  un="USERNAME$i"
  pw="PASSWORD$i"
done

# Launching service
service ssh start

# See logs
tail -f /var/log/auth.log

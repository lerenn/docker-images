#!/bin/bash

echo "Copy keys and set rights"
mkdir /root/.ssh
cp /keys/* /root/.ssh
chown -R root:root /root/.ssh
chmod 600 /root/.ssh/id_rsa

# Launch backup
while [ true ]; do
  bash /docker/scripts/backup.sh
  sleep $(($BACKUP_PERIOD*60*60))
done

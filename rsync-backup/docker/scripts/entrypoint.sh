#!/bin/bash

# Copy keys and set rights
mkdir -p /root/.ssh
cp /keys/* /root/.ssh
chown -R root:root /root/.ssh
chmod 600 /root/.ssh/id_rsa

# Prepare var file
mkdir -p /docker/data
echo "BACKUP_DIR=${BACKUP_DIR}" >> /docker/data/vars.sh

# Prepare cron
CRON_SCHEME=${CRON_SCHEME//\"}
echo "${CRON_SCHEME} root bash /docker/scripts/backup.sh >> /var/log/cron.log 2>&1" >> /etc/cron.d/backup
chmod 0644 /etc/cron.d/backup

# Launch cron tab
touch /var/log/cron.log
cron && tail -f /var/log/cron.log

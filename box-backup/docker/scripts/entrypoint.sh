#!/bin/bash

# Check variables
if [ "$BOX_EMAIL" == "" ]; then echo "Please provide a username for your box account"; exit; fi
if [ "$BOX_PASSWORD" == "" ]; then echo "Please provide a password for your box account"; exit; fi

# Prepare file
rm -f ~/.netrc
echo "default" >> ~/.netrc
echo "login $BOX_EMAIL" >> ~/.netrc
echo "password $BOX_PASSWORD" >> ~/.netrc
chmod 600 ~/.netrc

# Create var file
echo "ENCRYPTION=${ENCRYPTION}" >> /docker/data/vars.sh
echo "ENCRYPTION_PASSWORD=${ENCRYPTION_PASSWORD}" >> /docker/data/vars.sh
echo "BACKUP_NBR=${BACKUP_NBR}" >> /docker/data/vars.sh
echo "DESTINATION_FOLDER=${DESTINATION_FOLDER}" >> /docker/data/vars.sh
chmod 600 /docker/data/vars.sh

# Create cron file
echo "${CRON_SCHEME} root bash /docker/scripts/backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/box-backup
chmod 0644 /etc/cron.d/box-backup

# Make backup
bash /docker/scripts/backup.sh
echo "Reading logs..."
#cron && tail -f /var/log/cron.log

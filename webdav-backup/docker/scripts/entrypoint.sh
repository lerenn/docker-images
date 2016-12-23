#!/bin/bash

# Check variables
if [ "$WEBDAV_HOST" == "" ]; then echo "Please provide a host for the webdav operations"; exit; fi
if [ "$WEBDAV_USERNAME" == "" ]; then echo "Please provide a username for the webdav operations"; exit; fi
if [ "$WEBDAV_PASSWORD" == "" ]; then echo "Please provide a password for the webdav operations"; exit; fi

# Eliminates quotes from some variables
CRON_SCHEME=${CRON_SCHEME//\"}
TIMEOUT=${TIMEOUT//\"}

# Prepare file
rm -f ~/.netrc
echo "default" >> ~/.netrc
echo "login $WEBDAV_USERNAME" >> ~/.netrc
echo "password $WEBDAV_PASSWORD" >> ~/.netrc
chmod 600 ~/.netrc

# Create var file
echo "WEBDAV_HOST=${WEBDAV_HOST}" >> /docker/data/vars.sh
echo "WEBDAV_USERNAME=${WEBDAV_USERNAME}" >> /docker/data/vars.sh
echo "WEBDAV_PASSWORD=${WEBDAV_PASSWORD}" >> /docker/data/vars.sh
echo "ENCRYPTION=${ENCRYPTION}" >> /docker/data/vars.sh
echo "ENCRYPTION_PASSWORD=${ENCRYPTION_PASSWORD}" >> /docker/data/vars.sh
echo "SPLIT=${SPLIT}" >> /docker/data/vars.sh
echo "SPLIT_SIZE=${SPLIT_SIZE}" >> /docker/data/vars.sh
echo "BACKUP_NBR=${BACKUP_NBR}" >> /docker/data/vars.sh
echo "DESTINATION_FOLDER=${DESTINATION_FOLDER}" >> /docker/data/vars.sh
echo "TIMEOUT=${TIMEOUT}" >> /docker/data/vars.sh
chmod 600 /docker/data/vars.sh

# Create cron file
echo "${CRON_SCHEME} root bash /docker/scripts/backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/webdav-backup
chmod 0644 /etc/cron.d/webdav-backup

# Make backup
if [ ${CRON} == false ]; then
  bash /docker/scripts/backup.sh
else
  echo "Reading logs..."
  cron && tail -f /var/log/cron.log
fi

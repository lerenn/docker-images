#!/bin/bash

# Variables
NOW=`date +%Y%m%d_%H%M%S`
ARCHIVE_DIR=/var/archives
ARCHIVE_NAME=backup_${NOW}.tar.gz
BOX_ADDRESS=https://dav.box.com/dav

# Get others variables
. /docker/data/vars.sh

echo "#--------------# Start Backup #--------------#"

# Compress data
################################################################################
echo "### Compress data"
tar -czf ${ARCHIVE_DIR}/${ARCHIVE_NAME} /data

# Encrypt (if enabled)
################################################################################
if [ ${ENCRYPTION} ]; then
  echo "### Encryption"

  # Encryption
  echo ${ENCRYPTION_PASSWORD} | gpg --quiet --passphrase-fd 0 --command-fd 0 --status-fd 1 --no-tty --yes -o ${ARCHIVE_DIR}/${ARCHIVE_NAME}.gpg -c ${ARCHIVE_DIR}/${ARCHIVE_NAME}

  # Change archive name
  ARCHIVE_NAME=${ARCHIVE_NAME}.gpg
fi

# Send data
################################################################################
echo "### Transfert data"
cadaver ${BOX_ADDRESS} <<EOF
mkcol ${DESTINATION_FOLDER}
put ${ARCHIVE_DIR}/${ARCHIVE_NAME} ${DESTINATION_FOLDER}/${ARCHIVE_NAME}
EOF

# Clean
rm -rf /var/archives/*

echo "#--------------# End Backup #--------------#"

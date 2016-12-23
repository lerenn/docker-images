#!/bin/bash

# Get others variables
. /docker/data/vars.sh
. /docker/data/fixed-vars.sh

echo "#--------------# Start Backup #--------------#"

# Clean
################################################################################
rm -rf /var/archives/*

# Prepare data
################################################################################

echo "### Prepare data"
if [ ${ENCRYPTION} == true ] && [ ${SPLIT} == true ]; then
  echo "Encryption and split activated"
  ARCHIVE_NAME="${ARCHIVE_NAME}.gpg.part-"
  tar -czf - /data | gpg -c --passphrase "${ENCRYPTION_PASSWORD}" | split -b ${SPLIT_SIZE} - "${ARCHIVE_DIR}/${ARCHIVE_NAME}"
elif [ ${ENCRYPTION} == true ]; then
  echo "Encryption activated"
  ARCHIVE_NAME="${ARCHIVE_NAME}.gpg"
  tar -czf - /data | gpg -c --passphrase "${ENCRYPTION_PASSWORD}" -o "${ARCHIVE_DIR}/${ARCHIVE_NAME}"
elif [ ${SPLIT} == true ]; then
  echo "Split activated"
  ARCHIVE_NAME="${ARCHIVE_NAME}.part-"
  tar -czf - /data | split -b ${SPLIT_SIZE} - "${ARCHIVE_DIR}/${ARCHIVE_NAME}"
else
  echo "No supplement treatment activated"
  tar -czf "${ARCHIVE_DIR}/${ARCHIVE_NAME}" /data
fi

# Create to indicate the end
sleep 1 # Avoid same timestamp
touch "${ARCHIVE_DIR}/end.txt"

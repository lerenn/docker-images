#!/bin/bash

# Variables
NOW=`date +%Y%m%d-%H%M%S`
ARCHIVE_DIR=/var/archives
ARCHIVE_NAME=backup-${NOW}.tar.gz
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

# Delete old backups
################################################################################
if [[ $BACKUP_NBR > 0 ]]; then
  echo "### Delete oldest backups"

  # Get list of files
INFOS=`cadaver ${BOX_ADDRESS} <<EOF
ls ${DESTINATION_FOLDER}
EOF`

  # Clean list of files
  test='\bbackup\-[[:alpha:]]*\b'
  files=(`echo $INFOS | tr '[[:space:]]' '\n' | grep "^$test"`)

  # Get files to delete
  i=0
  NBR_FILES=${#files[@]}
  FILES_TO_DELETE=()
  for var in "${files[@]}"; do
    if [[ $(( NBR_FILES - i )) > $BACKUP_NBR ]]; then
      FILES_TO_DELETE+=($var)
    fi
    i=$((i+1))
  done
  echo "Files to delete : ${FILES_TO_DELETE[@]}"

  # Delete oldest files
  for var in "${FILES_TO_DELETE[@]}"; do
cadaver ${BOX_ADDRESS} <<EOF
delete ${DESTINATION_FOLDER}/${var}
EOF
  done
fi

# Clean
################################################################################
rm -rf /var/archives/*

echo "#--------------# End Backup #--------------#"

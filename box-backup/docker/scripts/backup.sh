#!/bin/bash

# Variables
NOW=`date +%Y%m%d-%H%M%S`
ARCHIVE_DIR=/var/archives
ARCHIVE_NAME="backup-${NOW}.tar.gz"
BOX_ADDRESS=https://dav.box.com/dav
BACKUP_DIR="backup-${NOW}"

# Get others variables
. /docker/data/vars.sh

echo "#--------------# Start Backup #--------------#"

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

ARCHIVE_DATA=`ls "${ARCHIVE_DIR}"`
echo "Created files:"
echo "${ARCHIVE_DATA}"

# Send data
################################################################################
echo "### Transfert data to ${DESTINATION_FOLDER}/${BACKUP_DIR}"

# Create directories
path=""
directories=$(echo "${DESTINATION_FOLDER}/${BACKUP_DIR}" | tr "/" "\n")
for dir in ${directories}
do
  path="${path}${dir}/"
  cadaver ${BOX_ADDRESS} <<EOF
mkcol ${path}
EOF
done

# Transfer data
for file in ${ARCHIVE_DATA}
do
  cadaver ${BOX_ADDRESS} <<EOF
put ${ARCHIVE_DIR}/${file} ${DESTINATION_FOLDER}/${BACKUP_DIR}/${file}
EOF
done

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
rmcol ${DESTINATION_FOLDER}/${var}
EOF
  done
fi

# Clean
################################################################################
rm -rf /var/archives/*

echo "#--------------# End Backup #--------------#"

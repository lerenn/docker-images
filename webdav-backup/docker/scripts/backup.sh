#!/bin/bash

# Get others variables
. /docker/data/vars.sh

# Variables
NOW=`date +%Y%m%d-%H%M%S`
ARCHIVE_DIR=/var/archives
ARCHIVE_NAME="backup-${NOW}.tar.gz"
BACKUP_DIR="backup-${NOW}"
BACKUP_DIST_DIR="${WEBDAV_HOST}/${DESTINATION_FOLDER}/${BACKUP_DIR}"

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
echo "### Transfert data to ${BACKUP_DIST_DIR}"

# Create directories
NEW_PATH=""
directories=$(echo "${DESTINATION_FOLDER}/${BACKUP_DIR}" | tr "/" "\n")
for dir in ${directories}; do
  NEW_PATH="${NEW_PATH}${dir}/"
  echo "Create ${NEW_PATH}"
  SUCCESS=1
	until [  ${SUCCESS} -eq 0 ]; do
    curl -sS --user "${WEBDAV_USERNAME}:${WEBDAV_PASSWORD}" -m ${TIMEOUT} \
         -X MKCOL "${WEBDAV_HOST}/${NEW_PATH}"
    SUCCESS=$?
  done
done

# Transfer data
for file in ${ARCHIVE_DATA}; do
  echo "Transfert ${file}"
	SUCCESS=1
	until [  ${SUCCESS} -eq 0 ]; do
    curl -sS --user "${WEBDAV_USERNAME}:${WEBDAV_PASSWORD}" -m ${TIMEOUT} \
         -T "${ARCHIVE_DIR}/${file}" "${BACKUP_DIST_DIR}/"
		SUCCESS=$?
	done
done

# Delete old backups
################################################################################
if [[ $BACKUP_NBR > 0 ]]; then
  echo "### Delete oldest backups"

  # Get list of files
INFOS=`cadaver ${WEBDAV_HOST} <<EOF
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
    DELETED_DIR="${WEBDAV_HOST}/${DESTINATION_FOLDER}/${var}"
    echo "Delete ${DELETED_DIR}"
  	SUCCESS=1
  	until [  ${SUCCESS} -eq 0 ]; do
      curl -sS --user "${WEBDAV_USERNAME}:${WEBDAV_PASSWORD}" -m ${TIMEOUT} \
           -X DELETE "${DELETED_DIR}"
      SUCCESS=$?
    done
  done
fi

# Clean
################################################################################
rm -rf /var/archives/*

echo "#--------------# End Backup #--------------#"

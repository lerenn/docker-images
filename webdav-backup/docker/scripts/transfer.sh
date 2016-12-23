#!/bin/bash

# Get others variables
. /docker/data/vars.sh
. /docker/data/fixed-vars.sh

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

STOP=false
until [ "${STOP}" == "true" ]; do
  NBR_FILES=`ls -1 ${ARCHIVE_DIR} | wc -l`
  file=`ls -t ${ARCHIVE_DIR} | tail -n 1`

  if [ "${NBR_FILES}" -ge "2" ]; then
    # Transfer data
    echo "Transfert ${file}"
  	SUCCESS=1
  	until [  ${SUCCESS} -eq 0 ]; do
      curl -sS --user "${WEBDAV_USERNAME}:${WEBDAV_PASSWORD}" -m ${TIMEOUT} \
           -T "${ARCHIVE_DIR}/${file}" "${BACKUP_DIST_DIR}/"
  		SUCCESS=$?
  	done

    # Delete file
    rm -f "${ARCHIVE_DIR}/${file}"
  elif [ "${file}" == "end.txt" ]; then
    echo "End"
    STOP=true
  else
    echo -n "."
    sleep 1
  fi
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

echo "#--------------# End Backup #--------------#"

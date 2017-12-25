#!/bin/bash

# Include vars
. /docker/data/vars.sh

# Backup
echo "[`date`] Backup starting to ${BACKUP_DIR}"
echo "`date`" > /backup/backup.log
rsync --archive --delete-before -v -e "ssh -o StrictHostKeyChecking=no" /backup/ ${BACKUP_DIR}
echo "[`date`] Backup done"

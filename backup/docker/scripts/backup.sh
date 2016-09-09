#!/bin/bash
echo "[`date`] Backup starting."
mkdir -p /backup
rsync --archive --delete-before -e "ssh -o StrictHostKeyChecking=no" $BACKUP_DIR /backup/
echo "[`date`] Backup done."

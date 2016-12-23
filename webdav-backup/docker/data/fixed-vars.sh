#!/bin/bash

NOW=`date +%Y%m%d-%H%M%S`
ARCHIVE_DIR=/var/archives
ARCHIVE_NAME="backup-${NOW}.tar.gz"
BACKUP_DIR="backup-${NOW}"
BACKUP_DIST_DIR="${WEBDAV_HOST}/${DESTINATION_FOLDER}/${BACKUP_DIR}"

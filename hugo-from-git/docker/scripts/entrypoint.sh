#!/bin/bash

# Load functions
. /docker/scripts/functions.sh

echo "Check requirements"
if [ "$REPO_LINK" == "" ]; then echo "Please fill environment variable REPO_LINK"; exit; fi

echo "First download"
mkdir -p /var/www/html
Update

echo "Launch synchronization"
bash /docker/scripts/synchronize.sh &

echo "Display hugo website"
cd /var/www/html
hugo server -w -v --disableLiveReload --port 80 --config=$CONFIG_FILE --baseURL $BASE_URL --bind $HOSTNAME

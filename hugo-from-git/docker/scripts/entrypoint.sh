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

echo "Launch nginx"
mkdir -p /run/nginx
nginx -g "daemon off;"

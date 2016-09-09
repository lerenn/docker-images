#!/bin/bash

# Load functions
. /docker/scripts/functions.sh

# Continuous update
while [ true ]; do
  # Wait
  sleep $(($PERIOD*60))

  # Check if it needs update
  cd /tmp/hugo_website
  STATUS=`git pull | grep "up-to-date" | wc -l`
  if [ "$STATUS" == "0" ]; then Update; fi
done

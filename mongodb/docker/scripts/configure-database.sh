#!/bin/bash

if [ ! -e "/data/db/.mongodb_password_set" ]; then
  echo "# Configuration needed"

  RET=1
  echo "# Waiting for MongoDB service startup : Loading..."
  while [[ RET -ne 0 ]]; do
      sleep 1
      mongo admin --eval "help" >/dev/null 2>&1
      RET=$?
  done
  echo "# Waiting for MongoDB service startup : Loaded"

  echo "# Creating user '${USERNAME}' in MongoDB"
  mongo admin --eval "db.createUser({user: '$USERNAME', pwd: '$PASSWORD', roles:[{role:'root',db:'admin'}]});"

  echo "# Create password_set file"
  touch /data/db/.mongodb_password_set
fi

echo "# Ready for production."

#!/bin/bash

# Check environment variables
if [ ! -n "$USERNAME" ]; then export USERNAME="ADMIN"; fi
if [ ! -n "$PASSWORD" ]; then export PASSWORD="ADMIN"; fi

# Prepare launch command
MONGODB_CMD="mongod --auth --master"

# Launch configuration script
bash /docker/scripts/configure-database.sh &

# Launch MongoDB
echo "# Launch MongoDB"
$MONGODB_CMD

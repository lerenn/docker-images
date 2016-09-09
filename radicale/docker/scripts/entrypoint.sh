#!/bin/bash

# Variables
CONF_FILE="/data/radicale.conf"
HTPASSWD_FILE="/data/users.conf"
RIGHTS_FILE="/data/rights.conf"

# Change rights in data
chown -R root:root /data

# Create folder for certificates if needed
mkdir -p /data/certificates

# Copy configuration file if it doesn't exist
if [ ! -f $CONF_FILE ]; then
  cp /docker/conf/radicale.conf $CONF_FILE
fi

# Copy users file if it doesn't exist
if [ ! -f $HTPASSWD_FILE ]; then
  cp /docker/conf/users.conf $HTPASSWD_FILE
fi

# Copy users rights file if it doesn't exist
if [ ! -f $RIGHTS_FILE ]; then
  cp /docker/conf/rights.conf $RIGHTS_FILE
fi

# Launch radicale
echo "Launch Radicale..."
radicale --config $CONF_FILE

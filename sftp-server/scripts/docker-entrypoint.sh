#!/bin/bash

# Launch config script
/docker-configuration.sh

# Launching service
service ssh start

# Loop
echo "Ready."
while [ true ]; do
  sleep 600
done

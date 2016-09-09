#!/bin/bash

# Get config
. /docker/install/config.sh

# Add repos
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" > /etc/apt/sources.list.d/mongodb-org-3.2.list

# Update system
apt-get update
apt-get upgrade -y

# Install requirements
apt-get install $APTGET_INSTALL_ARGS $BUILD_PACKAGES $RUN_PACKAGES

# Set dpkg selections
echo "mongodb-org hold" | dpkg --set-selections
echo "mongodb-org-server hold" | dpkg --set-selections
echo "mongodb-org-shell hold" | dpkg --set-selections
echo "mongodb-org-mongos hold" | dpkg --set-selections
echo "mongodb-org-tools hold" | dpkg --set-selections

# Create directories
mkdir -p /data/db

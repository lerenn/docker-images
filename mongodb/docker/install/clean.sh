#!/bin/bash

# Get config
. /docker/install/config.sh

# Remove uneeded dependencies and build packages
AUTO_ADDED_PACKAGES=`apt-mark showauto`
apt-get remove --purge -y $BUILD_PACKAGES $AUTO_ADDED_PACKAGES

# Install the run-time dependencies
apt-get install $APTGET_INSTALL_ARGS $RUN_PACKAGES

# Clean everything else
apt-get clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*

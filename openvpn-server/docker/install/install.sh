#!/bin/bash

# Get config
. /docker/install/config.sh

# Update system
apt-get update
apt-get upgrade -y --force-yes

# Install requirements
apt-get install $APTGET_INSTALL_ARGS $BUILD_PACKAGES $RUN_PACKAGES

# Create directories
mkdir -p /etc/openvpn/keys
mkdir -p /etc/openvpn/easy-rsa/keys

# Install easy-rsa
git clone -b release/2.x https://github.com/OpenVPN/easy-rsa.git /tmp/easy-rsa
cp -r /tmp/easy-rsa/easy-rsa/2.0/* /etc/openvpn/easy-rsa/

# Copy files
cp /docker/files/server.conf /etc/openvpn/server.conf
cp /docker/files/client.conf /etc/openvpn/client.conf

# Copy files as model
mv /etc/openvpn /etc/openvpn-model

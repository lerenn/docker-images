#!/bin/bash 

# Apache
###############################################################################

# Set configuration
rm -f /etc/apache2/sites-enabled/*
cp /docker/configurations/web.conf /etc/apache2/sites-available
ln -s /etc/apache2/sites-available/web.conf /etc/apache2/sites-enabled/web.conf

# Activate htaccess modules
a2enmod authz_groupfile

# SFTP
###############################################################################

# Add configuration for SFTP
cp /docker/configurations/sshd_config /etc/ssh/sshd_config

# Add SFTP group
addgroup sftp

# Transmission
###############################################################################

# Create directories
mkdir -p /data/configuration/torrents
mkdir -p /data/downloads

# Create file log
touch /var/log/transmission.log
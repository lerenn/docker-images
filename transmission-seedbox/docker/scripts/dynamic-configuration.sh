#!/bin/bash

# Variables
CONF_FILE="/data/configuration/settings.json"

# Functions
function set_token {
	VALUE=${2//[\/]/\\\/}

	PRESENCE=`cat $CONF_FILE | grep -c "$1"`
	if [ $PRESENCE -gt 0 ]; then
		sed -Ei "s/^    \"$1\".*/    \"$1\": $VALUE,/" $CONF_FILE
	else
		sed -Ei "s/^\{.*/{\n    \"$1\": $VALUE,/" $CONF_FILE
	fi
}

# SFTP 
###############################################################################

# Add sftp account
ENCRYPT_PASSWORD=`mkpasswd --method=SHA-512 $PASSWORD`
useradd $USERNAME --gid sftp -G debian-transmission,sftp -p $ENCRYPT_PASSWORD -m --shell /bin/false

# Apache
###############################################################################

# Add Readme
cp -f /docker/configurations/README.txt /data/downloads

# Add htpassword
htpasswd -b -c /data/configuration/.htpasswd $USERNAME $PASSWORD

# Add htaccess
cp -f /docker/configurations/htaccess /data/downloads/.htaccess

# Seedbox
###############################################################################

# Set directories
mkdir -p /data/configuration/watch-dir
mkdir -p /data/configuration/torrents
mkdir -p /data/downloads

# Set configuration
cp /etc/transmission-daemon/settings.json /data/configuration
set_token "rpc-whitelist-enabled" 0
set_token "peer-port" $PEER_PORT
set_token "rpc-username" "\"$USERNAME\""
set_token "rpc-password" "\"$PASSWORD\""
set_token "download-dir" "\"/data/downloads\""
set_token "incomplete-dir" "\"/data/downloads\""
set_token "incomplete-dir-enabled" "false"
set_token "rename-partial-files" "false"
set_token "umask" 2
set_token "ratio-limit" $RATIO_LIMIT
set_token "watch-dir" "\"/data/configuration/watch-dir\""
set_token "watch-dir-enabled" "true"

# Prepare old torrents to be added
rm -rf /data/configuration/watch-dir/*
mv /data/configuration/torrents/* /data/configuration/watch-dir

# Unpause torrents
rm -rf /data/configuration/resume/*

# Set rights
chown root:root /data && chmod 755 /data
chmod -R 775 /data/* && chown -R debian-transmission:debian-transmission /data/*

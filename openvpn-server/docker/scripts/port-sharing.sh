#!/bin/bash

PATH_CONF="/etc/openvpn/server.conf"

echo "Place correct line for port-sharing"

# Get container IP
LINE=`cat /etc/hosts | grep $SHARE_PORT_CONTAINER`
if [ "$LINE" == "" ]; then
	echo "No corresponding container linked"
	exit
fi
array=(${LINE/ /})
IP=${array[0]}

# Application to server.conf
if [ ! -f $PATH_CONF ]; then
	echo "There is no server configuration"
fi
LINE=`cat $PATH_CONF | grep "port-share"`
if [ "$LINE" == "" ]; then
	echo "Adding line to server configuration"
	echo "port-share $IP $SHARE_PORT_NUMBER" >> $PATH_CONF
else
	echo "Modifying line"
	sed -Ei "s/^port-share.*/port-share $IP $SHARE_PORT_NUMBER/" $PATH_CONF
fi

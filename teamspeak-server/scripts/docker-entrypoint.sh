#!/bin/bash

echo "Create files for data persistence..."
mkdir -p /teamspeak/data/files
touch /teamspeak/data/query_ip_blacklist.txt
touch /teamspeak/data/query_ip_whitelist.txt
touch /teamspeak/data/ts3server.sqlitedb

echo "Link files..."
ln -s /teamspeak/data/files /bin/teamspeak-server/files
ln -s /teamspeak/logs /bin/teamspeak-server/logs
ln -s /teamspeak/data/query_ip_blacklist.txt /bin/teamspeak-server/query_ip_blacklist.txt
ln -s /teamspeak/data/query_ip_whitelist.txt /bin/teamspeak-server/query_ip_whitelist.txt
ln -s /teamspeak/data/ts3server.sqlitedb /bin/teamspeak-server/ts3server.sqlitedb

# Launch ts3 server
/bin/teamspeak-server/ts3server_minimal_runscript.sh

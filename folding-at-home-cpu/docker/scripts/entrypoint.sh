#!/bin/bash

CFG_PATH=/etc/fahclient/config.xml

# Copy configuration
cp -f /docker/config/config.xml $CFG_PATH

# Change configuration
sed -i -e "s/{{USERNAME}}/$USERNAME/" $CFG_PATH
sed -i -e "s/{{TEAM}}/$TEAM/" $CFG_PATH
sed -i -e "s/{{POWER}}/$POWER/" $CFG_PATH

# Change configuration rights 
chown fahclient:root $CFG_PATH

# Launch application
/etc/init.d/FAHClient start

# Monitor logs
tail -f /var/lib/fahclient/log.txt
#!/bin/bash

CFG_PATH=/etc/fahclient/config.xml

# Copy configuration
cp -f /docker/config/config.xml $CFG_PATH

# Change configuration
sed -i -e "s/{{USERNAME}}/$USERNAME/" $CFG_PATH
sed -i -e "s/{{TEAM}}/$TEAM/" $CFG_PATH
sed -i -e "s/{{POWER}}/$POWER/" $CFG_PATH

# Detect if there is a passkey
if [ $PASSKEY == "none" ]; then 
    sed -i -e "s/.*passkey.*//" $CFG_PATH
else
    sed -i -e "s/{{PASSKEY}}/$PASSKEY/" $CFG_PATH
fi

# Change configuration rights 
chown fahclient:root $CFG_PATH

# Launch application
/etc/init.d/FAHClient start

# Monitor logs
tail -f /var/lib/fahclient/log.txt
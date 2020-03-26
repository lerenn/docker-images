#!/bin/bash

CFG_PATH=/etc/fahclient/config.xml
DATA_PATH=/var/lib/fahclient

# Configuration
###############################################################################

echo "# Copy configuration"
cp -f /docker/config/config.xml $CFG_PATH

echo "# Change configuration"
sed -i -e "s/{{USERNAME}}/$USERNAME/" $CFG_PATH
sed -i -e "s/{{TEAM}}/$TEAM/" $CFG_PATH
sed -i -e "s/{{POWER}}/$POWER/" $CFG_PATH

echo "# Detect if there is a passkey"
if [ $PASSKEY == "none" ]; then 
    echo "No passkey detected"
    sed -i -e "s/.*passkey.*//" $CFG_PATH
else
    echo "Passkey detected"
    sed -i -e "s/{{PASSKEY}}/$PASSKEY/" $CFG_PATH
fi

echo "# Change configuration rights"
chown fahclient:root $CFG_PATH 

# Logs 
###############################################################################

echo "# Remove old logs"
rm $DATA_PATH/log.txt
touch $DATA_PATH/log.txt

# Volume
###############################################################################

echo "# Change volume rights"
chown -R fahclient:root $DATA_PATH

# Launch 
###############################################################################

echo "# Launch application"
/etc/init.d/FAHClient start

echo "# Monitor logs"
tail -f $DATA_PATH/log.txt
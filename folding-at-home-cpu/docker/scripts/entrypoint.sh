#!/bin/bash

CFG_PATH=/etc/fahclient/config.xml

echo "# Copy configuration"
cp -f /docker/config/config.xml $CFG_PATH

echo "# Change configuration"
sed -i -e "s/{{USERNAME}}/$USERNAME/" $CFG_PATH
sed -i -e "s/{{TEAM}}/$TEAM/" $CFG_PATH
sed -i -e "s/{{POWER}}/$POWER/" $CFG_PATH

echo "# Detect if there is a passkey"
if [ $PASSKEY == "none" ]; then 
    sed -i -e "s/.*passkey.*//" $CFG_PATH
else
    sed -i -e "s/{{PASSKEY}}/$PASSKEY/" $CFG_PATH
fi

echo "# Change configuration rights"
chown fahclient:root $CFG_PATH

echo "# Check if the /var/lib/fahclient volume is empty"
if [ `ls -a /var/lib/fahclient | sed -e "/\.$/d" | wc -l` = 0 ]; then
  echo "Copy original content to volume"
  cp -r /docker/fahclient/* /var/lib/fahclient
else 
  echo "Volume is not empty, considering it to be correct"
fi

echo "# Launch application"
/etc/init.d/FAHClient start

echo "# Monitor logs"
tail -f /var/lib/fahclient/log.txt
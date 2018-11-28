#!/bin/bash

# Launch config script
bash /docker/scripts/dynamic-configuration.sh

# Launching ssh
service ssh start

# Launching apache
service apache2 start

# Launching transmission
rm -f /var/log/transmission.log
touch /var/log/transmission.log
sudo -u debian-transmission transmission-daemon -f --logfile /var/log/transmission.log --config-dir /data/configuration &

# Look at logs
tail -f /var/log/transmission.log

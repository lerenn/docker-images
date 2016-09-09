#!/bin/bash

# Launch config script
bash /docker/scripts/configuration.sh

# Launching ssh
service ssh start

# Launching transmission
sudo -u debian-transmission transmission-daemon -f --logfile /var/log/transmission.log --config-dir /data/configuration &

# Look at logs
tail -f /var/log/transmission.log

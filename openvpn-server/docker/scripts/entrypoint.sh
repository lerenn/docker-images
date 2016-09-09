#!/bin/bash

# Set environment variables
. /docker/scripts/env_var.sh

# Verification of the emptyness of the openvpn directory
if [ `ls -a /etc/openvpn | sed -e "/\.$/d" | wc -l` = 0 ]
then
  echo "Configuring the server..."
  bash /docker/scripts/server-configuration.sh
  echo "Configuration is finished."
fi

# Set iptables
bash /docker/scripts/iptables.sh

# Share port
if [ $SHARE_PORT_CONTAINER != "none" ]; then
  bash /docker/scripts/port-sharing.sh
fi

# Generate clients
bash /docker/scripts/clients-configuration.sh

# Launch openvpn
/etc/init.d/openvpn start

# Display logs
tail -f /var/log/openvpn.log

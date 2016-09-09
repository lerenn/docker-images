#!/bin/bash

# Check if env variables are correct
if [ "${DOMAIN}" == "" ] || [ "${USERNAME}" == "" ] || [ "${PASSWORD}" == "" ]; then
  echo "One of the variables as not been completed"
  exit
fi

# Launch configuration script
/mail-server/scripts/configure.sh

# Launch services
service rsyslog start
service postfix start
service dovecot start

# Launch logs examination
tail -f /var/log/dovecot

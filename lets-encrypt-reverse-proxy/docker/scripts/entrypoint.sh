#!/bin/bash

# Check requirements
if [ "$LETSENCRYPT_EMAIL" == "none" ]; then echo "Please fill environment variable LETSENCRYPT_EMAIL"; exit; fi

# Wait for set period
echo "### Waiting for ${STARTUP_WAIT} seconds... "
sleep ${STARTUP_WAIT}
echo "Done"

# Renew existing and expiring certificates if existing
if [ -d "/etc/letsencrypt/live" ]; then
  echo "### Renew existing and expiring certificates"
  certbot renew --rsa-key-size $RSA_KEY_SIZE
fi

# Generating each certificate
i=1
var=CERT1
echo "### Generating new certificates..."
while [ "${!var}" ]
do
  # Check if already existing
  if [ ! -d "/etc/letsencrypt/live/${!var}" ]; then
    echo "Generate ${!var} certificate"
    certbot certonly --text --non-interactive --rsa-key-size $RSA_KEY_SIZE --email $LETSENCRYPT_EMAIL --agree-tos --standalone -d ${!var}
  else
    echo "${!var} certificate already generated"
  fi

  # Passing to the next certificate
  i=$((i+1))
  var="CERT$i"
done

# Launch reverse-proxy
nginx

# Nginx log
tail -f /var/log/nginx/error.log

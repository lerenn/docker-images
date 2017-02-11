#!/bin/bash

# Check requirements
if [ "$LETSENCRYPT_EMAIL" == "none" ]; then echo "Please fill environment variable LETSENCRYPT_EMAIL"; exit; fi

# Wait for set period
echo "### Waiting for ${STARTUP_WAIT} seconds... "
sleep ${STARTUP_WAIT}
echo "Done"

# Renew existing and expiring certificates if existing
# if [ -d "/etc/letsencrypt/live" ]; then
#  echo "### Renew existing and expiring certificates"
#  certbot renew --rsa-key-size $RSA_KEY_SIZE
# fi

# Generating each certificate
i=1
var=CERT1
echo "### Generating certificates..."
while [ "${!var}" ]
do
  # Get differents subdomains
  SUBDOMAINS=$(echo ${!var} | tr ";" "\n")
  SUBDOMAINS_ARGS=" "
  for subdomain in $SUBDOMAINS
  do
    SUBDOMAINS_ARGS+="-d $subdomain "
  done
  echo "SUBDOMAINS_ARGS: $SUBDOMAINS_ARGS"

  # Generate certificates
  echo "Generate ${!var} certificate"
  certbot certonly  --text --non-interactive --rsa-key-size $RSA_KEY_SIZE \
                    --email $LETSENCRYPT_EMAIL --agree-tos --standalone --expand \
                    --reinstall $SUBDOMAINS_ARGS

  # Passing to the next certificate
  i=$((i+1))
  var="CERT$i"
done

# Launch reverse-proxy
nginx

# Nginx log
tail -f /var/log/nginx/error.log

#!/bin/bash

# Relocate to the correct directory
cd `pwd`/$(dirname $0)
cd /etc/openvpn/easy-rsa/

i=1
var=CLIENT1
while [ "${!var}" ]
do
  # Generate keys if doesn't exist
  if [ ! -e "keys/${!var}.key" ]; then
    echo "Keys generation for ${!var}..."
    sed -Ei "s/^.*export KEY_CN.*/export KEY_CN=${!var}/" ./vars
    sed -Ei "s/^.*export KEY_NAME.*/export KEY_NAME=${!var}/" ./vars
    source ./vars
    ./build-key --batch "${!var}"
    echo "Done."
  fi

  if [ ! -d "/etc/openvpn/clientconf/${!var}" ]; then
    echo "Export files for ${!var}..."

    # Copy files to specific location
    mkdir "/etc/openvpn/clientconf/${!var}"
    cp /etc/openvpn/ca.crt "/etc/openvpn/clientconf/${!var}/"
    cp /etc/openvpn/ta.key "/etc/openvpn/clientconf/${!var}/"
    cp "keys/${!var}.crt" "/etc/openvpn/clientconf/${!var}/"
    cp "keys/${!var}.key" "/etc/openvpn/clientconf/${!var}/"
    cp /etc/openvpn/client.conf "/etc/openvpn/clientconf/${!var}/${!var}.conf"
    echo "Done."
  fi

  # Configuration of client.conf
  sed -Ei "s/^remote.*/remote $SERVER_IP $SERVER_PORT/" "/etc/openvpn/clientconf/${!var}/${!var}.conf"
  sed -Ei "s/^cert.*/cert ${!var}.crt/" "/etc/openvpn/clientconf/${!var}/${!var}.conf"
  sed -Ei "s/^key .*/key ${!var}.key/" "/etc/openvpn/clientconf/${!var}/${!var}.conf"

  # Copy for windows clients
  cp "/etc/openvpn/clientconf/${!var}/${!var}.conf" "/etc/openvpn/clientconf/${!var}/${!var}.ovpn"

  # Passing to the next client
  i=$((i+1))
  var="CLIENT$i"
done

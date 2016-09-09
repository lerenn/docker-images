#!/bin/bash

# Copy original directory
cp -r /etc/openvpn-model/* /etc/openvpn/

# Changing vars file
sed -Ei "s/^export EASY_RSA.*/export EASY_RSA=\"\/etc\/openvpn\/easy-rsa\"/" /etc/openvpn/easy-rsa/vars
sed -Ei "s/^export KEY_COUNTRY.*/export KEY_COUNTRY=\"$KEY_COUNTRY\"/" /etc/openvpn/easy-rsa/vars
sed -Ei "s/^export KEY_PROVINCE.*/export KEY_PROVINCE=\"$KEY_PROVINCE\"/" /etc/openvpn/easy-rsa/vars
sed -Ei "s/^export KEY_CITY.*/export KEY_CITY=\"$KEY_CITY\"/" /etc/openvpn/easy-rsa/vars
sed -Ei "s/^export KEY_ORG.*/export KEY_ORG=\"$KEY_ORG\"/" /etc/openvpn/easy-rsa/vars
sed -Ei "s/^export KEY_EMAIL.*/export KEY_EMAIL=\"$KEY_EMAIL\"/" /etc/openvpn/easy-rsa/vars
sed -Ei "s/^export KEY_CN.*/export KEY_CN=$KEY_CN/" /etc/openvpn/easy-rsa/vars
sed -Ei "s/^export KEY_NAME.*/export KEY_NAME=$KEY_NAME/" /etc/openvpn/easy-rsa/vars

# Generate certificates
source /etc/openvpn/easy-rsa/vars
/etc/openvpn/easy-rsa/clean-all
/etc/openvpn/easy-rsa/build-dh
/etc/openvpn/easy-rsa/pkitool --initca
/etc/openvpn/easy-rsa/pkitool --server server
openvpn --genkey --secret /etc/openvpn/easy-rsa/keys/ta.key

# Moving certificates
cp /etc/openvpn/easy-rsa/keys/ca.crt /etc/openvpn/
cp /etc/openvpn/easy-rsa/keys/ta.key /etc/openvpn/
cp /etc/openvpn/easy-rsa/keys/server.crt /etc/openvpn/
cp /etc/openvpn/easy-rsa/keys/server.key /etc/openvpn/
cp /etc/openvpn/easy-rsa/keys/dh2048.pem /etc/openvpn/

# Jail directory and client conf directory
mkdir -p /etc/openvpn/jail/tmp
mkdir /etc/openvpn/clientconf

# Configuration of traffic route
sh -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'

#!/bin/bash

echo "Mandatory rules to unlock access..."
iptables -I FORWARD -i tun0 -j ACCEPT
iptables -I FORWARD -o tun0 -j ACCEPT
iptables -I OUTPUT -o tun0 -j ACCEPT
echo "Done."

echo "Address translation..."
iptables -A FORWARD -i tun0 -o eth0 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.2/24 -o eth0 -j MASQUERADE
echo "Done."

if [ "$SERVER_IP" != "" ]; then
	echo "Redirecting internal flux"
	iptables -t nat -A PREROUTING -p tcp -d 10.8.0.1 -j DNAT --to-destination $SERVER_IP
	iptables -t nat -A POSTROUTING -p tcp -d $SERVER_IP -j SNAT --to-source 10.8.0.1
	echo "Done."
fi

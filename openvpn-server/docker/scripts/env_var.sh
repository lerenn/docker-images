#!/bin/bash

echo "Check environment variables..."

# Server configuration
if [ ! -n "$KEY_COUNTRY" ]; then export KEY_COUNTRY="EN"; fi
if [ ! -n "$KEY_PROVINCE" ]; then export KEY_PROVINCE="None"; fi
if [ ! -n "$KEY_CITY" ]; then export KEY_CITY="None"; fi
if [ ! -n "$KEY_ORG" ]; then export KEY_ORG="None"; fi
if [ ! -n "$KEY_EMAIL" ]; then export KEY_EMAIL="xxxx@xxx.xx"; fi
if [ ! -n "$KEY_CN" ]; then export KEY_CN="CommonName"; fi
if [ ! -n "$KEY_NAME" ]; then export KEY_NAME="Name"; fi

# Port sharing configuration
if [ ! -n "$SHARE_PORT_CONTAINER" ]; then export SHARE_PORT_CONTAINER="none"; fi
if [ ! -n "$SHARE_PORT_NUMBER" ]; then export SHARE_PORT_NUMBER="443"; fi

# Client configuration
if [ ! -n "$SERVER_IP" ]; then export SERVER_IP="A.B.C.D"; fi
if [ ! -n "$SERVER_PORT" ]; then export SERVER_PORT="443"; fi

echo "Done."

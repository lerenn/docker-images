#!/bin/bash

# Variables
BIND="0.0.0.0:3333"

# Requirements
if [ "$POOL" == "" ]; then echo "Please fill environment variable POOL"; exit; fi
if [ "$USERNAME" == "" ]; then echo "Please fill environment variable USERNAME"; exit; fi

# Launch
/xmrig-proxy/xmrig-proxy \
  -b $BIND \
  -o $POOL \
  -u $USERNAME \
  -p $PASSWORD \
  -m $MODE \
  --donate-level $DONATE_LEVEL

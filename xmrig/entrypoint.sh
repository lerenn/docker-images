#!/bin/bash

# Requirements
if [ "$POOL" == "" ]; then echo "Please fill environment variable POOL"; exit; fi
if [ "$USERNAME" == "" ]; then echo "Please fill environment variable USERNAME"; exit; fi

# Launch
/xmrig/xmrig \
  -o $POOL \
  -u $USERNAME \
  -p $PASSWORD \
  -t $THREADS \
  --cpu-priority 0 \
  --donate-level $DONATE_LEVEL

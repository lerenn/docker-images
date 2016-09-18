#!/bin/bash

# Check variables
if [ "$BOX_EMAIL" == "" ]; then echo "Please provide a username for your box account"; exit; fi
if [ "$BOX_PASSWORD" == "" ]; then echo "Please provide a password for your box account"; exit; fi

# Prepare file
rm -f ~/.netrc
echo "default" >> ~/.netrc
echo "login $BOX_EMAIL" >> ~/.netrc
echo "password $BOX_PASSWORD" >> ~/.netrc
chmod 600 ~/.netrc

# Make backup
bash /docker/scripts/backup.sh

# Clean
rm -rf /var/archives/*

#!/bin/bash

echo "Generate"
certbot certonly --webroot -w /var/certificates -d louis-fradin.net

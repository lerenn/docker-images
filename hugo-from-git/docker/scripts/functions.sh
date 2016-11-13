#!/bin/bash

Update() {
  rm -rf /tmp/hugo_website
  git clone --recursive $REPO_LINK /tmp/hugo_website
  cd /tmp/hugo_website
  hugo -d /var/www/html --config=$CONFIG_FILE
}

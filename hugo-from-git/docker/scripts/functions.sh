#!/bin/bash

Update() {
  rm -rf /tmp/hugo_website
  git clone --recursive $REPO_LINK /tmp/hugo_website
  rsync -r --delete-after /tmp/hugo_website/ /var/www/html/
}

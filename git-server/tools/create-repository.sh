#!/bin/bash

mkdir /var/git/$1.git
cd /var/git/$1.git
git init --bare
chown -R git:git /var/git/$1.git

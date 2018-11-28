#!/bin/bash 

# Apache
###############################################################################

# Set configuration
rm -f /etc/apache2/sites-enabled/*
cp /docker/configurations/web.conf /etc/apache2/sites-available
ln -s /etc/apache2/sites-available/web.conf /etc/apache2/sites-enabled/web.conf

# Activate htaccess modules
a2enmod authz_groupfile

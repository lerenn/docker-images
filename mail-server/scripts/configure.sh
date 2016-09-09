#!/bin/bash

## Configure domains ##

## Create folders and check rights
mkdir -p /var/spool/mail/vhosts/${DOMAIN}
chown -R vmail:vmail /var/spool/mail/vhosts
chmod -R 660 /var/spool/mail/vhosts

# Add Domain
echo "${DOMAIN} " >> /etc/postfix/virtual_domains

## --- ###

# See if some of files are missing in volumes
# TODO

## Change some variables
# /etc/postfix/main.cf
sed -Ei "s/^myhostname.*/myhostname = ${HOSTNAME}/" /etc/postfix/main.cf
sed -Ei "s/^mydomain.*/mydomain = ${DOMAIN}/" /etc/postfix/main.cf
# /etc/dovecot/dovecot.conf
sed -Ei "s/^\thostname.*/\thostname = ${HOSTNAME}/" /etc/dovecot/dovecot.conf
sed -Ei "s/^\tpostmaster_address.*/\tpostmaster_address = ${USERNAME}@${DOMAIN}/" /etc/dovecot/dovecot.conf

# Add user
echo "Add user..."
/mail-server/scripts/new_email.sh ${USERNAME}@${DOMAIN} ${PASSWORD}

# Apply changes
postmap /etc/postfix/virtual_domains
postmap /etc/postfix/virtual_mailbox
postmap /etc/postfix/virtual_alias

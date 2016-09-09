#!/bin/bash
USAGE="Usage: $0 EMAIL PASSWORD";

if [ ! -n "$2" ]
then
  echo $USAGE;
  exit 1;
fi

USERNAME=$(echo "$1" | cut -f1 -d@);
DOMAIN=$(echo "$1" | cut -f2 -d@);
ADDRESS=$1;
PASSWD=$2;
BASEDIR="/var/spool/mail/vhosts";

if [ -f /etc/postfix/virtual_mailbox ]
then
  echo "Adding Postfix user configuration..."
  echo $ADDRESS $DOMAIN/$USERNAME/ >> /etc/postfix/virtual_mailbox
  echo @$DOMAIN $USERNAME@$DOMAIN >> /etc/postfix/virtual_alias

  if [ $? -eq 0 ]
  then
    echo "Adding Dovecot user configuration..."
    echo $ADDRESS::5000:5000::$BASEDIR/$DOMAIN/$ADDRESS>> $BASEDIR/$DOMAIN/passwd
    echo $ADDRESS":"$(doveadm pw -p $PASSWD) >> $BASEDIR/$DOMAIN/shadow
    chown vmail:vmail $BASEDIR/$DOMAIN/passwd && chmod 775 $BASEDIR/$DOMAIN/passwd
    chown vmail:vmail $BASEDIR/$DOMAIN/shadow && chmod 775 $BASEDIR/$DOMAIN/shadow
  fi
else
  echo "ERROR : There is no /etc/postfix/virtual_mailbox file"
fi

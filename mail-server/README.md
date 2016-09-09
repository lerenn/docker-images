# docker-mail-server
Docker image for mail server SMTP+IMAP (Postfix+Dovecot).

## Build

To create the image `lerenn/mail-server`, execute the following command on the docker image folder:

		docker build -t lerenn/mail-server .

## Run

To run the image with a minimum of arguments, execute the following command:

		docker run -d -p 25:25 -p 143:143 --hostname=hostname -e USERNAME=user -e DOMAIN=example.net -e PASSWORD=password -v /path/in/host:/etc/dovecot/ssl/mailserver.crt -v /path/in/host:/etc/dovecot/ssl/mailserver.key lerenn/mail-server

However, if you want persistence, you should launch this command :

		docker run -d -p 25:25 -p 143:143 --hostname=hostname -e USERNAME=user -e DOMAIN=example.net -e PASSWORD=password -v /path/in/host:/etc/dovecot/ssl/mailserver.crt -v /path/in/host:/etc/dovecot/ssl/mailserver.key -v /path/in/host:/var/spool/mail/vhosts lerenn/mail-server

## Arguments

### Volumes

* `/etc/dovecot/ssl/mailserver.crt`: This file is the certificate for your mail server.
* `/etc/dovecot/ssl/mailserver.key`: This file is the key for your mail server.
* `/var/spool/mail/vhosts`: This is where your mails will be stored.

### Environment variables

* **DOMAIN**: Your domain (ex: `example.com`). Defaults to ` `.
* **USERNAME**: Your username or the first part of your email (ex: `user` for `user@example.com`). Defaults to ` `.
* **PASSWORD**: The password of your email account. Defaults to ` `.

### Ports

* **25**: SMTP TCP port.
* **143**: IMAP TCP port.

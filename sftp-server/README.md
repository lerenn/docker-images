# docker-sftp

Docker image for SFTP server for one or more user(s), with chroot to data directory for normal users.

## Explanations

### Certificates

Authorized keys can be added instead of passwords (via file with username as name
and place in corresponding volume).

Access to root only via certificate (with authorized_keys as an user).

### Chroot directory

In chroot directory, only `data` is writtable by the user.

## Build

To create the image `lerenn/sftp-server`, execute the following command on the sftp-server project folder :

    docker build -t lerenn/sftp-server .

## Run

Start your image with minimum arguments :

    docker run -d -p 22:22 -e USERNAME1=username -e PASSWORD1=password lerenn/sftp-server

With access to user data and with certificate :

    docker run -d -p 22:22 -v /path/in/host:/home/<username>
    -v /path/in/host:/docker/authorized_keys/username
    -e USERNAME1=username lerenn/sftp-server

## Arguments

### Volumes

* **/home/<username>**: Directory containing data accessible by SFTP.
* **/docker/authorized_keys**: Authorized keys for users and root.

### Environment variables

* **USERNAME<X>**: Username to set as sftp user. Defaults to ``.
* **PASSWORD<X>**: Password to set as sftp user's password. Defaults to ``.

### Ports

* **22**: SFTP port.

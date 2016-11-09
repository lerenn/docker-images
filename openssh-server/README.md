# docker-openssh

Docker image for installation of openssh server with one user.

## Build

To create the image `lerenn/openssh-server`, execute the following command on the openssh-server project folder :

    docker build -t lerenn/openssh-server .

## Run

Start your image :

    docker run -d -p 22:22 -e USERNAME=user -e PASSWORD=password lerenn/openssh-server

##Arguments

###Environment variables

* **USERNAME**: Username of the user. Defaults to `admin`.
* **PASSWORD**: Password of the user. Defaults to `admin`.
* **SUDO**: Add user to `sudo` users. Defaults to `yes`.

###Ports

* **22**: OpenSSH server access port.

### Volumes
You can add any volume to the container : It can be useful to limit access to a particular section of your server.

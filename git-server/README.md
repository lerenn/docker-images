# docker-git-server

Docker image for git server with zsh.

## Build

To create the image `lerenn/git-server`, execute the following command on the docker-git folder:

    docker build -t lerenn/git-server .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d -v /path/in/host:/var/git -p 22:22 lerenn/git-server

## Usage

* Authorized keys : To add an authorized ssh key, you have to add it to `/var/git/.ssh/authorized_keys`
* Clone repository :
  * If you are on port 22 : git clone git@serveur.com/~/repo.git
  * If you're not on port 22 : git clone ssh://git@gitserveur.com:port/~/repo.git
* Create repository : Use the command `create-repository repo-name`, connected as git user.
* Delete repository : Use the command `delete-repository repo-name`, connected as git user.

## Arguments

### Volumes

* **/var/git**: Here will be stored repositories and authorized ssh keys.

### Ports

* **22**: Git server access port.

## Special thanks
Thanks to [formation-debian.via.ecp.fr](http://formation-debian.via.ecp.fr) for
their really good job concerning highlightings of ZSH.

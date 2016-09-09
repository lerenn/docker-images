# docker-mongodb
Docker image for MongoDB database.

## Build

To create the image `lerenn/mongodb`, execute the following command on the docker image folder:

		docker build -t lerenn/mongodb .

## Run

To run the image with a minimum of arguments, execute the following command:

		docker run -d -p 27017:27017 lerenn/mongodb

However, if you want persistence and/or change username/password, you should launch this command :

		docker run -d -p 127.0.0.1:27017:27017 -e USERNAME=lol -e PASSWORD=nope -v /path/in/host:/data/db lerenn/mongodb

## Arguments

### Volumes

* `/data/db`: Where the database is stored.

### Environment variables

* **USERNAME**: Database root username. Defaults to `admin`.
* **PASSWORD**: Database root password. Defaults to `admin`.

### Ports

* **27017**: MongoDB port.

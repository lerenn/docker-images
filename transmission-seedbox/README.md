# docker-transmission-seedbox

Docker image for a seedbox (transmission) with SFTP read/write access (password protected) and HTTP read-only access (password protected through htaccess).

**If you use the HTTP access, it is recommended to use it through a reverse-proxy that can allow HTTPS access**

## Build

To create the image `lerenn/transmission-seedbox`, execute the following command on the Dockerfile folder :

    docker build -t lerenn/transmission-seedbox .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d -p 22:22 -p 80:80 -p 9091:9091 lerenn/transmission-seedbox

But it's better if you replace the username and password :

    docker run -d -e USERNAME=username -e PASSWORD=password -p 22:22 -p 80:80 -p 9091:9091 lerenn/transmission-seedbox

## Arguments

### Ports

* **22**: SFTP port, you can access it in sftp mode with username and password
set as environment variables.
* **80**: HTTP port, you can access it in HTTP mode with username and password
set as environment variables.
* **9091**: Web port, access to Transmission interface. Login informations are
username and password set as environment variables.

### Environment variables

* **USERNAME**: Username to use as access to SFTP and Transmission.
Defaults to `admin`.
* **PASSWORD**: Password to use as access to SFTP and Transmission.
Defaults to `admin`.
* **PEER_PORT**: Port used for peer connection. Defaults to `51413`.
* **RATIO_LIMIT**: Ratio limit when seeding a torrent.
Defaults to `999999`.

### Volumes

* **/data**: Directory where files are downloaded.

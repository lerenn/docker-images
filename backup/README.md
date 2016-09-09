# docker-backup
Docker image for automatic backup of files locally and remotely.


## Build

To create the image `lerenn/backup`, execute the following command on the backup project folder :

    docker build -t lerenn/backup .

## Run

To run the image, execute the following command :

    docker run -d -v /path/in/host:/backup -v /path/in/host:/keys -e BACKUP_PERIOD=1 -e BACKUP_DIR=user@server:/dir lerenn/github-backup

## Arguments

### Environment variables

* **BACKUP_DIR**: Directory to backup, locally or remotely (don't forget final `/`). Its the same form that the one used by rsync. Defaults to ` `.
* **BACKUP_PERIOD**: Time between two backup, in hours. Defaults to `24`.

### Volumes

* **/backup**: Volume containing backup files.
* **/keys**: Volume that contains keys for connection to remote server. Private key has to be `id_rsa` and public key has to be `id_rsa.pub`.

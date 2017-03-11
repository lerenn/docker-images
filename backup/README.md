# docker-backup

Docker image for automatic backup of files locally and remotely.

## Build

To create the image `lerenn/backup`, execute the following command on the backup project folder :

    docker build -t lerenn/backup .

## Run

To run the image, execute the following command :

    docker run -d -v /path/in/host:/backup -v /path/in/host:/keys -e BACKUP_DIR=user@server:/dir lerenn/github-backup

## Arguments

### Environment variables

* **BACKUP_DIR**: Directory where backup will be saved, locally or remotely.
                  Its the same form that the one used by rsync. Defaults to ` `.
* **CRON_SCHEME**: When the backup should occured. Based on [cron scheme](https://en.wikipedia.org/wiki/Cron). Defaults to `0 3 * * *` (everyday at 3AM).

### Volumes

* **/backup**: Volume containing backup files.
* **/keys**: Volume that contains keys for connection to remote server. Private key has to be `id_rsa` and public key has to be `id_rsa.pub`.

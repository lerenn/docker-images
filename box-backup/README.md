# Box Backup
Docker image for backing up files to Box.com account.

## Build

To create the image `lerenn/box-backup`, execute the following command on the box-backup project folder:

    docker build -t lerenn/box-backup .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d -e BOX_EMAIL=email@domain.net -e BOX_PASSWORD=password -v /path/in/host:/data/folderToSave lerenn/box-backup

## Arguments

### Environment variables

* **BOX_EMAIL**: Email used to connect to your Box account. Defaults to ` `.
* **BOX_PASSWORD**: Password used to connect to your Box account. Defaults to ` `.
* **ENCRYPTION**: Activate encryption of the compressed file. Defaults to `false`.
* **ENCRYPTION_PASSWORD**: Password used to encrypt compressed file (if activated). Defaults to ` `.
* **BACKUP_NBR**: Maximum number of backup that there should be on Box account (if negative, deactivated). Defaults to `-1`.
* **DESTINATION_FOLDER**: Destination folder on Box account. Defaults to `Test`.
* **CRON_SCHEME**: When the backup should occured. Based on [cron scheme](https://en.wikipedia.org/wiki/Cron). Defaults to `0 3 * * *` (everyday at 3AM).

### Volumes

* **/data**: This is the directory that will be compressed (and optionally encrypted) then sent to the box account.

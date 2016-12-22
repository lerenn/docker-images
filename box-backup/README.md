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
* **SPLIT**: Activate splitting of files into small part. Defaults to `false`.
* **SPLIT_SIZE**: Size of each part (for format, see `split` doc). Defaults to `500M`.
* **BACKUP_NBR**: Maximum number of backup that there should be on Box account (if negative, deactivated). Defaults to `-1`.
* **DESTINATION_FOLDER**: Destination folder on Box account. Defaults to `Test`.
* **CRON**: If true, backup will occur according to the CRON_SCHEME. If false, backup will be executed as soon as the container is ready and the container will die after backup. Defaults to `true`;
* **CRON_SCHEME**: When the backup should occured. Based on [cron scheme](https://en.wikipedia.org/wiki/Cron). Defaults to `0 3 * * *` (everyday at 3AM).

### Volumes

* **/data**: This is the directory that will be compressed (and optionally encrypted) then sent to the box account.

## Join an decrypt data

To join and decrypt data, you have to enter this command where the splitted-encrypted files are:

    cat backup-XXX-XXX.tar.gz.gpg.part-* | gpg > backup-XXX-XXX.tar.gz

If just splitted:

    cat backup-XXX-XXX.tar.gz.part-* > backup-XXX-XXX.tar.gz

If just encrypted:

    gpg backup-XXX-XXX.tar.gz.gpg

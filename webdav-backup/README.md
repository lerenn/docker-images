# Webdav Backup

Docker image for backing up files to a Webdav server (tested for box.com).

This image will make a `.tar.gz` backup of all files in the volume `/data` and push it to WebDAV server.
You can also encrypt this backup and/or split this file into small pieces (as certain hosts only accepts a limited size of file).

This backup can be instantaneous or scheduled, through CRON job (see `CRON` and `CRON_SCHEME` variables below).

For each WebDAV operation, you have a time out (defaults to 120 sec and editable).
If the operation fails (whatever is the reason), it will be restarted until it succeed.

For more information, please see the `Arguments` section below.

## Build

To create the image `lerenn/webdav-backup`, execute the following command on the webdav-backup project folder:

    docker build -t lerenn/webdav-backup .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d -e WEBDAV_USERNAME=email@domain.net -e WEBDAV_PASSWORD=password -v /path/in/host:/data/folderToSave lerenn/webdav-backup

## Arguments

### Environment variables

* **WEBDAV_HOST**: WebDAV server address (example: `https://dav.box.com/dav` or
  `https://owncloud.example.com/remote.php/webdav`). Defaults to ` `.
* **WEBDAV_USERNAME**: Email used to connect to the WebDAV server. Defaults to ` `.
* **WEBDAV_PASSWORD**: Password used to connect to your WebDAV server. Defaults to ` `.
* **ENCRYPTION**: Activate encryption of the compressed file. Defaults to `false`.
* **ENCRYPTION_PASSWORD**: Password used to encrypt compressed file (if activated). Defaults to ` `.
* **SPLIT**: Activate splitting of files into small part. Defaults to `false`.
* **SPLIT_SIZE**: Size of each part (for format, see `split` doc). Defaults to `500M`.
* **BACKUP_NBR**: Maximum number of backup that there should be on the WebDAV server
  (if negative, deactivated). Defaults to `-1`.
* **DESTINATION_FOLDER**: Destination folder on WebDAV server. Defaults to `Test`.
* **TIMEOUT**: Timeout for each WebDAV operation. If the total WebDAV operation
  time exceeds this value (in seconds), then operation will be avorted and restarted.
  Defaults to `120`.
* **CRON**: If true, backup will occur according to the CRON_SCHEME. If false,
  backup will be executed as soon as the container is ready and the container will die after backup. Defaults to `true`;
* **CRON_SCHEME**: When the backup should occured. Based on [cron scheme](https://en.wikipedia.org/wiki/Cron). Defaults to `0 3 * * *` (everyday at 3AM).

### Volumes

* **/data**: This is the directory that will be compressed (and optionally encrypted) then sent to the WebDAV server.

## Join an decrypt data

To join and decrypt data, you have to enter this command where the splitted-encrypted files are:

    cat backup-XXX-XXX.tar.gz.gpg.part-* | gpg > backup-XXX-XXX.tar.gz

If just splitted:

    cat backup-XXX-XXX.tar.gz.part-* > backup-XXX-XXX.tar.gz

If just encrypted:

    gpg backup-XXX-XXX.tar.gz.gpg


## Examples (docker-compose)

### Box.com

* This will save `path/in/host/1` and `path/in/host/2` to Box.com.
* Encrypted with `backup_password` as password.
* Splitted in 50MB files.
* With a maximum of 3 backup on server, at folder `Test/example`.
* The backup is scheduled at 3 AM each day.


    webdav-backup:
      build: .
      volumes:
        - "path/in/host/1:/data/1"
        - "path/in/host/2:/data/2"
      environment:
        - WEBDAV_HOST=https://dav.box.com/dav
        - WEBDAV_USERNAME=lerenn@example.com
        - WEBDAV_PASSWORD=some_password
        - ENCRYPTION=true
        - ENCRYPTION_PASSWORD=backup_password
        - SPLIT=true
        - SPLIT_SIZE=50M
        - BACKUP_NBR=3
        - DESTINATION_FOLDER=Test/example
        - CRON=true
        - CRON_SCHEME="0 3 * * * "

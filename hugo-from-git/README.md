# docker-hugo-git

Based on Alpine.

Docker image for hugo website which regenerates at each change on master branch
of the website's git repository.

**Git repository (and submodule) has to be accessible in http/https format**

## Build

To create the image `lerenn/hugo-from-git`, execute the following command on
the Dockerfile folder :

    docker build -t lerenn/hugo-from-git .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d -p 80:80 -e REPO_LINK="https://yourepo.com" lerenn/hugo-from-git

## Arguments

### Ports

* **80**: HTTP port, hugo server will display the website on this port.

### Environment variables

* **BASE_URL**: Base URL for your website. Defaults to `localhost`.
* **CONFIG_FILE**: Configuration file used to build the website. Defaults to `config.toml`.
* **PERIOD**: Period of time, in minutes, between each check for change.
Defaults to `10`.
* **PUBLISH_DIR**: Directory where the website is published. Defaults to `public`.
* **REPO_LINK**: Link to the hugo website repository (https/https only).
Defaults to `<none>`.

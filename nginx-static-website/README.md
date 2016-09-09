# docker-nginx-static-website

Docker image for a static website, powered by Nginx

## Build

To create the image `lerenn/nginx-static-website`, execute the following
command on the nginx-static-website project folder :

    docker build -t lerenn/nginx-static-website .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d -v /path/in/host:/var/www/html -p 80:80 lerenn/nginx-static-website

## Arguments

### Volumes

* **/var/www/html**: Here will be stored the static website.

### Ports

* **80**: HTTP Port to static website.

## More informations

### 404 page
If you want to add a 404 page to your website, please add the file `404.html` to
the root of your website (where the original `index.html` is).

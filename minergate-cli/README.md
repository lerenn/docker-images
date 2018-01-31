# minergate-cli

Docker image for a minergate-cli mining container.

## Build

To create the image `lerenn/minergate-cli`, execute the following command on the minergate-cli project folder:

    docker build -t lerenn/minergate-cli .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d lerenn/minergate-cli

However, if you want to use it with your address and custom currency  :

    docker run -d -e USER=example@gmail.com -e CURRENCY=bcn lerenn/minergate-cli

## Arguments

### Environment variables

* **USER**: User login to minergate website. Defaults to `louis.fradin@gmail.com`.
* **CURRENCY**: Currency mined by the image (respecting minergate notation). Defaults to `xmr`.

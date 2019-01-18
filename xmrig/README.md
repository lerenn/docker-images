# XMRig

Docker image for xmrig

## Build

To create the image `lerenn/xmrig`, execute the following command on
the Dockerfile folder :

    docker build -t lerenn/xmrig .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d -p 3333:3333 -e POOL="ADDR:PORT" -e USERNAME="username" lerenn/xmrig

## Arguments

### Environment variables

* **POOL**: Address and port to the mining pool. Defaults to ` `.
* **USERNAME**: Username used to connect to the mining pool. Defaults to ` `.
* **PASSWORD**: Password to connect to the mining pool. Defaults to `x`.
* **THREADS**: Number of miner threads. Defaults to `1`.
* **DONATE_LEVEL**: Donation level to proxy developers. Defaults to `5`.

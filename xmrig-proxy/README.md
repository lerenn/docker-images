# xmrig-proxy

Docker image for xmrig-proxy

## Build

To create the image `lerenn/xmrig-proxy`, execute the following command on
the Dockerfile folder :

    docker build -t lerenn/xmrig-proxy .

## Run

To run the image with a minimum of arguments, execute the following command :

    docker run -d -p 3333:3333 -e POOL="ADDR:PORT" -e USERNAME="username" lerenn/xmrig-proxy

## Arguments

### Ports

* **3333**: Stratum port, this port will listen for miner connections.

### Environment variables

* **POOL**: Address and port to the mining pool. Defaults to ` `.
* **USERNAME**: Username used to connect to the mining pool. Defaults to ` `.
* **PASSWORD**: Password to connect to the mining pool. Defaults to `x`.
* **MODE**: Mode used by the proxy. Defaults to `nicehash`.
* **DONATE_LEVEL**: Donation level to proxy developers. Defaults to `2`.

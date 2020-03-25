# folding-at-home-cpu

Docker image for the Folding-at-Home application, CPU only (aiming basic servers).

### Unachieved (for now)

* Access interface through port
* Instant launch (for now, you have to wait 5min before start)

## Build

To create the image `lerenn/folding-at-home-cpu`, execute the following command on the project folder:

    docker build -t lerenn/folding-at-home-cpu .

## Run

If you want to use the folding@home docker, here is the basic command :

    docker run -d -e USERNAME=<USER> -e TEAM=<TEAM> -e POWER=<POWER> lerenn/folding-at-home-cpu

## Arguments

### Ports

* **36330**: [Optional] Control port.

### Volumes

* **/var/lib/fahclient**: Directory containing data for work. You should use this volume if you want to resume folding jobs when recreating the container, otherwise they will be lost when erasing the container.

### Environment variables

* **USERNAME**: [Optional] Username used for assigned jobs. Defaults to `Anonymous`.
* **TEAM**: [Optional] Team used for assigned jobs. Defaults to `0`.
* **POWER**: [Optional] Power used for assigned jobs. Defaults to `medium`.
* **PASSKEY**: [Optional] Passkey used for assigned jobs. Defaults to `none`.
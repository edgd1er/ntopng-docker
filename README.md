![build ntopng-docker multi-arch images](https://github.com/edgd1er/ntopng-docker/workflows/build%20ntopng-docker%20multi-arch%20images/badge.svg?branch=master)

# ntopng-docker

simple container to analyze network traffic based on https://github.com/Laisky/ntopng-docker for amd64 and arm.

* use debian buster-slim image to have small base image
* add nightly build for ntopng https://packages.ntop.org/apt/
* as of 2021/04/21, ntop version is v.4.3
  
    armhf latest version is here: https://packages.ntop.org/RaspberryPI/buster_pi/armhf/ntopng/
    

Official Docker file are here: https://github.com/ntop/docker-ntop

Official (x86_64) containers are here:  https://hub.docker.com/r/ntop/ntopng

## Usage

Container is using network host mode.

If you want to build from sources:
```
docker-compose build
```

using docker-compse.yml, notpng and redis volumes are persistent:
```bash
mkdir -m 777 /var/lib/ntopng/
docker-compose up -d
```
- navigate to 0.0.0.0:27833
- set admin password ( default login/pwd is admin/admin)

env value NTOP_UID and NTOP_GID are available to match user and group of local mounted volumes (./data/notpng, ./data/redis)

Note that with netplan.io, it is not possible to set an interface in promiscous mode, ie you can't monitor all flows, but only flows from or to the host.
if anyone knows how to do with netplan, please let me know. 
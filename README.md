![build ntopng-docker amd64 image with stable repository (no armhf)](https://github.com/edgd1er/ntopng-docker/workflows/build%20ntopng-docker%20amd64%20image%20with%20stable%20repository%20(no%20armhf)/badge.svg?branch=master)
![build ntopng-docker multi-arch images with nightly repository](https://github.com/edgd1er/ntopng-docker/workflows/build%20ntopng-docker%20multi-arch%20images%20with%20nightly%20repository/badge.svg?branch=master)

# ntopng-docker

simple container to analyze network traffic based on https://github.com/Laisky/ntopng-docker for amd64 and arm.

* use debian buster-slim image to have small base image
* two tags: dev-latest for latest nightly (armhf, adm64), stable-latest for latest stable (amd64)
* as of 2021/04/21, ntop version is v.4.2 for stable, 4.3 for nightly.
* For the moment, no stable armhf version is available.
    
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
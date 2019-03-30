# ntopng-docker

simple container to analyze network traffic based on https://github.com/Laisky/ntopng-docker

* use balenalib image to have small base image
  https://www.balena.io/docs/reference/base-images/base-images/#how-to-pick-a-base-image

* add nightly build  for ntopng
  http://packages.ntop.org/apt/

* as of 2019/03/30, ntop version is v.3.9.190330


## Usage

mkdir -m 777 /var/lib/ntopng/
docker-compose up --build

- navigate to 0.0.0.0:27833
- set admin password ( default login/pwd is admin/admin)



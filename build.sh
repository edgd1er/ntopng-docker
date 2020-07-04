#!/usr/bin/env bash
#
CACHE=""
CACHE=" --no-cache"
mach=$(uname -m)
[[ ${mach} =~ "arm" ]] && docker build -f Dockerfile.armhf -t edgd1er/ntopng-docker:armhf .
if [[ ${mach} =~ "x86" ]]; then 
	docker build -f Dockerfile ${CACHE} --build-arg DISTRO=amd64-ubuntu  -t edgd1er/ntopng-docker:amd64 .
	ret=$?
	[[ ${ret} != "0" ]] && echo "\n error while building amd64 image" && exit 1

	docker build -f Dockerfile.armhf ${CACHE} --build-arg DISTRO=armv7hf-debian -t edgd1er/ntopng-docker:armhf .
	ret=$?
	[[ ${ret} != "0" ]] && echo "\n error while building amd64 image" && exit 1
fi

docker manifest create edgd1er/ntopng-docker edgd1er/ntopng-docker:armhf edgd1er/ntopng-docker:amd64

#!/usr/bin/env bash
#
mach=$(uname -m)
[[ ${mach} =~ "arm" ]] && docker build -f Dockerfile.armhf -t edgd1er/ntopng-docker:armhf .
if [[ ${mach} =~ "x86" ]]; then 
	docker build -f Dockerfile -t edgd1er/ntopng-docker:amd64 .
	docker build -f Dockerfile.armhf -t edgd1er/ntopng-docker:armhf .
fi

docker manifest create edgd1er/ntopng-docker edgd1er/ntopng-docker:armhf edgd1er/ntopng-docker:amd64

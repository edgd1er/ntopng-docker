#!/usr/bin/env bash
#
CACHE=""
#CACHE=" --no-cache"
aptcacher=$(ip route get 1 | awk '{print $7}')
WHERE="--load"
PTF=linux/arm/v7

usage() { echo "Usage: $0 [-c ] no build cache [ -w <load|push>] load into docker images, or push to registry ]" 1>&2; exit 1; }

while getopts ":c:w:" option; do
    case "${option}" in
        c)
            CACHE=" --no-cache"
            ;;
        w)
            WHERE="--"${OPTARG}
            [[ $WHERE == '--load' || $WHERE == '--push' ]] || usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

##add amd if running on amd
[[ $(uname -m) =~ "x86_64" ]] && PTF+=",linux/amd64"
docker buildx build ${WHERE} --platform ${PTF} --build-arg aptcacher=${aptcacher} -f Dockerfile.all -t edgd1er/ntopng-docker:latest .
ret=$?
[[ ${ret} != "0" ]] && echo "\n error while building image" && exit 1

#docker manifest create edgd1er/ntopng-docker edgd1er/ntopng-docker:armhf edgd1er/ntopng-docker:amd64

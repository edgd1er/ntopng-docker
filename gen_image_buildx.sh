#!/usr/bin/env bash
#
IMAGE=ntopng
TAG=latest
DUSER=edgd1er
CACHE=""
#CACHE=" --no-cache"
aptcacher=$(ip route get 1 | awk '{print $7}')
WHERE="--load"

#fonctions
enableMultiArch() {
  docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
  docker buildx rm amd-arm
  docker buildx create --use --name amd-arm --driver-opt image=moby/buildkit:master --platform=linux/amd64,linux/arm64,linux/386,linux/arm/v7,linux/arm/v6
  docker buildx inspect --bootstrap amd-arm
}

usage() {
  echo "Usage: $0 [-n ] no build cache [ -l ] load into docker images, , [ -p ] push to registry ]" 1>&2
  exit 1
}

while getopts ":hlpn" option; do
  case "${option}" in
  h)
    usage
    exit 1
    ;;
  l)
    WHERE="--load"
    ;;
  n)
    CACHE="--no-cache"
    ;;
  p)
    WHERE="--push"
    ;;
  *)
    usage
    ;;
  esac
done
shift $((OPTIND - 1))

##add amd if running on amd
[[ $(uname -m) =~ "x86_64" ]] && PTF="linux/amd64"
[[ ${WHERE} =~ push ]] && PTF+=",linux/arm/v7" && enableMultiArch


echo -e "\nWhere: \e[32m$WHERE\e[0m,  building \e[32m$TAG\e[0m with cahced apt \e[32m${aptcacher}\e[0m on os \e[32m$DISTRO\e[0m using cache \e[32m$CACHE\e[0m and apt cache \e[32m$aptCacher\e[0m for platform \e[32m${PTF}\e[0m\n\n"


docker buildx build ${WHERE} --platform ${PTF} --build-arg aptcacher=${aptcacher} -f Dockerfile.all -t ${DUSER}/${IMAGE}:${TAG} .
ret=$?
[[ ${ret} != "0" ]] && echo "\n error while building image" && exit 1

#docker manifest create edgd1er/ntopng-docker edgd1er/ntopng-docker:armhf edgd1er/ntopng-docker:amd64

FROM debian:buster-slim
MAINTAINER edgd1er <edgd1er@hotmail.com>

ENV TZ=Europe/ParisMAINTAINER edgd1er <edgd1er@hotmail.com>

ENV TZ=Europe/Paris
RUN apt clean all && \
 apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y -q install curl  lsb-release
RUN curl -Ls --remote-name http://apt-stable.ntop.org/20.04/all/apt-ntop-stable.deb && \
  dpkg -i apt-ntop-stable.deb  && rm -rf apt-ntop-stable.deb
RUN apt update && apt-cache search mariadb-client

RUN apt update && DEBIAN_FRONTEND=noninteractive apt-get -yq install ntopng libpcap0.8 mariadb-client
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN find / -iname ntopng -type f -print 

EXPOSE 3001

ENTRYPOINT ["/usr/bin/ntopng"]

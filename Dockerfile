FROM debian:buster-slim
MAINTAINER edgd1er <edgd1er@hotmail.com>

ENV TZ=Europe/Paris
RUN apt clean all && \
 apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y -q install wget lsb-release gnupg
RUN wget http://apt.ntop.org/buster/all/apt-ntop.deb && \
 apt install ./apt-ntop.deb

RUN apt update && DEBIAN_FRONTEND=noninteractive apt-get -yq install ntopng=4\* libpcap0.8 && \
 apt-cache policy ntopng
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN find / -iname ntopng -type f -print 

EXPOSE 3001

ENTRYPOINT ["/usr/bin/ntopng"]

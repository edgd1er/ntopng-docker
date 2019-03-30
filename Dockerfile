FROM balenalib/amd64-ubuntu:bionic
MAINTAINER edgd1er <edgd1er@hotmail.com>

RUN apt clean all && \
 apt-get update && apt-get -y -q install curl  lsb-release 
RUN curl -s --remote-name http://packages.ntop.org/apt/18.04/all/apt-ntop.deb && \
 sudo dpkg -i apt-ntop.deb  && rm -rf apt-ntop.deb
#RUN curl -sL --remote-name http://apt-stable.ntop.org/stretch/all/apt-ntop-stable.deb && \
#RUN curl -sL --remote-name http://apt.ntop.org/stretch/all/apt-ntop.deb && \

RUN apt update && apt-get -y -q install ntopng libpcap0.8 libmariadbclient18 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN ls /opt/
RUN find / -iname ntopng -type f -print 

EXPOSE 3000

ENTRYPOINT ["/usr/bin/ntopng"]

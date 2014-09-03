FROM ubuntu:14.04
MAINTAINER Ivan Malopinsky

RUN apt-get update
RUN apt-get install -y wget

RUN mkdir /root/haxe
RUN wget -O - http://haxe.org/website-content/downloads/3,1,3/downloads/haxe-3.1.3-linux64.tar.gz | tar xzf - --strip=1 -C "/root/haxe"
ENV PATH /root/haxe/:$PATH

WORKDIR /root/haxe

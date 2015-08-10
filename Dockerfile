FROM phusion/baseimage:0.9.17
MAINTAINER Ivan Malopinsky

ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Dependencies
RUN apt-get update && apt-get install -y wget
RUN apt-get install -y g++ g++-multilib libgc-dev
RUN apt-get install -y php5-cli

# Haxe environment variables
ENV HAXEURL http://haxe.org/website-content/downloads/3.2.0/downloads/haxe-3.2.0-linux64.tar.gz
ENV HAXEPATH /root/haxe
ENV HAXE_STD_PATH $HAXEPATH/std/
ENV PATH $HAXEPATH:$PATH

# Neko environment variables
ENV NEKOURL http://nekovm.org/_media/neko-2.0.0-linux64.tar.gz
ENV NEKOPATH /root/neko
ENV LD_LIBRARY_PATH $NEKOPATH
ENV PATH $NEKOPATH:$PATH

# Node environment variables
ENV NODEURL https://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz
ENV NODEPATH /root/node
ENV PATH $NODEPATH/bin:$PATH

RUN mkdir {$NODEPATH,$NEKOPATH,$HAXEPATH}

# Download Node.js
RUN wget -O - NODEURL | tar xzf - --strip=1 -C $NODEPATH

# Download Neko
RUN wget -O - NEKOURL | tar xzf - --strip=1 -C $NEKOPATH

# Download Haxe
RUN wget -O - HAXEURL | tar xzf - --strip=1 -C $HAXEPATH

# Haxelib setup
RUN mkdir /root/haxelib
RUN echo /root/haxelib > /root/.haxelib
RUN cp /root/.haxelib /etc/

# Haxe C++ compiler target
RUN haxelib install hxcpp

# Test
ADD test /root/test
WORKDIR /root/test
RUN mkdir build
RUN haxe build.hxml
RUN ./verify.sh

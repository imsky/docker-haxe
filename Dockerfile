FROM phusion/baseimage:0.9.17
MAINTAINER Ivan Malopinsky

ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Dependencies
RUN apt-get update && apt-get install -y wget

# Haxe environment variables
ENV HAXEPATH /root/haxe
ENV HAXE_STD_PATH $HAXEPATH/std/
ENV PATH $HAXEPATH:$PATH

# Neko environment variables
ENV NEKOPATH /root/neko
ENV LD_LIBRARY_PATH $NEKOPATH
ENV PATH $NEKOPATH:$PATH

# Node environment variables
ENV NODEPATH /root/node
ENV PATH $NODEPATH/bin:$PATH

# Testing depencies

RUN apt-get install -y g++ g++-multilib libgc-dev
RUN apt-get install -y php5-cli

RUN mkdir {$NODEPATH,$NEKOPATH,$HAXEPATH}

# Download Node.js
RUN wget -O - https://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz | tar xzf - --strip=1 -C $NODEPATH

# Download Neko
RUN wget -O - http://nekovm.org/_media/neko-2.0.0-linux64.tar.gz | tar xzf - --strip=1 -C $NEKOPATH

# Download Haxe
RUN wget -O - http://haxe.org/website-content/downloads/3.2.0/downloads/haxe-3.2.0-linux64.tar.gz | tar xzf - --strip=1 -C $HAXEPATH

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

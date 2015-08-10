FROM phusion/baseimage:0.9.17
MAINTAINER Ivan Malopinsky

ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Haxe environment variables
ENV HAXE_STD_PATH /root/haxe/std/
ENV PATH /root/haxe/:$PATH

# Neko environment variables
ENV NEKOPATH /root/neko/
ENV LD_LIBRARY_PATH /root/neko/
ENV PATH /root/neko/:$PATH

# Node environment variables
ENV PATH /root/node/bin:$PATH

# Dependencies
RUN apt-get update && apt-get install -y wget

# Download Node.js
RUN mkdir /root/node
RUN wget -O - https://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz | tar xzf - --strip=1 -C "/root/node"

# Download Neko
RUN mkdir /root/neko
RUN wget -O - http://nekovm.org/_media/neko-2.0.0-linux64.tar.gz | tar xzf - --strip=1 -C "/root/neko"

# Download Haxe
RUN mkdir /root/haxe
RUN wget -O - http://haxe.org/website-content/downloads/3.2.0/downloads/haxe-3.2.0-linux64.tar.gz | tar xzf - --strip=1 -C "/root/haxe"

# Testing depencies

RUN apt-get install -y g++ g++-multilib libgc-dev
RUN apt-get install -y php5-cli

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

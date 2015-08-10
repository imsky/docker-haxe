FROM phusion/baseimage:0.9.16
MAINTAINER Ivan Malopinsky

ENV DEBIAN_FRONTEND noninteractive

ADD test /root/test

# Dependencies
RUN apt-get update && apt-get install -y \
  wget \
  g++ \
  g++-multilib \
  libgc-dev

# Haxe environment variables
ENV HAXE_STD_PATH /root/haxe/std/
ENV PATH /root/haxe/:$PATH

# Neko environment variables
ENV NEKOPATH /root/neko/
ENV LD_LIBRARY_PATH /root/neko/
ENV PATH /root/neko/:$PATH

# Download Neko
RUN mkdir /root/neko
RUN wget -O - http://nekovm.org/_media/neko-2.0.0-linux64.tar.gz | tar xzf - --strip=1 -C "/root/neko"

# Download Haxe
RUN mkdir /root/haxe
RUN wget -O - http://haxe.org/website-content/downloads/3.2.0/downloads/haxe-3.2.0-linux64.tar.gz | tar xzf - --strip=1 -C "/root/haxe"

# Haxelib setup
RUN mkdir /root/haxelib
RUN echo /root/haxelib > /root/.haxelib
RUN cp /root/.haxelib /etc/

# Haxe C++ compiler target
RUN haxelib install hxcpp

# Test
WORKDIR /root/test
RUN mkdir build
RUN haxe build.hxml
RUN build/cpp/Test

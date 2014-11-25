FROM ubuntu:14.04
MAINTAINER Ivan Malopinsky

ADD test /root/test

# Dependencies
RUN apt-get update
RUN apt-get install -y wget g++ g++-multilib libgc-dev

# Download Haxe
RUN mkdir /root/haxe
RUN wget -O - http://haxe.org/website-content/downloads/3,1,3/downloads/haxe-3.1.3-linux64.tar.gz | tar xzf - --strip=1 -C "/root/haxe"

# Download Neko
RUN mkdir /root/neko
RUN wget -O - http://nekovm.org/_media/neko-2.0.0-linux64.tar.gz | tar xzf - --strip=1 -C "/root/neko"

# Haxe environment variables
ENV HAXE_STD_PATH /root/haxe/std/
ENV PATH /root/haxe/:$PATH

# Neko environment variables
ENV NEKOPATH /root/neko/
ENV LD_LIBRARY_PATH /root/neko/
ENV PATH /root/neko/:$PATH

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

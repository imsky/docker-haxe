FROM ubuntu:14.04
MAINTAINER Ivan Malopinsky

RUN apt-get update
RUN apt-get install -y wget libgc-dev

# Download Haxe
RUN mkdir /root/haxe
RUN wget -O - http://haxe.org/website-content/downloads/3,1,3/downloads/haxe-3.1.3-linux64.tar.gz | tar xzf - --strip=1 -C "/root/haxe"
ENV PATH /root/haxe/:$PATH

# Download Neko
RUN mkdir /root/neko
RUN wget -O - http://nekovm.org/_media/neko-2.0.0-linux64.tar.gz | tar xzf - --strip=1 -C "/root/neko"
ENV PATH /root/neko/:$PATH

# Haxe environment variables
ENV HAXE_STD_PATH /root/haxe/std

# Neko environment variables
ENV NEKOPATH /root/neko
ENV LD_LIBRARY_PATH /root/neko/

# Haxelib setup
RUN mkdir /root/haxelib
RUN haxelib setup /root/haxelib

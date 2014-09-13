FROM ubuntu:14.04
MAINTAINER Ivan Malopinsky

ADD test /root/test

# Dependencies

# RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
# RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list

RUN apt-get update
RUN apt-get install -y wget g++ g++-multilib libgc-dev
# RUN apt-get install -y mono-devel

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

# Haxe C++ and Java targets
RUN haxelib install hxcpp
RUN haxelib install hxjava
# RUN haxelib install hxcs

# Test

WORKDIR /root/test
RUN haxe build.hxml

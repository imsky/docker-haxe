# Haxe for Docker

## Requirements

* Linux 3.10+ or OS X/Windows with <http://boot2docker.io>
* Docker 1.3+

## Install

```
docker pull imsky/haxe
```

## Usage

```
docker run --rm -v "$(pwd)":/tmp/hx -w /tmp/hx imsky/haxe haxe build.hxml
```

## Persistent mode

To enable additional compiler targets such as Java and C#, you'll need to run the container in persistent mode.

### Enabling persistence

```
docker kill hx && docker rm hx
docker run -d -v "$(pwd)":/tmp/hx -w /tmp/hx 
--name hx imsky/haxe /root/scripts/background
```

### Enabling Java builds

```
docker exec hx /root/scripts/install-java
```

### Enabling C&#35; builds

```
docker exec hx /root/scripts/install-cs
```

## Building

```
docker build -t imsky/haxe:dev .
```

You should see the following once the build finishes:

```
Test.hx:5: Hello world.
> C++ passed
Hello world.
> JavaScript passed
Hello world.
> Python passed
Test.hx:5: Hello world.
> PHP passed
Test.hx:5: Hello world.
> Neko passed
```

Clean up after builds:

```
docker ps -a --no-trunc | grep Exit | awk '{print $1}' | xargs -r docker rm
docker images --no-trunc | grep none | awk '{print $3}' | xargs -r docker rmi
```

## License

`docker-haxe` is licensed under the MIT license.

## Credits

`docker-haxe` is a project by [Ivan Malopinsky](http://imsky.co).

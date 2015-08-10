# Haxe for Docker

## Install

```
sudo apt-get install docker.io
sudo docker pull imsky/haxe
```

## Usage

The following command will alias `dhaxe` to the Docker `haxe` and run `haxe build.hxml` in the current directory:

### Linux
```
alias dhaxe='sudo docker run --name dhaxe --rm -v "$(pwd)":/tmp/haxe -w /tmp/haxe imsky/haxe haxe'
dhaxe build.hxml
```

### OS X and Windows (through [boot2docker](http://boot2docker.io/))
```
alias dhaxe='docker run --name dhaxe --rm -v "$(pwd)":/tmp/haxe -w /tmp/haxe imsky/haxe haxe'
dhaxe build.hxml
```

## Installing Java

Java is not enabled by default due to the additional resources the JDK takes up. To enable Java, run the following commands:

```
apt-get install default-jdk
haxelib install hxjava
```

## Installing C&#35;

C# is not enabled by default due to the additional resources Mono takes up. To enable C#, run the following commands:

```
apt-key adv --keyserver pgp.mit.edu --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list
apt-get install mono-devel
haxelib install hxcs
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

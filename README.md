# Haxe for Docker

## Install

```
sudo apt-get install docker.io
sudo docker pull imsky/haxe
```

## Usage

The following command will alias `haxeb` to the Docker `haxe` and run `haxe build.hxml` in the current directory:

```
alias dhaxe='sudo docker run --rm -v "$(pwd)":/tmp/haxe -w /tmp/haxe imsky/haxe haxe'
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

## License

`docker-haxe` is licensed under the MIT license.

## Credits

`docker-haxe` is a project by [http://imsky.co](Ivan Malopinsky).

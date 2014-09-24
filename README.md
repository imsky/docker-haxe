# Haxe for Docker

# Usage

The following command will alias `haxeb` to the Docker `haxe` and run `haxe build.hxml` in the current directory:

```
alias haxeb='sudo docker run --rm -v "$(pwd)":/tmp/haxe -w /tmp/haxe imsky/haxe haxe'
haxeb build.hxml
```

# Installing Java

Java is not enabled by default due to the additional resources the JDK takes up. To enable Java, run the following commands:

```
apt-get install default-jdk
haxelib install hxjava
```

# Installing C#

C# is not enabled by default due to the additional resources Mono takes up. To enable C#, run the following commands:

```
apt-key adv --keyserver pgp.mit.edu --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list
apt-get install mono-devel
haxelib install hxcs
```

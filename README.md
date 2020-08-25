# build-vscode-arm64

build script vscode for Raspberry Pi 4 and chromebook(arm64)

https://github.com/microsoft/vscode

# Install code-oss-arm64

download deb from [release](https://github.com/koba-z33/build-vscode-arm64/releases)

And 

```
sudo apt install [download.deb]
```

# build vscode


## environment

* Raspberry Pi 4 Model B 8GB
* Raspberry Pi OS (64 bit) beta test version
    * [download site](https://www.raspberrypi.org/forums/viewtopic.php?t=275370)

## How to install Prerequisites

```
sudo apt update -y
sudo apt install ansible -y
cd ansible
ansible-playbook -i inventory site.yml
```

## How to build

```
./build_code.sh
```
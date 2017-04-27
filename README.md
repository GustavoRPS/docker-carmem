# Carmem Base Image


## How Build

```sh
$ git clone 

$ cd carmem-docker

$ docker build . -t carmem:latest

# Because of prompts to install of flycapture we need install manualy

$ docker run -it --name carmem-base carmem:latest /bin/bash

# execute this command and follow the steps: use the user root

$ cd /tmp && \
  wget https://github.com/LCAD-UFES/carmen_lcad/raw/stable-2.0/ubuntu_packages/flycapture2-2.5.3.4-amd64-pkg.tgz && \
  tar -xvf flycapture2-2.5.3.4-amd64-pkg.tgz && \
  cd flycapture2-2.5.3.4-amd64 && \
  sh install_flycapture.sh
```

## How Use

```sh
$ docker run -it \
         --device=/dev/ttyUSB0 \
         --volume=/usr/src/linux-headers-3.8.0-30:/usr/src/linux-headers-3.8.0-30 \
         carmem:latest \
         /bin/bash
```
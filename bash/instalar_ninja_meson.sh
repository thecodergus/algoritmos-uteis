#! /bin/bash

## Preparativos
sudo apt update && \
sudo apt upgrade -y && \
sudo apt install -y \
        wget\
        unzip\
        ninja-build\
        meson
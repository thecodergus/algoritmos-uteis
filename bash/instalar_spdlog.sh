#! /bin/bash


wget https://github.com/gabime/spdlog/archive/refs/tags/v1.12.0.tar.gz

tar -xvzf v1.12.0.tar.gz

cd spdlog-1.12.0

mkdir build && cd build

cmake -GNinja ..

ninja

sudo ninja install

ldconfig
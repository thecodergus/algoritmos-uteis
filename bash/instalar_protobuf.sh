#! /bin/bash

cd /tmp
git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf
git submodule update --init --recursive
mkdir -p cmake/build
cd cmake/build
cmake ../..
make -j$(nproc)
sudo make install
cd ../../..
sudo rm -rf protobuf

# Atualizando lista de pacotes
sudo ldconfig
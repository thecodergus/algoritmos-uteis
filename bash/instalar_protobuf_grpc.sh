#!/bin/bash

# Atualizar o sistema
sudo apt update -y
sudo apt upgrade -y

# Instalar dependências
sudo apt install -y build-essential autoconf libtool pkg-config cmake

# Instalar gRPC
echo "Instalando gRPC..."
git clone -b v1.39.0 https://github.com/grpc/grpc
cd grpc
git submodule update --init
mkdir -p cmake/build
cd cmake/build
cmake ../..
make -j$(nproc)
sudo make install
cd ../../..
sudo rm -rf grpc

# Instalar Protobuf
echo "Instalando Protobuf..."
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

echo "Instalação completa."

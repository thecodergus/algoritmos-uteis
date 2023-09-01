#! /bin/bash

#!/bin/bash

# Instalar dependências
sudo apt update
sudo apt install -y build-essential autoconf libtool pkg-config cmake

# Clonar o repositório gRPC
git clone --recurse-submodules -b v1.57.0 https://github.com/grpc/grpc

# Entrar no diretório do gRPC
cd grpc

# Criar diretório de build
mkdir -p cmake/build

# Entrar no diretório de build
pushd cmake/build

# Configurar o CMake. Note que o prefixo de instalação foi definido como /usr/local
cmake -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      ../..

# Compilar
make -j$(nproc)

# Instalar
sudo make install

# Sair do diretório de build
popd

# Atualiza as configurações do linker do sistema
sudo ldconfig

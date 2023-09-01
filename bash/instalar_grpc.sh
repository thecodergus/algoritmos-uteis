#! /bin/bash

# Define o diretório de instalação como /usr/local
export MY_INSTALL_DIR=/usr/local

# Cria o diretório de instalação, se ele não existir
mkdir -p $MY_INSTALL_DIR

# Instala o CMake
sudo apt install -y cmake

# Instala as ferramentas essenciais para compilação e outras dependências
sudo apt install -y build-essential autoconf libtool pkg-config

# Clona o repositório do gRPC na versão 1.57.0
wget https://github.com/grpc/grpc/archive/refs/tags/v1.57.0.tar.gz
tar -xzvf grpc-1.57.0.tar.gz

# Entra no diretório do gRPC
cd grpc-1.57.0

# Cria um diretório para a construção com CMake
mkdir -p cmake/build

# Entra no diretório de construção
pushd cmake/build

# Configura o CMake com as opções desejadas
cmake -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=OFF \
      -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
      ../..

# Compila o projeto usando 4 núcleos
sudo make -j 4

# Instala os arquivos compilados no diretório de instalação
sudo make install

# Retorna ao diretório original
popd

# Atualizando lista de pacotes
sudo ldconfig
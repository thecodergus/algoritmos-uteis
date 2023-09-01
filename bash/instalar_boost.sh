#! /bin/bash

# Atualiza a lista de pacotes disponíveis no repositório do sistema
sudo apt update

# Instala as dependências necessárias para compilar e instalar a biblioteca Boost
sudo apt install -y \
    cmake \
    wget \
    tar \
    make \
    gcc \
    g++

# Baixa a versão 1.83.0 da biblioteca Boost do GitHub
wget https://github.com/boostorg/boost/releases/download/boost-1.83.0/boost-1.83.0.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf boost-1.83.0.tar.gz

# Entra no diretório do código-fonte descompactado
cd boost-1.83.0

# Cria um diretório para a construção do projeto e entra nele
mkdir build
cd build

# Executa o CMake para preparar a compilação do projeto
cmake ..

# Compila e instala a biblioteca Boost no sistema
sudo make install

# Atualizando lista de pacotes
sudo ldconfig
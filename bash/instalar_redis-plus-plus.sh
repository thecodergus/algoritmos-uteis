#! /bin/bash

# Nota: Instale a biblioteca hiredis primeiro.

# Atualiza a lista de pacotes disponíveis no repositório
sudo apt update

# Instala as dependências necessárias para compilar e instalar a biblioteca redis-plus-plus
sudo apt install -y \
    cmake \
    wget \
    tar \
    make \
    gcc \
    g++

# Baixa a versão 1.3.10 da biblioteca redis-plus-plus do GitHub
wget https://github.com/sewenew/redis-plus-plus/archive/refs/tags/1.3.10.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf 1.3.10.tar.gz

# Entra no diretório do código-fonte descompactado
cd redis-plus-plus-1.3.10

# Cria um diretório para a construção e entra nele
mkdir build
cd build

# Executa o CMake para configurar o projeto
cmake ..

# Instala a biblioteca no sistema
sudo make install

#! /bin/bash

# Atualiza a lista de pacotes disponíveis no repositório
sudo apt update

# Instala as dependências necessárias para compilar e instalar a biblioteca hiredis
sudo apt install -y \
    cmake \
    wget \
    tar \
    make \
    gcc \
    g++ 

# Baixa a versão 1.2.0 da biblioteca hiredis do GitHub
wget https://github.com/redis/hiredis/archive/refs/tags/v1.2.0.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf v1.2.0.tar.gz

# Entra no diretório do código-fonte descompactado
cd hiredis-1.2.0

# Cria um diretório para a construção e entra nele
mkdir build
cd build

# Executa o CMake para configurar o projeto
cmake ..

# Instala a biblioteca no sistema
sudo make install

# Atualizando lista de pacotes
sudo ldconfig
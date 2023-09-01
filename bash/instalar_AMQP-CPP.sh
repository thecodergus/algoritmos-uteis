#! /bin/bash

# Atualiza a lista de pacotes disponíveis no repositório
sudo apt update

# Instala as dependências necessárias para compilar e instalar a biblioteca AMQP-CPP
sudo apt install -y \
    cmake \
    wget \
    tar \
    make \
    gcc \
    g++

# Baixa a versão 4.3.26 da biblioteca AMQP-CPP do GitHub
wget https://github.com/CopernicaMarketingSoftware/AMQP-CPP/archive/refs/tags/v4.3.26.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf v4.3.26.tar.gz

# Entra no diretório do código-fonte descompactado
cd AMQP-CPP-4.3.26

# Cria um diretório para a construção e entra nele
mkdir build
cd build

# Executa o CMake para configurar o projeto
cmake ..

# Instala a biblioteca no sistema
sudo make install

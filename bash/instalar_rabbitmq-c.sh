#! /bin/bash

# Atualiza a lista de pacotes disponíveis no repositório do sistema
sudo apt update

# Instala as dependências necessárias para compilar e instalar a biblioteca rabbitmq-c
sudo apt install -y \
    cmake \
    wget \
    tar \
    make

# Baixa a versão 0.13.0 da biblioteca rabbitmq-c do GitHub
wget https://github.com/alanxz/rabbitmq-c/archive/refs/tags/v0.13.0.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -zxvf v0.13.0.tar.gz

# Entra no diretório do código-fonte descompactado
cd rabbitmq-c-0.13.0/

# Cria um diretório para a construção do projeto e entra nele
mkdir build
cd build

# Executa o CMake para preparar a compilação do projeto
cmake ..

# Compila a biblioteca
make

# Instala a biblioteca rabbitmq-c no sistema
sudo make install

# Atualizando lista de pacotes
sudo ldconfig
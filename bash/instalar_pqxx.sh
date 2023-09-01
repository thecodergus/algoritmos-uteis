#! /bin/bash

# Atualiza a lista de pacotes disponíveis no repositório
sudo apt update

# Instala as dependências necessárias para compilar e instalar a biblioteca pqxx
sudo apt install -y \
    cmake \
    wget \
    tar \
    make \
    gcc \
    g++ \
    libpq-dev

# Baixa a versão 7.8.1 da biblioteca pqxx do GitHub
wget https://github.com/jtv/libpqxx/archive/refs/tags/7.8.1.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf 7.8.1.tar.gz

# Entra no diretório do código-fonte descompactado
cd libpqxx-7.8.1

# Cria um diretório para a construção e entra nele
mkdir build
cd build

# Executa o CMake para configurar o projeto
cmake ..

# Compila o projeto
make

# Instala o projeto no sistema
sudo make install

# Atualizando lista de pacotes
sudo ldconfig
#! /bin/bash

# Atualiza o índice de pacotes do sistema
sudo apt update

# Instala as dependências necessárias para compilar e instalar o Boost
sudo apt install -y \
    cmake \
    wget \
    tar \
    make \
    gcc \
    g++

# Baixa o código-fonte do Boost versão 1.83.0 do repositório oficial
wget https://github.com/boostorg/boost/releases/download/boost-1.83.0/boost-1.83.0.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf boost-1.83.0.tar.gz

# Entra no diretório descompactado
cd boost-1.83.0

# Executa o script bootstrap para preparar a compilação
./bootstrap.sh

# Compila e instala a biblioteca Boost
# As flags "-fPIC" são usadas para criar código apropriado para bibliotecas compartilhadas
# "link=static,shared" indica que tanto as bibliotecas estáticas quanto as compartilhadas serão construídas
# "--prefix=/usr/local" define que os arquivos serão instalados no diretório /usr/local
sudo ./b2 cxxflags="-fPIC" link=static,shared --prefix=/usr/local install


# Atualizando lista de pacotes
sudo ldconfig
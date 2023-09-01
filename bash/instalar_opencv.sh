#! /bin/bash

VERSAO="4.8.0"

# Certifique-se de instalar o Ninja antes de executar este script

# Atualiza o índice de pacotes do sistema
sudo apt update

# Instala as dependências necessárias para compilar e instalar o OpenCV
sudo apt install -y \
    cmake \
    git \
    tar \
    wget \
    gcc \
    g++ \
    libjpeg62-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev\
    libtbb-dev \
    libpng-dev

# Baixa o código-fonte do OpenCV versão 4.8.0 do repositório oficial
wget https://github.com/opencv/opencv/archive/refs/tags/$VERSAO.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf $VERSAO.tar.gz

# Entra no diretório descompactado
cd opencv-$VERSAO

# Cria um diretório para a construção (compilação) do código
mkdir build

# Entra no diretório de construção
cd build

# Executa o CMake para configurar o projeto para compilação
# Utiliza o gerador Ninja para compilação
cmake -GNinja -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON ..

# Compila o projeto usando Ninja
ninja

# Instala os arquivos compilados no sistema
sudo ninja install

# Atualiza o cache de bibliotecas dinâmicas do sistema
sudo ldconfig
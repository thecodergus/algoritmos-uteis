#! /bin/bash

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
    g++

# Baixa o código-fonte do OpenCV versão 4.8.0 do repositório oficial
wget https://github.com/opencv/opencv/archive/refs/tags/4.8.0.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf 4.8.0.tar.gz

# Entra no diretório descompactado
cd opencv-4.8.0

# Cria um diretório para a construção (compilação) do código
mkdir build

# Entra no diretório de construção
cd build

# Executa o CMake para configurar o projeto para compilação
# Utiliza o gerador Ninja para compilação
cmake -GNinja ..

# Compila o projeto usando Ninja
ninja

# Instala os arquivos compilados no sistema
sudo ninja install

# Atualiza o cache de bibliotecas dinâmicas do sistema
sudo ldconfig
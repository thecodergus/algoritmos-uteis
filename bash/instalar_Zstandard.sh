#! /bin/bash

# Configuração de variáveis
VERSAO_ZSTANDARD="1.5.5"

# Atualiza os pacotes do sistema
sudo apt update -y

# Instalação das dependências necessárias para compilar e instalar o Zstandard
sudo apt install -y \
    wget \
    build-essential \
    cmake \
    git \
    tar \
    gzip \
    g++ \
    gcc 

# Baixa o pacote do Zstandard da versão especificada
wget https://github.com/facebook/zstd/releases/download/v$VERSAO_ZSTANDARD/zstd-$VERSAO_ZSTANDARD.tar.gz

# Descompacta o pacote baixado
tar -xvf zstd-$VERSAO_ZSTANDARD.tar.gz

# Entra no diretório descompactado
cd zstd-$VERSAO_ZSTANDARD

# Compila o Zstandard usando todos os núcleos disponíveis
make -j$(nproc)

# Instala o Zstandard no sistema
sudo make install

# Atualiza as bibliotecas do sistema
sudo ldconfig

# Retorna ao diretório anterior
cd ..

# Remove o diretório descompactado e o arquivo baixado para limpeza
rm -rf zstd-$VERSAO_ZSTANDARD
rm -rf zstd-$VERSAO_ZSTANDARD.tar.gz

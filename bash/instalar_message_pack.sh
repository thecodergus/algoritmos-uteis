#! /bin/bash

# Primeiro, instale o Ninja se ainda não estiver instalado

# Atualizando lista de pacotes
sudo apt update

# Instalando dependencias
sudo apt install -y \
        libgtest-dev

# Baixa a versão 6.0.0 da biblioteca msgpack-c do GitHub
wget https://github.com/msgpack/msgpack-c/releases/download/c-6.0.0/msgpack-c-6.0.0.tar.gz

# Baixa a versão 6.1.0 da biblioteca msgpack-cxx do GitHub
wget https://github.com/msgpack/msgpack-c/releases/download/cpp-6.1.0/msgpack-cxx-6.1.0.tar.gz

# Descompacta o arquivo tar.gz da biblioteca msgpack-c
tar -xvzf msgpack-c-6.0.0.tar.gz

# Descompacta o arquivo tar.gz da biblioteca msgpack-cxx
tar -xvzf msgpack-cxx-6.1.0.tar.gz

# Entra no diretório descompactado da msgpack-c
cd msgpack-c-6.0.0

# Cria um diretório chamado 'build' para a compilação
mkdir build

# Entra no diretório 'build'
cd build

# Executa o CMake com o gerador Ninja e define o diretório de instalação
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -GNinja ..

# Compila o código usando Ninja
ninja

# Instala a biblioteca msgpack-c no sistema
sudo ninja install

# Volta para o diretório raiz
cd ../..

# Entra no diretório descompactado da msgpack-cxx
cd msgpack-cxx-6.1.0

# Cria um diretório chamado 'build' para a compilação
mkdir build

# Entra no diretório 'build'
cd build

# Executa o CMake com o gerador Ninja e define o diretório de instalação
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -GNinja ..

# Compila o código usando Ninja
ninja

# Instala a biblioteca msgpack-cxx no sistema
sudo ninja install

# Atualiza as bibliotecas do sistema para garantir que as novas bibliotecas sejam reconhecidas
sudo ldconfig

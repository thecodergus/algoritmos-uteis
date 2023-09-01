#!/bin/bash

# Primeiro instale ninja

# Atualizar lista de pacotes
sudo apt-get update

# Instalar compilador C++ e outras dependências
sudo apt-get install -y g++ cmake libasio-dev zlib1g-dev libssl-dev python3

# Clonar o repositório Crow
git clone https://github.com/CrowCpp/Crow.git

# Navegar para o diretório do projeto
cd Crow

# Criar diretório de build e entrar nele
mkdir build
cd build

# Configurar CMake
cmake .. -DCROW_BUILD_EXAMPLES=OFF -DCROW_BUILD_TESTS=OFF

# Compilar e instalar
ninja

sudo ninja install

echo "Instalação do Crow e dependências concluída."

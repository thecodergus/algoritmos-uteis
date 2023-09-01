#!/bin/bash

# Atualizar lista de pacotes
sudo apt update

# Instalar dependências
sudo apt install -y cmake g++ python3-dev

# Clonar o repositório pybind11
wget https://github.com/pybind/pybind11/archive/refs/tags/v2.11.1.tar.gz
tar -xvzf v2.11.1.tar.gz

# Navegar para o diretório do projeto
cd pybind11-2.11.1

# Criar diretório de build e entrar nele
mkdir build
cd build

# Configurar CMake
cmake -GNinja ..

# Compilar e instalar
ninja
sudo 
sudo ninja install

echo "Instalação do pybind11 concluída."

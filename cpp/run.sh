#!/bin/bash


# Configurações
if [ $1 == "prod" ]; then
    export CXX=g++ # Escolhendo o compilador
    export CC=gcc # Escolhendo o compilador
else
    export CXX=clang++ # Escolhendo o compilador
    export CC=clang # Escolhendo o compilador
fi

# Configurar o projeto
# Verificando se a pasta existe
if [ -d "build" ]; then
    meson setup build --reconfigure # Reconfigurando o meson se a pasta já existe
else
    meson setup build # Configurando o meson se a pasta não existe
fi

# Compilar o projeto
cd build

if ninja; then
    echo "Compilado com sucesso!"
    # Executar o projeto
    ./backend_revisor
else
    echo "Falha na compilação!"
    exit 1
fi

# Limpar o projeto
rm -rf build

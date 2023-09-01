#! /bin/bash

# Instale Ninja primeiro

# Baixa a versão 6.1.0 do MessagePack para C++ do GitHub
wget https://github.com/msgpack/msgpack-c/releases/download/cpp-6.1.0/msgpack-cxx-6.1.0.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf msgpack-cxx-6.1.0.tar.gz

# Entra no diretório descompactado
cd msgpack-cxx-6.1.0

# Cria um diretório chamado 'build' para compilação
mkdir build

# Entra no diretório 'build'
cd build

# Executa o CMake com o gerador Ninja
cmake -GNinja ..

# Compila o código usando Ninja
ninja

# Instala a biblioteca no sistema
sudo ninja install

# Atualiza as bibliotecas do sistema
sudo ldconfig

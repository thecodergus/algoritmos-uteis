#! /bin/bash

# Atualiza a lista de pacotes disponíveis do repositório
sudo apt update 

# Instala as dependências necessárias para Python3 e outros utilitários
sudo apt install -y python3-wheel python3-dev tar python3-pip

# Baixa o pacote Meson da versão 1.2.1 do GitHub
wget https://github.com/mesonbuild/meson/releases/download/1.2.1/meson-1.2.1.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xzvf meson-1.2.1.tar.gz

# Navega para o diretório do Meson descompactado
cd meson-1.2.1

# Instala o Meson usando o setup.py com Python3
sudo python3 setup.py install

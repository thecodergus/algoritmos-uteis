#! /bin/bash

# Versão do protobuf
VERSAO="24.2"

# Salvando a arquitetura do sistema
ARQUITETURA="$(uname -i)"

# Baixa o arquivo ZIP do Protobuf para a arquitetura do sistema atual
wget https://github.com/protocolbuffers/protobuf/releases/download/v$VERSAO/protoc-$VERSAO-linux-$ARQUITETURA.zip

# Descompacta o arquivo ZIP baixado em um diretório chamado 'protoc'
unzip protoc-$VERSAO-linux-$ARQUITETURA.zip -d protoc

# Move o executável 'protoc' para o diretório /usr/local/bin/
sudo mv protoc/bin/protoc /usr/local/bin/

# Move os arquivos de inclusão para o diretório /usr/local/include/
sudo mv protoc/include/* /usr/local/include/

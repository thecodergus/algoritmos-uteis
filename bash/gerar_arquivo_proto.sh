#!/bin/bash

# Diretório onde o arquivo .proto está localizado
PROTO_DIR="./protos"

# Nome do arquivo .proto
PROTO_FILE="route_guide.proto"

# Diretórios de saída para arquivos de cabeçalho e código-fonte
INCLUDE_DIR="./include"
SRC_DIR="./src"

# Verificar se os diretórios de saída existem; caso contrário, criá-los
mkdir -p $INCLUDE_DIR
mkdir -p $SRC_DIR

# Gerar arquivos de código-fonte gRPC
protoc -I $PROTO_DIR --grpc_out=$SRC_DIR --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` $PROTO_DIR/$PROTO_FILE

# Gerar arquivos de código-fonte C++ do Protocol Buffers
protoc -I $PROTO_DIR --cpp_out=$SRC_DIR $PROTO_DIR/$PROTO_FILE

# Mover arquivos de cabeçalho para o diretório 'include'
mv $SRC_DIR/*.h $INCLUDE_DIR/

echo "Geração de código concluída."

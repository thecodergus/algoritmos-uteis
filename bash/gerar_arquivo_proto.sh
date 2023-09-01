#!/bin/bash

# Nome do arquivo .proto
PROTO_FILE="estrutura_servidor_rpc.proto"

# Gerar código C++ a partir do arquivo .proto
protoc -I=$SRC_DIR --cpp_out=$DST_DIR $SRC_DIR/$PROTO_FILE.proto

# Mover arquivos de cabeçalho para a pasta 'include'
mv $DST_DIR/$PROTO_FILE.pb.h $DST_DIR/include/

# Mover arquivos de código-fonte para a pasta 'src'
mv $DST_DIR/$PROTO_FILE.pb.cc $DST_DIR/src/
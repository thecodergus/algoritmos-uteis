#!/bin/bash

# Desinstalar gRPC
echo "Desinstalando gRPC..."
sudo rm -rf /usr/local/include/grpc
sudo rm -rf /usr/local/include/grpc++
sudo rm -rf /usr/local/lib/libgrpc*
sudo rm -rf /usr/local/lib/pkgconfig/grpc.pc
sudo rm -rf /usr/local/lib/pkgconfig/grpc++.pc

# Desinstalar Protobuf
echo "Desinstalando Protobuf..."
sudo rm -rf /usr/local/include/google/protobuf
sudo rm -rf /usr/local/bin/protoc
sudo rm -rf /usr/local/lib/libproto*
sudo rm -rf /usr/local/lib/pkgconfig/protobuf.pc
sudo rm -rf /usr/local/lib/pkgconfig/protobuf-lite.pc

echo "Desinstalação completa."
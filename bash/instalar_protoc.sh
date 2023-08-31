#! /bin/bash

wget https://github.com/protocolbuffers/protobuf/releases/download/v24.2/protoc-24.2-linux-$(uname -i).zip
unzip protoc-24.2-linux-x86_64.zip -d protoc
sudo mv protoc/bin/protoc /usr/local/bin/
sudo mv protoc/include/* /usr/local/include/

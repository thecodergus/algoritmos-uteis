#! /bin/bash

# Atualiza a lista de pacotes do sistema
sudo apt update

# Instala pacotes necessários para o transporte seguro e manipulação de chaves GPG
sudo apt install -y apt-transport-https ca-certificates gnupg curl sudo

# Adiciona o repositório do Google Cloud SDK à lista de fontes do APT
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Baixa e adiciona a chave GPG do repositório do Google Cloud SDK
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Atualiza novamente a lista de pacotes, agora incluindo o novo repositório do Google Cloud SDK
sudo apt update

# Instala o Google Cloud CLI
sudo apt install -y google-cloud-cli

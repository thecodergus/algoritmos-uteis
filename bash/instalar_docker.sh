#! /bin/bash

## Configurações
RED='\033[0;31m'
NO_COLOR='\033[0m'

# Removendo Pacotes de versões anteriores
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
    echo -e "$RED Removendo $pkg $NO_COLOR"
    sudo apt remove -y $pkg; 
done

# Atualizando os pacotes
echo -e "$RED -> Atualizando os pacotes $pkg $NO_COLOR"
sudo  apt update

# Instalando dependencias minimas
echo -e "$RED -> Instalando dependencias minimas $pkg $NO_COLOR"
sudo  apt install -y ca-certificates curl gnupg

# Adicionando chave Docker GPG
echo -e "$RED -> Adicionando chave Docker GPG $pkg $NO_COLOR"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo  chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null


# Atualizando pacotes novamente
echo -e "$RED -> Atualizando pacotes novamente $pkg $NO_COLOR"
sudo apt update

# Instalando o docker em si
echo -e "$RED -> Instalando o docker em si $pkg $NO_COLOR"
sudo  apt install -y docker-ce \
            docker-ce-cli \
            containerd.io \
            docker-buildx-plugin \
            docker-compose-plugin

# Criando grupo de usuarios docker
echo -e "$RED -> Criando grupo de usuarios docker $pkg $NO_COLOR"
sudo  groupadd docker
sudo  usermod -aG docker $USER
newgrp docker
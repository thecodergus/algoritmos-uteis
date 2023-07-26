#! /bin/bash

## Configurações
RED='\033[0;31m'
NO_COLOR='\033[0m'

# Verifica se o script está sendo executado como superusuário
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Por favor, execute este script como superusuário (sudo)${NO_COLOR}"
    exit 1
fi

# Removendo Pacotes de versões anteriores
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
    echo -e "$RED Removendo $pkg $NO_COLOR"
    apt remove -y $pkg; 
done

# Atualizando os pacotes
echo -e "$RED -> Atualizando os pacotes $pkg $NO_COLOR"
apt update

# Instalando dependencias minimas
echo -e "$RED -> Instalando dependencias minimas $pkg $NO_COLOR"
apt install -y ca-certificates curl gnupg

# Adicionando chave Docker GPG
echo -e "$RED -> Adicionando chave Docker GPG $pkg $NO_COLOR"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null


# Atualizando pacotes novamente
echo -e "$RED -> Atualizando pacotes novamente $pkg $NO_COLOR"
apt update

# Instalando o docker em si
echo -e "$RED -> Instalando o docker em si $pkg $NO_COLOR"
apt install -y docker-ce \
            docker-ce-cli \
            containerd.io \
            docker-buildx-plugin \
            docker-compose-plugin

# Criando grupo de usuarios docker
echo -e "$RED -> Criando grupo de usuarios docker $pkg $NO_COLOR"
groupadd docker
usermod -aG docker $USER
newgrp docker
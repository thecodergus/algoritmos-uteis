#! /bin/bash

# Nota: Execute o script para baixar meson primeiro.
# Nota: Execute o script para baixar ninja primeiro.

# Atualiza a lista de pacotes disponíveis do repositório
sudo apt update

# Instala todas as dependências necessárias listadas
sudo apt install -y libxml2-dev \
                    libglib2.0-dev \
                    cmake \
                    libusb-1.0-0-dev \
                    gobject-introspection \
                    libgtk-3-dev \
                    gtk-doc-tools \
                    xsltproc \
                    libgstreamer1.0-dev \
                    libgstreamer-plugins-base1.0-dev \
                    libgstreamer-plugins-good1.0-dev \
                    libgirepository1.0-dev gettext \
                    jq \
                    glibc-source

# Pega a última versão do projeto Aravis usando a API do GitHub
LAST_ARAVIS_VERSION=$(curl --silent "https://api.github.com/repos/AravisProject/aravis/releases/latest" | jq -r .tag_name)

# Baixa o código fonte da última versão do Aravis
wget https://github.com/AravisProject/aravis/archive/refs/tags/$LAST_ARAVIS_VERSION.tar.gz

# Descompacta o arquivo tar.gz baixado
tar -xvzf ${LAST_ARAVIS_VERSION}.tar.gz

# Entra no diretório do código fonte descompactado
cd aravis-${LAST_ARAVIS_VERSION}

# Configura o projeto Aravis para construção com Meson
meson setup build

# Entra no diretório de construção
cd build

# Compila o projeto usando Ninja
ninja

# Instala o projeto no sistema
sudo ninja install

# Atualizando lista de pacotes
sudo ldconfig
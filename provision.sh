#!/bin/bash
# provision-no-curl.sh - Instala Node.js sem usar curl

set -e

NODE_VERSION="12.20.0"
NODE_URL="https://nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"
INSTALL_DIR="/opt/nodejs"

print_status() { echo -e "\033[0;32m[INFO]\033[0m $1"; }

# Instalar wget (que pode não ter o mesmo problema)
pacman -S --noconfirm wget xz

# Criar diretório de instalação
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Download com wget instead of curl
print_status "Baixando Node.js $NODE_VERSION com wget..."
wget $NODE_URL

# Extrair e instalar
tar -xf node-v$NODE_VERSION-linux-x64.tar.xz
rm node-v$NODE_VERSION-linux-x64.tar.xz

# Links simbólicos
ln -sf $INSTALL_DIR/node-v$NODE_VERSION-linux-x64/bin/node /usr/local/bin/node
ln -sf $INSTALL_DIR/node-v$NODE_VERSION-linux-x64/bin/npm /usr/local/bin/npm
ln -sf $INSTALL_DIR/node-v$NODE_VERSION-linux-x64/bin/npx /usr/local/bin/npx

# Instalar yarn
print_status "Instalando Yarn..."
./node-v$NODE_VERSION-linux-x64/bin/npm install -g yarn
ln -sf $INSTALL_DIR/node-v$NODE_VERSION-linux-x64/bin/yarn /usr/local/bin/yarn

print_status "Node.js $NODE_VERSION instalado com sucesso!"
node --version

print_status "Instalando Angular cli..."
npm install -g @angular/cli

print_Status "Instalando Ionic Cli..."
npm install -g @ionic/cli

print_status "Angular CLI e Ionic CLI instalados com sucesso!"

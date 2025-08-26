#!/bin/bash
# provision-binary-wget.sh - Instala Node.js usando wget

set -e

NODE_VERSION="12.20.0"
NODE_URL="https://nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"
INSTALL_DIR="/opt/node-v$NODE_VERSION"

print_status() { echo -e "\033[0;32m[INFO]\033[0m $1"; }

# 1. Instalar wget (que não tem o problema do OpenSSL)
print_status "Instalando wget..."
pacman -S --needed --noconfirm wget xz

# 2. Download com wget
print_status "Baixando Node.js $NODE_VERSION..."
wget $NODE_URL -O /tmp/node.tar.xz

# 3. Extrair e instalar
mkdir -p $INSTALL_DIR
tar -xf /tmp/node.tar.xz -C $INSTALL_DIR --strip-components=1
rm /tmp/node.tar.xz

# 4. Links simbólicos
ln -sf $INSTALL_DIR/bin/node /usr/local/bin/node
ln -sf $INSTALL_DIR/bin/npm /usr/local/bin/npm
ln -sf $INSTALL_DIR/bin/npx /usr/local/bin/npx

# 5. Instalar yarn
$INSTALL_DIR/bin/npm install -g yarn
ln -sf $INSTALL_DIR/bin/yarn /usr/local/bin/yarn

print_status "Node.js $NODE_VERSION instalado com sucesso!"
node --version
npm --version

print_status "Instalando Angular CLI e Ionic CLI..."
npm install -g @angular/cli
npm install -g @ionic/cli

print_status "Angular cli e Ionic CLI instalados com sucesso!"

directory="/vagrant"

if [ -n "$(ls -A "$directory")" ]; then
  echo "Building projects.."
  cd /vagrant && npm install
else
  echo "Don\' have projects in vagrant directory... Clone to use"
fi


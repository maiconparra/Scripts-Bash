#!/bin/bash
# bin/install.sh - Instalador automático do Scripts-Bash
set -e

REPO_URL="https://github.com/maiconparra/Scripts-Bash.git"
REPO_DIR="Scripts-Bash"

sudo apt update
sudo apt install -y git curl whiptail

if [ ! -f bin/setup_menu.sh ]; then
  if [ -d "$REPO_DIR" ]; then
    cd "$REPO_DIR"
  else
    git clone "$REPO_URL"
    cd "$REPO_DIR"
  fi
fi

chmod +x bin/*.sh modules/*.sh utils/*.sh

bash bin/setup_menu.sh
sudo ln -sf "$(pwd)/bin/wifipirata" /usr/local/bin/wifipirata

echo "Comando 'wifipirata' instalado. Use 'wifipirata --help' para ver as opções."

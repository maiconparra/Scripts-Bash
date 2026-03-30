#!/bin/bash
# modules/mongodb.sh - Instala ou remove o MongoDB
source /home/maiconparra/Scripts-Bash/utils/common.sh

VERSION="$1"
ACTION="$2"

check_ubuntu
validate_args "$VERSION" "$ACTION"

case "$ACTION" in
    install)
        log "Instalando MongoDB $VERSION..."
        wget -qO - https://www.mongodb.org/static/pgp/server-$VERSION.asc | sudo apt-key add -
        echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/$VERSION multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-$VERSION.list
        sudo apt update
        sudo apt install -y mongodb-org
        log "MongoDB $VERSION instalado."
        ;;
    remove)
        log "Removendo MongoDB $VERSION..."
        sudo apt purge --auto-remove -y mongodb-org*
        sudo rm -rf /var/log/mongodb /var/lib/mongodb
        log "MongoDB removido."
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

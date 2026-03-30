#!/bin/bash
# modules/mariadb.sh - Instala ou remove o MariaDB
source /home/maiconparra/Scripts-Bash/utils/common.sh

VERSION="$1"
ACTION="$2"

check_ubuntu
validate_args "$VERSION" "$ACTION"

case "$ACTION" in
    install)
        log "Instalando MariaDB $VERSION..."
        sudo apt update
        sudo apt install -y mariadb-server
        log "MariaDB $VERSION instalado."
        ;;
    remove)
        log "Removendo MariaDB $VERSION..."
        sudo apt purge --auto-remove -y mariadb-server mariadb-client
        sudo rm -rf /etc/mysql /var/lib/mysql
        log "MariaDB removido."
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

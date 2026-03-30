#!/bin/bash
# modules/mysql.sh - Instala ou remove o MySQL
source /home/maiconparra/Scripts-Bash/utils/common.sh

VERSION="$1"
ACTION="$2"

check_ubuntu
validate_args "$VERSION" "$ACTION"

case "$ACTION" in
    install)
        log "Instalando MySQL $VERSION..."
        sudo apt update
        sudo apt install -y mysql-server
        log "MySQL $VERSION instalado."
        ;;
    remove)
        log "Removendo MySQL $VERSION..."
        sudo apt purge --auto-remove -y mysql-server mysql-client mysql-common
        sudo rm -rf /etc/mysql /var/lib/mysql
        log "MySQL removido."
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

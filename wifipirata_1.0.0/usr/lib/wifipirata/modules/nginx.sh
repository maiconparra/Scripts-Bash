#!/bin/bash
# modules/nginx.sh - Instala ou remove o Nginx
source /home/maiconparra/Scripts-Bash/utils/common.sh

ACTION="$1"

check_ubuntu
validate_args "dummy" "$ACTION"

case "$ACTION" in
    install)
        if command -v nginx >/dev/null 2>&1; then
            log "Nginx já está instalado."
        else
            log "Instalando Nginx..."
            sudo apt update
            sudo apt install -y nginx
            log "Nginx instalado."
        fi
        ;;
    remove)
        if command -v nginx >/dev/null 2>&1; then
            log "Removendo Nginx..."
            sudo apt purge --auto-remove -y nginx
            sudo rm -rf /etc/nginx
            log "Nginx removido."
        else
            log "Nginx não encontrado."
        fi
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

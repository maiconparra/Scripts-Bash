#!/bin/bash
# modules/apache2.sh - Instala ou remove o Apache2
source /home/maiconparra/Scripts-Bash/utils/common.sh

ACTION="$1"

check_ubuntu
validate_args "dummy" "$ACTION"

case "$ACTION" in
    install)
        if command -v apache2 >/dev/null 2>&1; then
            log "Apache2 já está instalado."
        else
            log "Instalando Apache2..."
            sudo apt update
            sudo apt install -y apache2
            log "Apache2 instalado."
        fi
        ;;
    remove)
        if command -v apache2 >/dev/null 2>&1; then
            log "Removendo Apache2..."
            sudo apt purge --auto-remove -y apache2
            sudo rm -rf /etc/apache2
            log "Apache2 removido."
        else
            log "Apache2 não encontrado."
        fi
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

#!/bin/bash
# modules/kubernetes.sh - Instala ou remove o Kubernetes (kubectl)
source /home/maiconparra/Scripts-Bash/utils/common.sh

ACTION="$1"

check_ubuntu
validate_args "dummy" "$ACTION"

case "$ACTION" in
    install)
        if command -v kubectl >/dev/null 2>&1; then
            log "kubectl já está instalado."
        else
            log "Instalando kubectl..."
            curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
            sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
            rm kubectl
            log "kubectl instalado."
        fi
        ;;
    remove)
        if command -v kubectl >/dev/null 2>&1; then
            log "Removendo kubectl..."
            sudo rm -f /usr/local/bin/kubectl
            log "kubectl removido."
        else
            log "kubectl não encontrado."
        fi
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

#!/bin/bash
# modules/docker.sh - Instala ou remove o Docker
source /home/maiconparra/Scripts-Bash/utils/common.sh

ACTION="$1"

check_ubuntu
validate_args "dummy" "$ACTION"

case "$ACTION" in
    install)
        if command -v docker >/dev/null 2>&1; then
            log "Docker já está instalado."
        else
            log "Instalando Docker..."
            sudo apt update
            sudo apt install -y ca-certificates curl gnupg lsb-release
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            echo \ 
              "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
              $(lsb_release -cs) stable" | \
              sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt update
            sudo apt install -y docker-ce docker-ce-cli containerd.io
            log "Docker instalado."
        fi
        ;;
    remove)
        if command -v docker >/dev/null 2>&1; then
            log "Removendo Docker..."
            sudo apt purge --auto-remove -y docker-ce docker-ce-cli containerd.io
            sudo rm -rf /var/lib/docker /var/lib/containerd
            log "Docker removido."
        else
            log "Docker não encontrado."
        fi
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

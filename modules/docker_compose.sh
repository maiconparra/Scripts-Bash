#!/bin/bash
# modules/docker_compose.sh - Instala ou remove o Docker Compose
source /home/maiconparra/Scripts-Bash/utils/common.sh

VERSION="$1"
ACTION="$2"

check_ubuntu
validate_args "$VERSION" "$ACTION"

case "$ACTION" in
    install)
        log "Instalando Docker Compose $VERSION..."
        sudo curl -L "https://github.com/docker/compose/releases/download/v$VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        log "Docker Compose instalado."
        ;;
    remove)
        log "Removendo Docker Compose..."
        sudo rm -f /usr/local/bin/docker-compose
        log "Docker Compose removido."
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

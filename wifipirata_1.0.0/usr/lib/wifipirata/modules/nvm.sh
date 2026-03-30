#!/bin/bash
# modules/nvm.sh - Instala ou remove o NVM (Node Version Manager)
source /home/maiconparra/Scripts-Bash/utils/common.sh

ACTION="$1"

check_ubuntu
validate_args "dummy" "$ACTION"

case "$ACTION" in
    install)
        if command -v nvm >/dev/null 2>&1; then
            log "NVM já está instalado."
        else
            log "Instalando NVM..."
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
            log "NVM instalado. Reinicie o terminal ou rode: source ~/.nvm/nvm.sh"
        fi
        ;;
    remove)
        if [ -d "$HOME/.nvm" ]; then
            log "Removendo NVM..."
            rm -rf "$HOME/.nvm"
            sed -i '/NVM/d' "$HOME/.bashrc" "$HOME/.profile" "$HOME/.zshrc" 2>/dev/null || true
            log "NVM removido."
        else
            log "NVM não encontrado."
        fi
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

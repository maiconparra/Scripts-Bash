#!/bin/bash
# utils/common.sh - Funções utilitárias compartilhadas

log() {
    local msg="$1"
    local logfile="/home/maiconparra/Scripts-Bash/logs/$(date +%F).log"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $msg" | tee -a "$logfile"
}

check_ubuntu() {
    if ! grep -qi ubuntu /etc/os-release; then
        log "Este script só suporta Ubuntu. Abortando."
        exit 1
    fi
}

validate_args() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        log "Uso: $0 [versao|latest|default] [install|remove]"
        exit 1
    fi
}

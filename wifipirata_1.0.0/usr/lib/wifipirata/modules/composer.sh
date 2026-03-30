#!/bin/bash
# modules/composer.sh - Instala ou remove o Composer
source /home/maiconparra/Scripts-Bash/utils/common.sh

ACTION="$1"

check_ubuntu
validate_args "dummy" "$ACTION"

case "$ACTION" in
    install)
        if command -v composer >/dev/null 2>&1; then
            log "Composer já está instalado."
        else
            log "Instalando Composer..."
            php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
            HASH=$(curl -s https://composer.github.io/installer.sig)
            php -r "if (hash_file('sha384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
            sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
            php -r "unlink('composer-setup.php');"
            log "Composer instalado."
        fi
        ;;
    remove)
        if command -v composer >/dev/null 2>&1; then
            log "Removendo Composer..."
            sudo rm -f /usr/local/bin/composer
            log "Composer removido."
        else
            log "Composer não encontrado."
        fi
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

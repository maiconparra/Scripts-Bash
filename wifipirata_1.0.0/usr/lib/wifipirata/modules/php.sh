#!/bin/bash
# modules/php.sh - Instala ou remove PHP
source /home/maiconparra/Scripts-Bash/utils/common.sh

VERSION="$1"
ACTION="$2"

check_ubuntu
validate_args "$VERSION" "$ACTION"

case "$ACTION" in
    install)
        log "Instalando PHP $VERSION..."
        sudo apt update
        sudo apt install -y software-properties-common ca-certificates lsb-release apt-transport-https curl
        sudo add-apt-repository -y ppa:ondrej/php || true
        sudo apt update
        sudo apt install -y php$VERSION php$VERSION-cli php$VERSION-fpm php$VERSION-mbstring php$VERSION-xml php$VERSION-curl php$VERSION-zip php$VERSION-mysql php$VERSION-gd php$VERSION-intl php$VERSION-bcmath
        php -v
        ;;
    remove)
        log "Removendo todos os pacotes PHP $VERSION..."
        PKGS=$(dpkg -l | grep "php$VERSION" | awk '{print $2}')
        if [ -n "$PKGS" ]; then
            sudo apt purge --auto-remove -y $PKGS
            log "Pacotes removidos: $PKGS"
        else
            log "Nenhum pacote php$VERSION encontrado para remoção."
        fi
        # Remover metapacote php se não houver mais PHP
        if dpkg -l | grep -q '^ii  php '; then
            sudo apt purge --auto-remove -y php
            log "Metapacote php removido."
        fi
        sudo apt autoremove -y
        # Checagem final
        if command -v php >/dev/null 2>&1; then
            log "ATENÇÃO: Ainda existe PHP instalado no sistema. Veja 'php -v' para detalhes."
        else
            log "PHP removido com sucesso."
        fi
        ;;
    *)
        log "Ação inválida."
        exit 1
        ;;
esac

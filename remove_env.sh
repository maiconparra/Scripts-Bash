#!/bin/bash
# remove_env.sh - Script adaptativo para remover PHP e Composer em Ubuntu 18.04, 20.04, 22.04, 23.10
# Pronto para evoluir para ambientes de produção

set -e

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Detecta versão do Ubuntu
if [ -f /etc/os-release ]; then
    . /etc/os-release
    UBUNTU_VERSION=$VERSION_ID
else
    log "Não foi possível detectar a versão do Ubuntu. Abortando."
    exit 1
fi

# Parâmetro: versão do PHP desejada (opcional)
PHP_VERSION="$1"

# Define versão padrão de acordo com o Ubuntu
if [ -z "$PHP_VERSION" ]; then
    case "$UBUNTU_VERSION" in
        "18.04") PHP_VERSION="7.4" ;;
        "20.04") PHP_VERSION="8.0" ;;
        "22.04") PHP_VERSION="8.1" ;;
        "23.10") PHP_VERSION="8.2" ;;
        *) PHP_VERSION="8.1" ;;
    esac
fi

log "Ubuntu $UBUNTU_VERSION detectado. PHP $PHP_VERSION será removido."

log "Removendo Composer..."
if command -v composer >/dev/null 2>&1; then
    sudo rm -f /usr/local/bin/composer
    log "Composer removido."
else
    log "Composer não encontrado."
fi

log "Removendo PHP $PHP_VERSION e módulos comuns..."
sudo apt purge --auto-remove -y php$PHP_VERSION php$PHP_VERSION-cli php$PHP_VERSION-fpm php$PHP_VERSION-mbstring \
    php$PHP_VERSION-xml php$PHP_VERSION-curl php$PHP_VERSION-zip php$PHP_VERSION-mysql \
    php$PHP_VERSION-gd php$PHP_VERSION-intl php$PHP_VERSION-bcmath || log "Alguns pacotes podem já não estar instalados."

log "Limpando pacotes órfãos e cache..."
sudo apt autoremove -y
sudo apt autoclean

# (Opcional) Remover o PPA ondrej/php
if grep -q "ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    log "Removendo repositório ondrej/php..."
    sudo add-apt-repository --remove ppa:ondrej/php -y
else
    log "Repositório ondrej/php não encontrado."
fi

log "Verificando remoção do PHP..."
if command -v php >/dev/null 2>&1; then
    log "PHP ainda está presente no sistema. Verifique dependências de outros pacotes."
else
    log "PHP removido com sucesso."
fi

log "Remoção concluída!"

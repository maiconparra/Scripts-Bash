#!/bin/bash
# install_env.sh - Script adaptativo para instalar PHP e Composer em Ubuntu 18.04, 20.04, 22.04, 23.10
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

log "Ubuntu $UBUNTU_VERSION detectado. PHP $PHP_VERSION será instalado."

log "Atualizando sistema e instalando dependências..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common ca-certificates lsb-release apt-transport-https curl wget unzip

# Adiciona o PPA ondrej/php se necessário
if ! grep -q "ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    log "Adicionando repositório ondrej/php..."
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt update
else
    log "Repositório ondrej/php já presente."
fi

log "Instalando PHP $PHP_VERSION e módulos comuns..."
sudo apt install -y php$PHP_VERSION php$PHP_VERSION-cli php$PHP_VERSION-fpm php$PHP_VERSION-mbstring \
    php$PHP_VERSION-xml php$PHP_VERSION-curl php$PHP_VERSION-zip php$PHP_VERSION-mysql \
    php$PHP_VERSION-gd php$PHP_VERSION-intl php$PHP_VERSION-bcmath

log "Verificando instalação do PHP..."
php -v || { log "PHP não instalado corretamente."; exit 1; }

log "Instalando Composer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
HASH=$(curl -s https://composer.github.io/installer.sig)
php -r "if (hash_file('sha384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

log "Verificando instalação do Composer..."
composer --version || { log "Composer não instalado corretamente."; exit 1; }

log "Instalação concluída com sucesso!"

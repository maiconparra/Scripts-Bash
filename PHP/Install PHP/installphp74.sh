#!/bin/bash

#install_php
#
#Script responsável por adiministrar a instalação do PHP.
#Onde o mesmo testa se existe o PPA e o adicina instalando ou desinstalando o PHP na versão desejada.
#


#Verificando se o PPA do PHP existe se existir continua se não existir adiciona e continua.
the_ppa="ondrej/php"
if ! grep -q "^deb .*$the_ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    echo "PPA not found"

    echo "Adding ondrej/php"

    sudo add-apt-repository ppa:ondrej/php
else
    echo "PPA found"
fi

sudo apt update


if test "$2" = "-I"

then

    sudo apt install -y php$1

    sudo apt install -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl
    exit 0

fi

if test "$2" = "--install"

then

    sudo apt install -y php$1

    sudo apt install -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl
    exit 0

fi

if test "$2" = "-P"

then

    sudo apt purge --auto-remove -y php$1

    sudo apt purge --auto-remove -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl
    exit 0

fi

if test "$2" = "--purge"

then

    sudo apt purge --auto-remove -y php$1

    sudo apt purge --auto-remove -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl
    exit 0

fi
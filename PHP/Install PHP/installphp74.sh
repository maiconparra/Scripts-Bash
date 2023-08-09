#!/bin/bash

#Mensagem de Ajuda
MENSAGEM_AJUDA="
$0 [arguments] [options]


[arguments]
    -h show help informations.
    --help show help informations.

    7.4 install PHP version 7.4 .
    8.2 install PHP version 8.2 .

[options]
    -P uninstall PHP .
    --purge uninstall PHP .

    -I install PHP .
    --install install PHP
"

if test "$1" = "-h"

then 

echo "$MENSAGEM_AJUDA"
exit 0;

fi

if test "$1" = "--help"

then 

echo "$MENSAGEM_AJUDA"
exit 0;

fi

#Adicionando PPA do PHP
sudo add-apt-repository ppa:ondrej/php

sudo apt update

#Instalação da versão 7.4
if test "$1" = "7.4"

then

    if test "$2" = "-I"

    then

        sudo apt install -y php$1

        sudo apt install -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl

    fi

    if test "$2" = "-install"

    then

        sudo apt install -y php$1

        sudo apt install -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl

    fi

    if test "$2" = "-P"

    then

        sudo apt purge -y php$1

        sudo apt purge -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl

    fi

    if test "$2" = "--purge"

    then

        sudo apt purge -y php$1

        sudo apt purge -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl

    fi

fi

if test "$1" = "8.2"

then

    if test "$2" = "-I"

    then

        sudo apt install -y php$1 libapache2-mod-php$1 php$1-mysql php$1-common php$1-xml php$1-xmlrpc php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring

    fi

    if test "$2" = "--install"

    then 

        sudo apt install -y php$1 libapache2-mod-php$1 php$1-mysql php$1-common php$1-xml php$1-xmlrpc php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring

    fi

    if test "$2" = "-P"

    then 

        sudo apt purge -y php$1 libapache2-mod-php$1 php$1-mysql php$1-common php$1-xml php$1-xmlrpc php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring

    fi

    if test "$2" = "--purge"

    then 

        sudo apt purge -y php$1 libapache2-mod-php$1 php$1-mysql php$1-common php$1-xml php$1-xmlrpc php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring

    fi

fi
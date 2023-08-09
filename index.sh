#!/bin/bash

#Mensagem de Ajuda
MENSAGEM_AJUDA="
$0 [arguments] [options]


[arguments]
    -h show help informations .
    --help show help informations .

    --uninstall-php uninstall PHP .
    --install-php install PHP .

    Version of the PHP, exemples:

    $0 7.4 --install-php [version of the release]
    
    $0 7.4 --uninstall-php [version of the release]

[options]
    
"

if test "$1" = "-h"

then 

    echo "$MENSAGEM_AJUDA"
    exit 0

fi

if test "$1" = "--help"

then 

    echo "$MENSAGEM_AJUDA"
    exit 0

fi

if test "$1" = "--install-php"

then

    ./PHP/Install\ PHP/installphp74.sh $2 --install

    ./Composer/installer-composer.sh

fi

if test "$1" = "--uninstall-php"

then 

    ./PHP/Install\ PHP/installphp74.sh $2 --purge

    sudo apt purge --auto-remove composer
fi
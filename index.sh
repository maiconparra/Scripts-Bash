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

    $(basename "$0") --install-php [version of the release]
    
    $(basename "$0") --uninstall-php [version of the release]

[options]
    
"

case "$1" in 
    "--help" | "-h")
        echo "$MENSAGEM_AJUDA"
        exit 0
    ;;
    "--install-php")
        ./PHP/Install\ PHP/installphp74.sh $2 --install

        ./Composer/installer-composer.sh
    ;;
    "--uninstall-php")
        ./PHP/Install\ PHP/installphp74.sh $2 --purge

        sudo apt purge --auto-remove composer
    ;;
    *)
        if test -n "$1"
        then
            echo $(basename "$0")
            echo "Opção $1 invallida."
        fi
    ;;
esac
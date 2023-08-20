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

    $(basename "$0") --uninstall-php ou --install-php sem indicar o versão irá instalar ou desinstalar a versão LTS mais recente.

[options]
    
"

PHP_LATEST=$(sudo apt-cache policy php | grep "Candidate: [0-9]:[0-9][.][0-9]" | tr : \\t | grep -oE '[0-9]\.[0-9]' | head -n 1)

case "$1" in 
    "--help" | "-h")
        echo "$MENSAGEM_AJUDA"
        exit 0
    ;;
    "--install-php")

        if test -n "$2"
        then

            ./PHP/Install\ PHP/installphp74.sh $2 --install

            ./Composer/installer-composer.sh

        else 

            ./PHP/Install\ PHP/installphp74.sh $PHP_LATEST --install

            ./Composer/installer-composer.sh

        fi
    ;;
    "--uninstall-php")

        if test -n "$2"
        then

            ./PHP/Install\ PHP/installphp74.sh $2 --purge

            sudo apt purge --auto-remove composer

        else

            ./PHP/Install\ PHP/installphp74.sh $PHP_LATEST --purge

            sudo apt purge --auto-remove composer

        fi
    ;;
    *)
        if test -n "$1"
        then
            echo $(basename "$0")
            echo "Opção $1 invallida."
        fi
    ;;
esac
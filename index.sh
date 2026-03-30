#!/bin/bash


# index.sh - Interface principal para instalação e remoção de PHP/Composer
# Uso:
#   ./index.sh --install-php [versao]
#   ./index.sh --uninstall-php [versao]
#   ./index.sh --help

MENSAGEM_AJUDA="\
Uso: $(basename "$0") [argumento] [versao]\n\n\
[argumentos]\n\
    -h, --help           Exibe esta mensagem de ajuda\n\
    --install-php        Instala PHP e Composer (versão opcional)\n\
    --uninstall-php      Remove PHP e Composer (versão opcional)\n\
\nExemplos:\n\
    $(basename "$0") --install-php 8.2\n\
    $(basename "$0") --uninstall-php 8.2\n\
    $(basename "$0") --install-php\n\
    $(basename "$0") --uninstall-php\n\
Se não indicar a versão, será usada a recomendada para seu Ubuntu.\n\
"

case "$1" in
    "--help"|"-h"|"")
        echo "$MENSAGEM_AJUDA"
        exit 0
    ;;
    "--install-php")
        if [ -n "$2" ]; then
            bash ./install_env.sh "$2"
        else
            bash ./install_env.sh
        fi
        ;;
    "--uninstall-php")
        if [ -n "$2" ]; then
            bash ./remove_env.sh "$2"
        else
            bash ./remove_env.sh
        fi
        ;;
    *)
        echo "Opção '$1' inválida. Use --help para ver as opções disponíveis."
        exit 1
        ;;
esac
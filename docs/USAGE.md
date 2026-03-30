# Guia de Uso

## Comando principal
- `wifipirata menu` — Menu interativo
- `wifipirata list --php-versions` — Lista versões do PHP
- `wifipirata install <app> [versao]` — Instala aplicação
- `wifipirata remove <app> [versao]` — Remove aplicação

## Empacotamento e Instalação
Veja docs/ARCHITECTURE.md para detalhes do .deb.

## Adicionando novos módulos
1. Crie um script em modules/ seguindo o padrão dos existentes.
2. Atualize o menu em bin/setup_menu.sh se necessário.
3. Documente em docs/USAGE.md.

# Arquitetura Scripts-Bash

## Visão Geral
O projeto é modular, cada aplicação (php, docker, etc) possui um script próprio em modules/. O menu interativo e o CLI principal estão em bin/. Funções comuns ficam em utils/.

## Estrutura
- **bin/**: Entrypoints (wifipirata, setup_menu.sh, install.sh)
- **modules/**: Um script por aplicação
- **utils/**: Funções utilitárias (ex: common.sh)
- **docs/**: Documentação
- **.vscode/**: Configuração do editor

## Empacotamento .deb
- Estrutura de build: wifipirata_1.0.0/ (não versionar .deb gerado)
- Scripts copiados para /usr/lib/wifipirata e /usr/bin/wifipirata

## Convenções Bash
- ShellCheck obrigatório
- POSIX compatível sempre que possível
- Funções reutilizáveis em utils/
- Comentários claros e cabeçalhos em todos os scripts
- Modularização: nunca misture lógica de apps diferentes

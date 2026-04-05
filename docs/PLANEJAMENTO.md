# Planejamento — WifiPirata OS

> SO customizado baseado em Debian para desenvolvedores, com foco em gerenciamento de ambientes de desenvolvimento, servidores e equipamentos de rede. Interface gráfica (Electron + React + Vite + TypeScript) com core C++ (`libwifipirata.so`).

---

## 1. Objetivo

Evoluir o WifiPirata de um conjunto de scripts bash para um **sistema operacional customizado** que permita:

- Monitorar, gerenciar, atualizar, criar e excluir ambientes de desenvolvimento, teste e produção (simulada).
- Organizar pipelines CI/CD de forma visual com gráficos, cards e menus.
- Instalar e gerenciar versões de aplicações.
- Inicializar projetos com templates prontos, incluindo CI/CD pré-configurado.
- Permitir configuração completa do ambiente via arquivo YAML declarativo.
- (Futuro) Gerenciar servidores e equipamentos de rede como uma distro dedicada para instalação em máquinas servidor e NAS.

---

## 2. Pesquisa de Referência — Interfaces de NAS e Gerenciamento de Servidores

### 2.1 Análise Comparativa

| Sistema | Frontend | Backend | Navegação | Licença |
|---|---|---|---|---|
| **TrueNAS SCALE** | Angular + TypeScript | Python + OpenZFS | Sidebar fixa + dashboard widgets | GPL-3.0 |
| **Proxmox VE** | ExtJS | Perl + C + Rust | Tree view hierárquica + tabs | AGPL-3.0 |
| **Cockpit** | React + PatternFly | C + Python (D-Bus direto) | Sidebar simples + overview | LGPL-2.1+ |
| **CasaOS** | Vue.js | Go (90%) | Home screen com cards | Apache-2.0 |
| **Synology DSM** | JS proprietário | Linux proprietário | Desktop metaphor (janelas flutuantes) | Proprietário |
| **Unraid** | PHP + JS | Slackware customizado | Tabs horizontais | Proprietário |
| **OpenMediaVault** | Angular Material + TS | PHP + SaltStack + Python | Árvore hierárquica sidebar | GPL-3.0 |
| **Webmin** | HTML + JS (Authentic theme) | Perl (miniserv.pl) | Sidebar categorizada colapsável | BSD-3-Clause |

### 2.2 Padrões de UI/UX Extraídos

| Padrão | Usado por | Adotar? |
|---|---|---|
| **Sidebar fixa + conteúdo à direita** | TrueNAS, Proxmox, Cockpit, Webmin, OMV | Sim — padrão mais universal e escalável |
| **Dashboard com cards/widgets** | CasaOS, Synology, TrueNAS | Sim — estado rápido do sistema |
| **Tree view hierárquica** | Proxmox, OMV | Sim — essencial para ambientes aninhados (nodes → ambientes → serviços) |
| **REST API como camada central** | TrueNAS, Proxmox, CasaOS | Sim — CLI, GUI e automação via mesma API |
| **WebSocket para real-time** | TrueNAS, Proxmox, Webmin | Sim — monitoramento e logs live |
| **App Store Docker/templates** | CasaOS, Unraid, TrueNAS | Sim — distribuição de módulos e apps |
| **Desktop metaphor (janelas)** | Synology DSM | Não — complexo de implementar, pouco ganho para o público-alvo |

### 2.3 Padrões de Arquitetura

| Padrão | Referência | Aplicação no WifiPirata |
|---|---|---|
| API-first (REST/gRPC) | TrueNAS, Proxmox | GUI e CLI consomem a mesma API do daemon |
| Usa APIs nativas do OS (D-Bus, systemd) | Cockpit | Core C++ comunica via D-Bus com systemd |
| Módulos como packages do OS | Cockpit, OMV, Webmin | Sistema de plugins extensível |
| Docker/containers para apps | CasaOS, Unraid, TrueNAS | Ambientes isolados via containers |
| WebSocket para streaming | TrueNAS, Proxmox | Monitoramento real-time e console |

### 2.4 Decisão de Design

- **Navegação**: Sidebar fixa (Cockpit/TrueNAS) + tree view para ambientes (Proxmox) + dashboard cards (CasaOS).
- **API-first**: gRPC central + REST gateway, consumida pela GUI (Electron) e CLI (C++).
- **Módulos**: Sistema de plugins extensível (referência: Cockpit starter kit + Webmin modules).

---

## 3. Referências de Ciência da Computação e Engenharia Linux

### 3.1 Referências Acadêmicas

| Referência | Conceito | Aplicação |
|---|---|---|
| Dolstra, E. (2006) — "The Purely Functional Software Deployment Model" | Reproducibilidade, gestão funcional de pacotes | Config declarativa YAML, ambientes reproduzíveis |
| Tanenbaum, A. — "Modern Operating Systems" | Processos, IPC, file systems, segurança | Daemon + IPC via gRPC/D-Bus |
| Saltzer & Schroeder (1975) — "Protection of Information in Computer Systems" | Menor privilégio, economia de mecanismo | Sandboxing de serviços, polkit para elevação |
| Lampson (1983) — "Hints for Computer System Design" | Separação mecanismo/política | systemd units vs policies de segurança |
| Pike & Kernighan — "The Unix Programming Environment" | Composabilidade, ferramentas pequenas | Módulos C++ independentes, CLI composável |
| Humble & Farley — "Continuous Delivery" | Pipeline, artefatos imutáveis | Pipeline visual, CI/CD integrado |
| Morris (2016) — "Infrastructure as Code" | Versionamento de infraestrutura | YAML declarativo + GitOps |
| Beyer et al. — "Site Reliability Engineering" (Google) | SLOs, error budgets, redução de toil | Dashboard de monitoramento, alertas, self-healing |

### 3.2 Referências de Engenharia Linux

| Referência | Relevância |
|---|---|
| Linux From Scratch (LFS) | Compreensão de cada componente do OS para montar a distro |
| Yocto Project / Buildroot | Build systems para Linux customizado — referência para geração de ISO |
| Debian Policy Manual | Base da distro — padrões APT, dpkg, empacotamento, idempotência de scripts |
| NixOS | Inspiração para configuração declarativa total do sistema |
| systemd (Lennart Poettering) | Socket activation, cgroups, journald, networkd, portabled |
| D-Bus / sd-bus | IPC padrão Linux para comunicação entre daemon e GUI/serviços |
| Freedesktop.org specs | PolicyKit/polkit, udisks/storaged, PackageKit |
| OCI (Open Container Initiative) | Padrões de containers para runtime e imagens |

### 3.3 Princípios Arquiteturais

| Princípio | Origem | Aplicação |
|---|---|---|
| **Idempotência** | Álgebra / Debian Policy §6.2 | Aplicar operação N vezes = mesmo resultado. Essencial para install/remove de ambientes |
| **Cattle, not Pets** | Cloud computing | Ambientes recriáveis do zero via config declarativa |
| **Pit of Success** | DX Engineering | Defaults corretos e seguros, configuração mínima para começar |
| **Fast Feedback Loop** | DX Engineering | Build rápido, logs claros, rollback instantâneo |
| **Composability** | Unix Philosophy | Módulos independentes que combinam via API |
| **Reproducibility** | Nix / IaC | Ambientes idênticos via configuração declarativa versionada |

### 3.4 Decisões Arquiteturais (baseadas na pesquisa)

| Decisão | Escolha | Justificativa |
|---|---|---|
| Base da distro | Debian com overlay customizado | Maior ecossistema, APT maduro, LTS, Policy rigorosa |
| Init system | systemd | Socket activation, cgroups, journald, networkd |
| Modelo de config | Híbrido: declarativo (YAML) + imperativo (scripts) | Declarativo para serviços, imperativo para provisioning |
| Container runtime | Docker (atual) → Podman (futuro distro) | Docker já suportado; Podman rootless para a distro |
| Rede | systemd-networkd + nftables | Declarativo, integrado, sem dependências extras |
| Storage (NAS) | ZFS ou Btrfs | CoW, snapshots, RAID, send/receive |
| Segurança | AppArmor + systemd sandboxing | Equilíbrio entre segurança e usabilidade |
| Atualizações | Atômicas (A/B partitions ou OSTree) | Rollback confiável |
| IPC daemon↔GUI | gRPC + Protocol Buffers | Eficiente, cross-language, tipado |

---

## 4. Requisitos

### 4.1 Requisitos Funcionais

| ID | Requisito | Prioridade |
|---|---|---|
| RF01 | Criar, listar, editar, iniciar, parar e excluir ambientes (dev, teste, produção simulada) com isolamento. Cada ambiente definido por YAML declarativo | Alta |
| RF02 | Instalar, atualizar e remover aplicações (PHP, Node/NVM, Docker, Kubernetes, Nginx, Apache, MySQL, MariaDB, MongoDB, Composer) com suporte a múltiplas versões coexistentes | Alta |
| RF03 | Dashboard de monitoramento real-time: CPU, RAM, disco, rede, temperatura, status de containers, status de serviços systemd, logs com filtragem | Alta |
| RF04 | Editor visual drag-and-drop de pipelines CI/CD (nós conectáveis), geração de GitHub Actions / GitLab CI YAML, visualização de execução com progresso, templates de pipeline por stack | Alta |
| RF05 | Inicialização de projetos com templates (Laravel, React, Node) incluindo estrutura de pastas, configs, CI/CD e docker-compose. Wizard de personalização | Média |
| RF06 | Configuração declarativa do sistema via YAML (estilo docker-compose / NixOS) com parser, validação, mensagens de erro amigáveis e execução idempotente | Alta |
| RF07 | Gerenciamento de rede: configuração de interfaces, firewall visual (nftables), monitoramento SNMP de switches/routers, DNS e DHCP | Futura (Distro) |
| RF08 | Gerenciamento de storage: pools ZFS/Btrfs, snapshots, scrubs, replicação, shares SMB/NFS/iSCSI, monitoramento S.M.A.R.T., quotas | Futura (Distro) |

### 4.2 Requisitos Não-Funcionais

| ID | Requisito | Métrica |
|---|---|---|
| RNF01 | Performance do core C++ | Operações de sistema < 100ms |
| RNF02 | Consumo de memória da GUI | < 300MB RAM (Electron otimizado) |
| RNF03 | Tempo de boot do daemon | < 2s (socket activation) |
| RNF04 | Latência do monitoramento | Atualização < 1s para métricas real-time |
| RNF05 | Segurança | Princípio do menor privilégio, sandboxing, polkit |
| RNF06 | Extensibilidade | Módulos adicionáveis sem modificar o core |
| RNF07 | Portabilidade | x86_64 e ARM64 |
| RNF08 | Offline-first | Funcionar sem internet (exceto downloads) |

---

## 5. Atores

| Ator | Tipo | Descrição | RFs Principais |
|---|---|---|---|
| **Desenvolvedor** | Humano | Usuário principal. Cria e gerencia ambientes de desenvolvimento, usa templates de projetos, configura pipelines CI/CD | RF01-RF06 |
| **DevOps / SysAdmin** | Humano | Configura infraestrutura, monitora servidores, gerencia rede e storage | RF02, RF03, RF06-RF08 |
| **Administrador do Sistema** | Humano | Gerencia usuários, permissões, políticas de segurança, atualizações do OS | Todos (nível admin) |
| **Daemon (wifipiratasd)** | Sistema | Executa operações agendadas, monitora saúde, aplica políticas, reconcilia estado desejado vs atual | RF03, RF06-RF08 |
| **CI/CD Engine** | Sistema | Executa pipelines, reporta status, gera artefatos | RF04 |

---

## 6. Casos de Uso

### 6.1 Gerenciamento de Ambientes

**UC01 — Criar Ambiente de Desenvolvimento**
- Ator: Desenvolvedor
- Pré-condição: Sistema instalado, arquivo YAML ou wizard preenchido
- Fluxo: Seleciona stack → Define versões → Define serviços (DB, cache, web server) → Sistema provisiona containers/serviços → Ambiente pronto com URL local
- Pós-condição: Ambiente rodando, acessível, com health check verde no dashboard
- Ref: Idempotência (Debian Policy §6.2)

**UC02 — Clonar Ambiente (Dev → Teste → Produção Simulada)**
- Ator: Desenvolvedor
- Fluxo: Seleciona ambiente existente → Escolhe tipo destino (teste/prod) → Sistema clona config com ajustes (portas, variáveis de ambiente) → Novo ambiente rodando
- Ref: Padrão "Cattle, not Pets"

**UC03 — Destruir Ambiente**
- Ator: Desenvolvedor
- Fluxo: Seleciona ambiente → Confirma exclusão → Sistema para serviços → Remove containers/volumes → Limpa configurações
- Restrição: Confirmação obrigatória para ambientes com dados persistidos

**UC04 — Monitorar Ambientes**
- Ator: Desenvolvedor, DevOps
- Fluxo: Acessa Dashboard → Visualiza cards com status de cada ambiente → Drill-down para métricas (CPU, RAM, logs) → Recebe alertas se serviço unhealthy
- Tecnologia: WebSocket real-time para atualização contínua

**UC05 — Aplicar Configuração Declarativa**
- Ator: Desenvolvedor, DevOps
- Fluxo: Edita arquivo YAML → Executa `wifipirata apply config.yaml` (CLI) ou aplica via GUI → Sistema valida → Calcula diff do estado atual → Aplica mudanças incrementais → Reporta resultado
- Ref: NixOS declarative model, IaC (Morris, 2016)

### 6.2 Pipeline CI/CD

**UC06 — Criar Pipeline Visual**
- Ator: Desenvolvedor
- Fluxo: Abre editor de pipeline → Arrasta nós (build, test, deploy, notify) → Conecta nós com edges → Configura parâmetros de cada nó → Salva → Sistema gera arquivo CI/CD (GitHub Actions YAML / GitLab CI YAML)
- Tecnologia: @xyflow/react (React Flow)

**UC07 — Executar Pipeline Localmente**
- Ator: Desenvolvedor
- Fluxo: Seleciona pipeline → Executa → Visualiza progresso em tempo real (nós mudam de cor conforme status) → Acessa logs por etapa → Resultado final com resumo

**UC08 — Usar Template de Pipeline**
- Ator: Desenvolvedor
- Fluxo: Seleciona stack → Lista templates disponíveis → Seleciona e customiza → Aplica ao projeto

### 6.3 Inicialização de Projetos

**UC09 — Inicializar Projeto com Template**
- Ator: Desenvolvedor
- Fluxo: Seleciona stack (Laravel, React, Node, etc.) → Configura opções no wizard → Sistema gera estrutura de pastas + configs + CI/CD + docker-compose → Projeto pronto para desenvolvimento

**UC10 — Gerenciar Templates**
- Ator: Desenvolvedor
- Fluxo: Listar templates → Criar template customizado → Editar existente → Compartilhar com equipe

### 6.4 Gerenciamento de Sistema (Futuro — Distro)

**UC11 — Configurar Rede**
- Ator: DevOps/SysAdmin
- Fluxo: Visualiza interfaces de rede → Configura IP/VLAN/Bridge → Aplica → Monitora tráfego em tempo real

**UC12 — Gerenciar Storage**
- Ator: DevOps/SysAdmin
- Fluxo: Detecta discos → Cria pool ZFS/Btrfs → Configura compartilhamentos SMB/NFS → Monitora saúde S.M.A.R.T.

**UC13 — Monitorar Equipamentos de Rede**
- Ator: DevOps/SysAdmin
- Fluxo: Adiciona dispositivo (IP + comunidade SNMP) → Dashboard exibe status → Sistema envia alertas de indisponibilidade

**UC14 — Gerenciar Atualizações do Sistema**
- Ator: Administrador
- Fluxo: Verifica updates disponíveis → Preview de mudanças → Aplica com rollback automático → Confirma ou reverte (updates atômicos)

---

## 7. Arquitetura

### 7.1 Camadas

```
┌─────────────────────────────────────────────────────────────┐
│  Camada 5: INTERFACES                                       │
│  ┌────────────┐  ┌──────────┐  ┌─────────────────────────┐  │
│  │    GUI     │  │   CLI    │  │  REST API + WebSocket    │  │
│  │  Electron  │  │   C++    │  │  (gRPC → REST gateway)   │  │
│  │ React + TS │  │          │  │                          │  │
│  └─────┬──────┘  └────┬─────┘  └────────────┬────────────┘  │
│        │              │                      │               │
├────────┴──────────────┴──────────────────────┴───────────────┤
│  Camada 4: NODE BINDING (N-API)                              │
│  Expõe libwifipirata para Electron via node-addon-api        │
├──────────────────────────────────────────────────────────────┤
│  Camada 3: DAEMON (wifipiratasd)                             │
│  gRPC server — gerencia estado, schedules, reconciliação     │
│  Roda como serviço systemd com socket activation             │
├──────────────────────────────────────────────────────────────┤
│  Camada 2: CORE (libwifipirata.so) — C++20                   │
│  ┌──────────────┬───────────────┬──────────────────────┐     │
│  │ Environment  │  Pipeline     │  System Monitor      │     │
│  │ Manager      │  Engine       │  (CPU, RAM, Disco)   │     │
│  ├──────────────┼───────────────┼──────────────────────┤     │
│  │ Service      │  Template     │  Shell Executor      │     │
│  │ Manager      │  Engine       │  (scripts .sh)       │     │
│  ├──────────────┼───────────────┼──────────────────────┤     │
│  │ Network      │  Storage      │  Config Parser       │     │
│  │ Manager (*)  │  Manager (*)  │  (YAML declarativo)  │     │
│  └──────────────┴───────────────┴──────────────────────┘     │
│  (*) = implementação futura (distro)                         │
├──────────────────────────────────────────────────────────────┤
│  Camada 1: SISTEMA OPERACIONAL                               │
│  Bash scripts │ Docker │ systemd │ D-Bus │ /proc │ /sys      │
│  ZFS/Btrfs (*) │ netlink (*) │ nftables (*) │ SNMP (*)      │
└──────────────────────────────────────────────────────────────┘
```

### 7.2 Estrutura de Diretórios do Projeto

```
wifipirata/
├── core/                          # C++20 — Engine (libwifipirata.so)
│   ├── CMakeLists.txt
│   ├── include/wifipirata/
│   │   ├── core.h
│   │   ├── environment.h          # CRUD de ambientes
│   │   ├── service_manager.h      # Gerenciamento de serviços
│   │   ├── pipeline.h             # Engine de pipelines
│   │   ├── template_engine.h      # Geração de projetos
│   │   ├── system_monitor.h       # Métricas do sistema
│   │   ├── config_parser.h        # Parser YAML declarativo
│   │   ├── shell_executor.h       # Wrapper para scripts .sh
│   │   ├── network.h              # (*) Futuro: rede
│   │   └── storage.h              # (*) Futuro: storage
│   ├── src/
│   │   ├── environment.cpp
│   │   ├── service_manager.cpp
│   │   ├── pipeline.cpp
│   │   ├── template_engine.cpp
│   │   ├── system_monitor.cpp
│   │   ├── config_parser.cpp
│   │   └── shell_executor.cpp     # Chama scripts bash existentes
│   ├── tests/                     # GoogleTest
│   └── third_party/               # nlohmann/json, spdlog, yaml-cpp, fmt
│
├── daemon/                        # wifipiratasd — serviço systemd
│   ├── CMakeLists.txt
│   ├── src/
│   │   ├── main.cpp
│   │   ├── grpc_server.cpp        # API gRPC
│   │   └── rest_gateway.cpp       # REST gateway (gRPC → HTTP/JSON)
│   └── proto/
│       └── wifipirata.proto       # Definições gRPC
│
├── cli/                           # CLI nativo C++
│   ├── CMakeLists.txt
│   └── src/main.cpp               # Substitui bin/wifipirata bash
│
├── node-binding/                  # Bridge C++ → Node.js (N-API)
│   ├── binding.gyp
│   └── src/
│       ├── addon.cpp
│       ├── env_wrapper.cpp
│       └── monitor_wrapper.cpp
│
├── gui/                           # Electron + React + Vite + TypeScript
│   ├── electron/
│   │   ├── main.ts
│   │   ├── preload.ts
│   │   └── ipc/
│   │       ├── environments.ts
│   │       ├── monitoring.ts
│   │       └── pipeline.ts
│   ├── src/
│   │   ├── components/
│   │   │   ├── Dashboard/         # Cards status, gráficos (Recharts)
│   │   │   ├── Environments/      # CRUD dev/teste/prod
│   │   │   ├── Pipeline/          # Editor visual (React Flow)
│   │   │   ├── Monitoring/        # Métricas real-time (WebSocket)
│   │   │   ├── Projects/          # Templates e inicialização
│   │   │   └── Layout/            # Sidebar, header, navigation
│   │   ├── pages/
│   │   ├── hooks/
│   │   ├── services/              # API clients
│   │   └── App.tsx
│   ├── vite.config.ts
│   └── electron-builder.yml
│
├── scripts/                       # Scripts bash existentes (mantidos)
│   ├── modules/                   # apache2.sh, php.sh, docker.sh, etc.
│   └── utils/common.sh
│
├── templates/                     # Templates de projetos e CI/CD
│   ├── projects/
│   │   ├── laravel/
│   │   ├── react/
│   │   └── node/
│   └── pipelines/
│       ├── github-actions/
│       └── gitlab-ci/
│
├── packaging/
│   ├── debian/                    # .deb packaging
│   └── iso/                       # (*) Futuro: geração de ISO
│
├── docs/
│   ├── PLANEJAMENTO.md
│   ├── ARCHITECTURE.md
│   └── ...
│
└── CMakeLists.txt                 # Build root
```

### 7.3 Stack Tecnológica

| Camada | Tecnologia | Justificativa |
|---|---|---|
| Core | C++20 + CMake 3.20+ | Performance, acesso baixo nível, longevidade para a distro |
| IPC | gRPC + Protocol Buffers | Comunicação daemon↔GUI/CLI, cross-language, tipado |
| Config | yaml-cpp | Parser YAML para configuração declarativa |
| JSON | nlohmann/json | Serialização JSON no C++ |
| Logging | spdlog + fmt | Logging estruturado de alta performance |
| Binding | node-addon-api (N-API) | Bridge C++→Electron sem overhead |
| GUI Runtime | Electron 35+ | Aplicação desktop cross-platform |
| GUI Build | electron-vite 3+ | Integração Vite + Electron |
| Frontend | React 19 + TypeScript 5 | Componentes reativos, type safety |
| UI Components | Shadcn/ui + Radix | Design system moderno, acessível |
| Gráficos | Recharts | Dashboard com gráficos responsivos |
| Pipeline Editor | @xyflow/react (React Flow) 12+ | Drag-and-drop de nós para pipelines |
| State | Zustand 5+ | State management leve |
| Containers | dockerode (Node) | Gerenciamento de containers via API Docker |
| Package | electron-builder + CPack | Empacotamento .deb, .AppImage |

### 7.4 Dependências C++

| Lib | Uso | Fase |
|---|---|---|
| yaml-cpp | Parser YAML | 1 |
| nlohmann/json | JSON | 1 |
| spdlog + fmt | Logging | 1 |
| grpc + protobuf | Comunicação daemon↔GUI/CLI | 2 |
| node-addon-api | N-API binding | 2 |
| cpp-httplib | REST gateway | 2 |
| libcurl | HTTP requests | 3 |
| sdbus-c++ | D-Bus (systemd) | 4 |
| net-snmp | SNMP (rede) | 5 |

---

## 8. Fases de Implementação

### Fase 1: Fundação — Core C++ e Build System

> Objetivo: Estrutura do projeto, build system funcional, core mínimo com shell_executor.

1. Criar estrutura de diretórios do projeto (conforme 7.2).
2. Configurar CMakeLists.txt root + sub-projetos (core, cli).
3. Implementar `shell_executor.cpp` — wrapper C++ que chama scripts bash existentes via fork/exec.
4. Implementar `config_parser.cpp` — parser YAML usando yaml-cpp.
5. Implementar CLI C++ mínimo replicando os comandos atuais de `bin/wifipirata` (install, remove, list, menu).
6. Configurar testes unitários com GoogleTest.
7. Migrar scripts bash existentes para `scripts/modules/` e `scripts/utils/`.

**Verificação:**
- `wifipirata install php 8.2` via CLI C++ executa corretamente o script bash.
- `wifipirata apply config.yaml` parseia arquivo YAML de teste sem erro.
- Testes unitários passam (GoogleTest).
- CMake build completa sem warnings.

### Fase 2: Interface Gráfica — Electron + React + Vite + TypeScript

> Objetivo: GUI funcional com Dashboard e gerenciamento de ambientes.

8. Setup do projeto `gui/` com electron-vite + React + Vite + TypeScript.
9. Configurar node-binding (N-API) para expor `libwifipirata` ao Electron.
10. Implementar Layout base: Sidebar (ref: Cockpit/TrueNAS) + Header + Content area.
11. Implementar Dashboard com cards de status do sistema (CPU, RAM, disco) usando Recharts.
12. Implementar Environments: lista, criar, editar, deletar ambientes.
13. Implementar Monitoring: logs real-time via WebSocket, métricas de containers.
14. Implementar daemon (`wifipiratasd`) com gRPC server para servir dados à GUI.
15. Configurar electron-builder para gerar `.deb`.

**Verificação:**
- GUI abre com Dashboard mostrando métricas reais.
- CRUD completo de ambientes funcional pela GUI.
- Logs em tempo real.
- `.deb` instala e executa corretamente.

### Fase 3: Pipeline CI/CD Visual e Templates

> Objetivo: Editor de pipeline drag-and-drop e inicializador de projetos.

16. Implementar editor de pipeline com @xyflow/react (nós arrastáveis, conexões, config por nó).
17. Implementar gerador de arquivos CI/CD (GitHub Actions / GitLab CI) a partir do pipeline visual.
18. Implementar `template_engine.cpp` no core — geração de projetos a partir de templates.
19. Criar templates iniciais: Laravel, React (Vite), Node.js (Express) — cada um com CI/CD.
20. Implementar página Projects na GUI: wizard de criação com seleção de template.
21. Implementar execução local de pipeline com visualização de progresso.

**Verificação:**
- Pipeline criado visualmente gera GitHub Actions YAML válido.
- Template Laravel gera projeto funcional com CI/CD.
- Pipeline executa localmente e mostra progresso visual (nós mudam de cor).

### Fase 4: Daemon Completo e Integração systemd

> Objetivo: Serviço background robusto com socket activation.

22. Implementar reconciliation loop no daemon: estado desejado (YAML) vs estado atual → convergência automática.
23. Integrar com systemd via sdbus-c++ (D-Bus): status de serviços, start/stop/restart.
24. Implementar socket activation para boot rápido.
25. Implementar notificações e alertas (serviço down, disco cheio).
26. Implementar RBAC básico: roles admin, developer, viewer.

**Verificação:**
- `systemctl status wifipiratasd` mostra daemon rodando.
- Alterar YAML e daemon automaticamente reconcilia o estado.
- Alertas funcionam para serviços unhealthy.

### Fase 5: Rede e Storage (Preparação Distro)

> Objetivo: Módulos de rede e storage para a futura distro.

27. Implementar `network.cpp`: configuração de interfaces via netlink, nftables para firewall.
28. Implementar `storage.cpp`: gerenciamento de pools ZFS/Btrfs, snapshots, shares SMB/NFS.
29. Implementar monitoramento SNMP (net-snmp) para equipamentos de rede.
30. Implementar monitoramento S.M.A.R.T. de discos.
31. Criar páginas na GUI: Network e Storage.

**Verificação:**
- Interface de rede configurável pela GUI.
- Pool ZFS criado e gerenciado pela GUI.
- Switch SNMP monitorado no dashboard.

### Fase 6: Distro — Geração de ISO Customizada

> Objetivo: ISO instalável baseada em Debian com tudo integrado.

32. Criar base mínima Debian com debootstrap/live-build.
33. Integrar core + daemon + GUI + CLI como packages nativos.
34. Configurar boot: GRUB → systemd → wifipiratasd → GUI (opcional).
35. Implementar installer: wizard de instalação do OS.
36. Implementar updates atômicos (A/B partitions ou OSTree).
37. Gerar ISO para x86_64 e ARM64.

**Verificação:**
- ISO instala em VM (QEMU/VirtualBox) sem erros.
- Após boot, dashboard abre automaticamente.
- Update atômico funciona com rollback.

---

## 9. Arquivos Relevantes (Estado Atual)

### Manter e migrar para scripts/
- `bin/wifipirata` — CLI bash atual (substituído pelo CLI C++ na Fase 1)
- `bin/setup_menu.sh` — Menu whiptail (mantido como fallback terminal)
- `modules/*.sh` (11 módulos: apache2, composer, docker, docker_compose, kubernetes, mariadb, mongodb, mysql, nginx, nvm, php)
- `utils/common.sh` — Funções utilitárias (log, check_ubuntu, validate_args)
- `build_deb.sh` — Build de .deb (referência para electron-builder)
- `packaging/` — Controle e postinst do .deb

### Problemas conhecidos (corrigir na migração)
- `setup_menu.sh` tem caminhos hardcoded (`/home/maiconparra/Scripts-Bash/modules/...`)
- Módulos sem `set -e` ou trap para cleanup
- Detecção de versão duplicada em 4 módulos (php, nvm, docker, mongodb)
- Instalação do NVM modifica `~/.bashrc`/`~/.zshrc` de forma não-idempotente

### Criar (novos)
- `core/` — Engine C++
- `daemon/` — Serviço systemd
- `cli/` — CLI C++ nativo
- `node-binding/` — Bridge N-API
- `gui/` — Electron + React
- `templates/` — Templates de projetos e pipelines
- `packaging/iso/` — Build da distro

---

## 10. Decisões

1. **Base Debian** — Maior ecossistema, LTS, APT maduro, documentação extensa.
2. **C++ como core** — Performance para a distro, acesso baixo nível a rede/storage, longevidade.
3. **Electron + React + Vite + TypeScript** — Ecossistema Node.js maduro, binding direto C++→Node via N-API, bibliotecas ricas para dashboards e pipeline visual.
4. **Scripts bash mantidos** — Core C++ chama scripts existentes via `shell_executor`. Migração gradual para C++ nativo nas fases posteriores.
5. **gRPC para IPC** — Comunicação tipada e eficiente entre daemon↔GUI/CLI. REST gateway para acesso externo.
6. **YAML declarativo** — Padrão DevOps, inspirado em docker-compose e NixOS.
7. **Monorepo** — Simplifica builds e versionamento até a Fase 6.
8. **Fases incrementais** — Cada fase entrega valor independente e é verificável.

---

## 11. Considerações e Próximos Passos

1. Configurar CI/CD do próprio projeto (GitHub Actions para build CMake + Vite + testes) desde a Fase 1.
2. Definir licença do projeto (GPL-3.0 como TrueNAS/OMV? Apache-2.0 como CasaOS?).
3. Definir identidade visual e branding da distro.
4. Confirmar stacks e aplicações prioritárias para os primeiros templates.
5. Definir padrões mínimos para os pipelines CI/CD gerados.
6. Prioridade imediata: Fase 1 — `shell_executor` + CLI C++ para validar pipeline de build CMake.

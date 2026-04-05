# Wireframes — WifiPirata OS

> Diagramas de layout para cada tela principal. Use como referência para reproduzir no Figma.

---

## 1. Layout Geral (Shell)

```
┌──────────────────────────────────────────────────────────────────────┐
│ HEADER (56px)                                    🔔  🔍  👤 Admin  │
│ ☰ WifiPirata OS                      [search bar]                   │
├────────────┬─────────────────────────────────────────────────────────┤
│            │                                                         │
│  SIDEBAR   │  CONTENT AREA                                           │
│  (260px)   │  (flex-1, max 1440px, padding 24px)                     │
│            │                                                         │
│  ┌──────┐  │  ┌─────────────────────────────────────────────────┐    │
│  │ Logo │  │  │                                                 │    │
│  └──────┘  │  │  [Conteúdo da página ativa]                     │    │
│            │  │                                                 │    │
│  MAIN      │  │                                                 │    │
│  ▸ Dashboard│  │                                                 │    │
│  ▸ Environ.│  │                                                 │    │
│  ▸ Pipeline│  │                                                 │    │
│  ▸ Projects│  │                                                 │    │
│            │  │                                                 │    │
│  MONITOR   │  │                                                 │    │
│  ▸ Metrics │  │                                                 │    │
│  ▸ Logs    │  │                                                 │    │
│  ▸ Services│  │                                                 │    │
│            │  │                                                 │    │
│  SYSTEM    │  │                                                 │    │
│  ▸ Network*│  │                                                 │    │
│  ▸ Storage*│  │                                                 │    │
│  ▸ Settings│  │                                                 │    │
│            │  │                                                 │    │
│  (* futuro)│  └─────────────────────────────────────────────────┘    │
│            │                                                         │
└────────────┴─────────────────────────────────────────────────────────┘
```

### Sidebar — Comportamento
- **Expandida** (260px): ícone + texto do item
- **Colapsada** (64px): apenas ícone, tooltip no hover
- **Ativo**: background primary-500, texto branco
- **Seções**: Labels em CAPS (xs, neutral-400), separadas por 8px gap

---

## 2. Dashboard

```
┌─────────────────────────────────────────────────────────────────┐
│  Dashboard                                     [↻ Refresh]      │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─── STATUS CARDS (grid 4 colunas) ───────────────────────┐    │
│  │                                                          │    │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐ │    │
│  │  │ ● CPU    │  │ ● RAM    │  │ ● DISCO  │  │ ● REDE   │ │    │
│  │  │          │  │          │  │          │  │          │ │    │
│  │  │  42%     │  │  6.2 GB  │  │  120 GB  │  │  ↓ 2.1  │ │    │
│  │  │ ████░░░  │  │ ██████░  │  │ ████░░░  │  │  MB/s   │ │    │
│  │  │ 8 cores  │  │ /16 GB   │  │ /256 GB  │  │  ↑ 0.5  │ │    │
│  │  └──────────┘  └──────────┘  └──────────┘  └──────────┘ │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
│  ┌─── AMBIENTES ATIVOS (grid 3 colunas) ───────────────────┐    │
│  │                                                          │    │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌──────────┐ │    │
│  │  │ 🟢 meu-projeto  │  │ 🟡 api-teste    │  │  [+]     │ │    │
│  │  │ DEV             │  │ TESTE            │  │  Novo    │ │    │
│  │  │                 │  │                  │  │ Ambiente │ │    │
│  │  │ PHP 8.2         │  │ PHP 8.3          │  │          │ │    │
│  │  │ MySQL 8.0       │  │ PostgreSQL 16    │  │          │ │    │
│  │  │ Nginx           │  │ Apache           │  │          │ │    │
│  │  │                 │  │                  │  │          │ │    │
│  │  │ 3 containers    │  │ 2 containers     │  │          │ │    │
│  │  │ [Abrir] [⋮]    │  │ [Abrir] [⋮]     │  │          │ │    │
│  │  └─────────────────┘  └─────────────────┘  └──────────┘ │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
│  ┌─── GRÁFICO DE PERFORMANCE (linha/área) ─────────────────┐    │
│  │                                                          │    │
│  │  100% ┤                                                  │    │
│  │       │    ╭──╮                                          │    │
│  │   75% ┤   │  │         ╭─╮                              │    │
│  │       │  ╭╯  ╰╮  ╭─╮  │ │                              │    │
│  │   50% ┤──╯    ╰──╯ ╰──╯ ╰───────────────── CPU         │    │
│  │       │                            ──────── RAM         │    │
│  │   25% ┤                                                  │    │
│  │       │                                                  │    │
│  │    0% ┤──────────────────────────────────────            │    │
│  │       10:00  10:30  11:00  11:30  12:00                  │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
│  ┌─── ATIVIDADE RECENTE (tabela) ──────────────────────────┐    │
│  │  Hora    │ Ação              │ Ambiente    │ Status      │    │
│  │  12:30   │ Deploy v2.1.0     │ api-teste   │ 🟢 Success │    │
│  │  12:15   │ Build pipeline    │ meu-projeto │ 🟢 Success │    │
│  │  11:45   │ Install PHP 8.3   │ api-teste   │ 🟢 Success │    │
│  │  11:30   │ Create env        │ api-teste   │ 🟢 Created │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. Environments (Ambientes)

### 3.1 Lista de Ambientes

```
┌─────────────────────────────────────────────────────────────────┐
│  Environments                          [+ Novo Ambiente]         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  [Todos ▾]  [🔍 Buscar...]  [Dev | Teste | Prod]               │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐    │
│  │ TREE VIEW (esquerda, 280px)│ DETALHES (direita, flex)    │    │
│  │                            │                              │    │
│  │ ▼ meu-projeto              │ ┌────────────────────────┐  │    │
│  │   ├─ 🟢 dev               │ │  meu-projeto / dev     │  │    │
│  │   ├─ 🟡 teste             │ │  Status: Running 🟢    │  │    │
│  │   └─ 🔴 prod              │ │  Uptime: 3d 12h        │  │    │
│  │                            │ │                        │  │    │
│  │ ▼ api-backend              │ │  SERVIÇOS              │  │    │
│  │   ├─ 🟢 dev               │ │  ┌──────┬───────┬────┐ │  │    │
│  │   └─ 🟢 teste             │ │  │ PHP  │ 8.2   │ 🟢 │ │  │    │
│  │                            │ │  │ MySQL│ 8.0   │ 🟢 │ │  │    │
│  │ ▸ microservices            │ │  │ Nginx│ 1.25  │ 🟢 │ │  │    │
│  │                            │ │  │ Redis│ 7.2   │ 🟢 │ │  │    │
│  │                            │ │  └──────┴───────┴────┘ │  │    │
│  │                            │ │                        │  │    │
│  │                            │ │  MÉTRICAS              │  │    │
│  │                            │ │  CPU: 12% │ RAM: 340MB │  │    │
│  │                            │ │                        │  │    │
│  │                            │ │  AÇÕES                 │  │    │
│  │                            │ │  [Parar] [Clonar]      │  │    │
│  │                            │ │  [Editar] [Destruir]   │  │    │
│  │                            │ └────────────────────────┘  │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 3.2 Criar Ambiente (Modal/Wizard)

```
┌─────────────────────────────────────────────────┐
│  Novo Ambiente                            [✕]   │
├─────────────────────────────────────────────────┤
│                                                  │
│  Step 1 ● ─── Step 2 ○ ─── Step 3 ○ ─── ○ 4   │
│  Stack       Serviços      Config       Review   │
│                                                  │
│  ┌───────────────────────────────────────────┐   │
│  │  Nome: [meu-novo-projeto          ]       │   │
│  │  Tipo: [Dev ▾]                            │   │
│  │                                           │   │
│  │  Stack:                                   │   │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐     │   │
│  │  │  ☐ PHP  │ │  ☐ Node │ │  ☐ Python│    │   │
│  │  │  Laravel│ │  Express│ │  Django  │    │   │
│  │  └─────────┘ └─────────┘ └─────────┘     │   │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐     │   │
│  │  │  ☐ React│ │  ☐ Vue  │ │  ☐ Go   │    │   │
│  │  │  Vite   │ │  Nuxt   │ │  Gin    │    │   │
│  │  └─────────┘ └─────────┘ └─────────┘     │   │
│  └───────────────────────────────────────────┘   │
│                                                  │
│                      [Cancelar]  [Próximo →]     │
└─────────────────────────────────────────────────┘
```

---

## 4. Pipeline Editor

```
┌─────────────────────────────────────────────────────────────────┐
│  Pipeline Editor                [▶ Executar]  [💾 Salvar]       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌── TOOLBAR ───────────────────────────────────────────────┐    │
│  │  [+ Build] [+ Test] [+ Deploy] [+ Notify] [+ Custom]    │    │
│  │  Zoom: [−] 100% [+]  │  [Grid ▾]  │  [Exportar YAML]   │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
│  ┌── CANVAS (React Flow) ──────────────────────────────────┐    │
│  │                                                          │    │
│  │     ┌──────────┐     ┌──────────┐     ┌──────────┐      │    │
│  │     │ 🔨 BUILD │────▶│ 🧪 TEST  │────▶│ 🧪 TEST  │     │    │
│  │     │          │     │          │     │          │      │    │
│  │     │ npm run  │     │ unit     │     │ e2e      │      │    │
│  │     │ build    │     │ tests    │     │ tests    │      │    │
│  │     └──────────┘     └──────────┘     └─────┬────┘      │    │
│  │                                              │           │    │
│  │                                              ▼           │    │
│  │                                        ┌──────────┐      │    │
│  │                                        │ 🚀 DEPLOY│     │    │
│  │                                        │          │      │    │
│  │                                        │ staging  │      │    │
│  │                                        │ server   │      │    │
│  │                                        └─────┬────┘      │    │
│  │                                              │           │    │
│  │                                              ▼           │    │
│  │                                        ┌──────────┐      │    │
│  │                                        │ 🔔 NOTIFY│     │    │
│  │                                        │          │      │    │
│  │                                        │ Slack    │      │    │
│  │                                        │ #deploy  │      │    │
│  │                                        └──────────┘      │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
│  ┌── NODE CONFIG (painel lateral direito, 320px) ──────────┐    │
│  │  Configuração: BUILD                                     │    │
│  │                                                          │    │
│  │  Nome: [npm run build       ]                            │    │
│  │  Runner: [ubuntu-latest ▾]                               │    │
│  │  Timeout: [30 ▾] minutos                                 │    │
│  │                                                          │    │
│  │  Comandos:                                               │    │
│  │  ┌────────────────────────────────────────┐              │    │
│  │  │ npm ci                                 │              │    │
│  │  │ npm run build                          │              │    │
│  │  │ npm run lint                           │              │    │
│  │  └────────────────────────────────────────┘              │    │
│  │                                                          │    │
│  │  Variáveis de ambiente:                                  │    │
│  │  [NODE_ENV] = [production]                     [+ Add]   │    │
│  │                                                          │    │
│  │  [Aplicar]  [Remover nó]                                 │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Pipeline em execução (cores dos nós)

```
  ┌──────────┐     ┌──────────┐     ┌──────────┐
  │ ✅ BUILD │────▶│ ⏳ TEST  │────▶│ ⬜ TEST  │
  │ (verde)  │     │ (azul    │     │ (cinza)  │
  │ 45s      │     │ pulsando)│     │ pending  │
  └──────────┘     └──────────┘     └──────────┘

  Legenda:
  ✅ Verde   = Concluído com sucesso
  ⏳ Azul    = Em execução (pulsa)
  ⬜ Cinza   = Pendente
  ❌ Vermelho = Falhou
  ⚠️ Amarelo  = Warning
```

---

## 5. Monitoring

```
┌─────────────────────────────────────────────────────────────────┐
│  Monitoring                    [Auto-refresh: 5s ▾]             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌── TABS ─────────────────────────────────────────────────┐    │
│  │  [Metrics]  [Logs]  [Containers]  [Services]            │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
│  === Tab: Metrics ===                                            │
│                                                                  │
│  ┌─── CPU ─────────────────┐  ┌─── RAM ────────────────────┐    │
│  │  100%                   │  │  16 GB                     │    │
│  │   ╭─╮    ╭╮            │  │         ╭────────╮         │    │
│  │  ╭╯ ╰╮  ╭╯╰╮  ╭╮      │  │  ╭──────╯        ╰─────╮  │    │
│  │──╯   ╰──╯  ╰──╯╰──    │  │──╯                      ╰  │    │
│  │   0%                   │  │   0 GB                     │    │
│  └─────────────────────────┘  └────────────────────────────┘    │
│                                                                  │
│  ┌─── Disco I/O ───────────┐  ┌─── Network ───────────────┐    │
│  │  Read: 45 MB/s          │  │  ↓ Download: 12.3 MB/s    │    │
│  │  Write: 12 MB/s         │  │  ↑ Upload: 2.1 MB/s       │    │
│  │  ███████░░░░░ r         │  │  ═══════════ down          │    │
│  │  ███░░░░░░░░░ w         │  │  ═══░░░░░░░ up             │    │
│  └─────────────────────────┘  └────────────────────────────┘    │
│                                                                  │
│  === Tab: Logs ===                                               │
│                                                                  │
│  ┌── Filtros ──────────────────────────────────────────────┐    │
│  │  [Todos ▾]  [Ambiente ▾]  [Nível ▾]  [🔍 Buscar...]   │    │
│  └─────────────────────────────────────────────────────────┘    │
│  ┌── Log stream (mono, fundo escuro) ─────────────────────┐    │
│  │  12:30:01 INFO  [php-fpm] Worker started pid=1234       │    │
│  │  12:30:02 INFO  [nginx]   GET /api/health 200 2ms      │    │
│  │  12:30:05 WARN  [mysql]   Slow query detected (>500ms) │    │
│  │  12:30:06 ERROR [php-fpm] Uncaught exception: ...       │    │
│  │  12:30:06 INFO  [nginx]   POST /api/users 201 45ms     │    │
│  │  ▌ (cursor piscando — streaming)                        │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
│  === Tab: Containers ===                                         │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐    │
│  │  Nome            │ Imagem       │ Status │ CPU  │ RAM   │    │
│  │  meu-proj-php    │ php:8.2-fpm  │ 🟢 Up │ 3%   │ 120MB│    │
│  │  meu-proj-mysql  │ mysql:8.0    │ 🟢 Up │ 1%   │ 400MB│    │
│  │  meu-proj-nginx  │ nginx:1.25   │ 🟢 Up │ 0.2% │ 15MB │    │
│  │  meu-proj-redis  │ redis:7.2    │ 🟢 Up │ 0.1% │ 8MB  │    │
│  │  api-teste-php   │ php:8.3-fpm  │ 🟡 Re │ --   │ --   │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 6. Projects (Inicialização)

```
┌─────────────────────────────────────────────────────────────────┐
│  Projects                              [+ Novo Projeto]          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌── TEMPLATES DISPONÍVEIS (grid 3 col) ───────────────────┐    │
│  │                                                          │    │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌──────────┐ │    │
│  │  │  🐘 Laravel     │  │  ⚛️  React      │  │  🟢 Node │ │    │
│  │  │                 │  │   (Vite + TS)   │  │  Express  │ │    │
│  │  │  PHP 8.2+       │  │                 │  │          │ │    │
│  │  │  MySQL/PgSQL    │  │  TypeScript     │  │  MongoDB │ │    │
│  │  │  Redis          │  │  Tailwind       │  │  Redis   │ │    │
│  │  │  Nginx          │  │  Vitest         │  │  Docker  │ │    │
│  │  │                 │  │                 │  │          │ │    │
│  │  │  CI/CD: ✅      │  │  CI/CD: ✅      │  │  CI/CD ✅│ │    │
│  │  │  Docker: ✅     │  │  Docker: ✅     │  │  Docker ✅│ │    │
│  │  │                 │  │                 │  │          │ │    │
│  │  │  [Usar template]│  │  [Usar template]│  │  [Usar]  │ │    │
│  │  └─────────────────┘  └─────────────────┘  └──────────┘ │    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
│  ┌── PROJETOS RECENTES (tabela) ───────────────────────────┐    │
│  │  Nome            │ Stack    │ Criado    │ Ambiente │ Ação│    │
│  │  meu-projeto     │ Laravel  │ 2 dias    │ dev 🟢   │ [⋮]│    │
│  │  api-backend     │ Node     │ 1 semana  │ dev 🟢   │ [⋮]│    │
│  │  frontend-app    │ React    │ 3 semanas │ teste 🟡 │ [⋮]│    │
│  └──────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 7. Settings

```
┌─────────────────────────────────────────────────────────────────┐
│  Settings                                                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌── TABS ─────────────────────────────────────────────────┐    │
│  │  [Geral]  [Aparência]  [Módulos]  [Usuários]  [Sobre]  │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
│  === Tab: Geral ===                                              │
│                                                                  │
│  Configurações do Daemon                                         │
│  ┌───────────────────────────────────────────────────────┐      │
│  │  Auto-refresh interval:  [5 ▾] segundos               │      │
│  │  Default shell:          [/bin/bash ▾]                 │      │
│  │  Scripts directory:      [/usr/lib/wifipirata/scripts] │      │
│  │  Log level:              [info ▾]                      │      │
│  └───────────────────────────────────────────────────────┘      │
│                                                                  │
│  Configuração YAML padrão                                        │
│  ┌───────────────────────────────────────────────────────┐      │
│  │  Default environment type:  [dev ▾]                    │      │
│  │  Default container runtime: [docker ▾]                 │      │
│  │  Config file path:          [~/.wifipirata/config.yaml]│      │
│  └───────────────────────────────────────────────────────┘      │
│                                                                  │
│  === Tab: Aparência ===                                          │
│                                                                  │
│  Tema                                                            │
│  ┌───────────────────────────────────────────────────────┐      │
│  │  ◉ Dark (padrão)   ○ Light   ○ System                 │      │
│  │                                                        │      │
│  │  Accent color: [●] Indigo  [●] Cyan  [●] Violet       │      │
│  │                [●] Green   [●] Amber [●] Rose          │      │
│  │                                                        │      │
│  │  Sidebar: ◉ Expandida  ○ Colapsada                     │      │
│  │  Density: ○ Compact  ◉ Default  ○ Comfortable          │      │
│  └───────────────────────────────────────────────────────┘      │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 8. Responsividade

| Breakpoint | Sidebar | Cards Grid | Pipeline Config |
|---|---|---|---|
| ≥1440px | Expandida (260px) | 4 colunas | Lateral (320px) |
| 1024-1439px | Expandida (260px) | 3 colunas | Lateral (280px) |
| 768-1023px | Colapsada (64px) | 2 colunas | Bottom sheet |
| <768px | Drawer (overlay) | 1 coluna | Full screen modal |

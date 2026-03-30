git 
<p align="center">
	<img src="https://media.giphy.com/media/LMt9638dO8dftAjtco/giphy.gif" width="320" alt="Terminal Animation">
</p>

# 🚀 Scripts-Bash: Ambiente PHP & Composer Adaptativo

<p align="center">
	<img src="https://img.shields.io/badge/Ubuntu-18.04%20%7C%2020.04%20%7C%2022.04%20%7C%2023.10-orange?logo=ubuntu">
	<img src="https://img.shields.io/badge/Shell-Bash-1f425f.svg?logo=gnu-bash">
	<img src="https://img.shields.io/badge/license-MIT-green">
	<img src="https://img.shields.io/badge/status-Ativo-brightgreen">
</p>

---

## ✨ Sobre

Scripts para instalar e remover PHP (várias versões) e Composer de forma adaptativa, prontos para evoluir de desenvolvimento para produção em diferentes versões do Ubuntu.

---

## ⚡ Instalação Rápida

```bash
chmod +x index.sh install_env.sh remove_env.sh
```

---

## 🛠️ Comandos

| Comando                                 | Ação                                        |
|------------------------------------------|----------------------------------------------|
| `./index.sh --install-php`               | Instala PHP (versão recomendada) e Composer  |
| `./index.sh --install-php 8.2`           | Instala PHP 8.2 e Composer                   |
| `./index.sh --uninstall-php`             | Remove PHP (versão recomendada) e Composer   |
| `./index.sh --uninstall-php 8.2`         | Remove PHP 8.2 e Composer                    |
| `./index.sh --help`                      | Exibe ajuda                                  |

---

## 📦 Exemplos

```bash
# Instalar PHP recomendado e Composer
./index.sh --install-php

# Instalar PHP 8.2 e Composer
./index.sh --install-php 8.2

# Remover PHP recomendado e Composer
./index.sh --uninstall-php

# Remover PHP 8.2 e Composer
./index.sh --uninstall-php 8.2
```

---

## 📝 Observações

- Scripts testados em Ubuntu 18.04, 20.04, 22.04, 23.10.
- Sempre execute com permissões de superusuário quando solicitado.
- Pronto para evoluir para ambientes de produção.

---

## 🎬 Animações no README

Você pode adicionar animações usando GIFs ou SVGs animados. Basta usar a tag `<img>` ou Markdown padrão:

```markdown
![Demo](https://media.giphy.com/media/LMt9638dO8dftAjtco/giphy.gif)
```

---

## 📄 Licença

MIT
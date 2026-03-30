#!/bin/bash
# bin/setup_menu.sh - Menu interativo para instalação/remoção de aplicações
# (Conteúdo igual ao setup_menu.sh já ajustado, mas agora referenciando modules/)
set -e

source /home/maiconparra/Scripts-Bash/utils/common.sh

choose_version() {
  local app="$1"
  shift
  local versions=("$@")
  local version
  local menu_args=()
  menu_args+=("default" "Versão LTS (recomendada)")
  for v in "${versions[@]}"; do
    menu_args+=("$v" "$v")
  done
  version=$(whiptail --title "Escolha a versão do $app" --menu "Selecione a versão desejada:" 18 60 8 "${menu_args[@]}" 3>&1 1>&2 2>&3)
  [ -z "$version" ] && version="default"
  echo "$version"
}

CHOICES=$(whiptail --title "Setup de Ambiente" --checklist \
"Selecione as aplicações para instalar/remover (use espaço para marcar):" 20 78 12 \
"php" "PHP" OFF \
"composer" "Composer" OFF \
"docker" "Docker" OFF \
"docker-compose" "Docker Compose" OFF \
"kubernetes" "Kubernetes" OFF \
"apache2" "Apache2" OFF \
"nginx" "Nginx" OFF \
"mongodb" "MongoDB" OFF \
"mysql" "MySQL" OFF \
"mariadb" "MariaDB" OFF \
"nvm" "NVM (Node Version Manager)" OFF 3>&1 1>&2 2>&3)

[ $? -ne 0 ] && echo "Cancelado pelo usuário." && exit 1

ACTION=$(whiptail --title "Ação" --menu "O que deseja fazer?" 12 60 2 \
"install" "Instalar" \
"remove" "Remover" 3>&1 1>&2 2>&3)

[ $? -ne 0 ] && echo "Cancelado pelo usuário." && exit 1

for APP in $CHOICES; do
  APP=$(echo $APP | tr -d '"')
  VERSION="default"
  case $APP in
    php)
      if [ "$ACTION" = "remove" ]; then
        # Listar versões instaladas de PHP
        PHP_VERSIONS=$(dpkg -l | grep '^ii  php[0-9]\.[0-9]' | awk '{print $2}' | grep -oE '[0-9]\.[0-9]+' | sort -u | tr '\n' ' ')
        if [ -z "$PHP_VERSIONS" ]; then
          whiptail --msgbox "Nenhuma versão do PHP encontrada para remoção." 10 60
          continue
        fi
        VERSION=$(whiptail --title "Remover PHP" --menu "Escolha a versão do PHP para remover:" 18 60 8 $(for v in $PHP_VERSIONS; do echo "$v $v"; done) 3>&1 1>&2 2>&3)
        [ -z "$VERSION" ] && continue
      else
        VERSION=$(choose_version "PHP" "7.4" "8.0" "8.1" "8.2" "8.3")
        if [ "$VERSION" = "default" ]; then
          VERSION=$(apt-cache policy php | grep Candidate | grep -oE '[0-9]\.[0-9]+' | head -n1)
          [ -z "$VERSION" ] && VERSION="8.2"
          log "[INFO] PHP default/LTS detectado: $VERSION"
        fi
      fi
      bash /home/maiconparra/Scripts-Bash/modules/php.sh "$VERSION" "$ACTION"
      ;;
    mysql)
      VERSION=$(choose_version "MySQL" "5.7" "8.0")
      if [ "$VERSION" = "default" ]; then
        VERSION=$(apt-cache policy mysql-server | grep Candidate | grep -oE '[0-9]\.[0-9]+' | head -n1)
        [ -z "$VERSION" ] && VERSION="8.0"
        log "[INFO] MySQL default/LTS detectado: $VERSION"
      fi
      bash /home/maiconparra/Scripts-Bash/modules/mysql.sh "$VERSION" "$ACTION"
      ;;
    mariadb)
      VERSION=$(choose_version "MariaDB" "10.5" "10.6" "10.11")
      if [ "$VERSION" = "default" ]; then
        VERSION=$(apt-cache policy mariadb-server | grep Candidate | grep -oE '[0-9]+\.[0-9]+' | head -n1)
        [ -z "$VERSION" ] && VERSION="10.11"
        log "[INFO] MariaDB default/LTS detectado: $VERSION"
      fi
      bash /home/maiconparra/Scripts-Bash/modules/mariadb.sh "$VERSION" "$ACTION"
      ;;
    mongodb)
      VERSION=$(choose_version "MongoDB" "4.4" "5.0" "6.0")
      if [ "$VERSION" = "default" ]; then
        LATEST_MONGO=$(curl -s https://www.mongodb.com/try/download/community | grep -oP 'server/\K[0-9]+\.[0-9]+' | sort -V | tail -n1)
        VERSION=${LATEST_MONGO:-6.0}
        log "[INFO] MongoDB default/LTS detectado: $VERSION"
      fi
      bash /home/maiconparra/Scripts-Bash/modules/mongodb.sh "$VERSION" "$ACTION"
      ;;
    docker-compose)
      VERSION=$(choose_version "Docker Compose" "1.29.2" "2.24.6")
      if [ "$VERSION" = "default" ]; then
        LATEST_COMPOSE=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f4 | sed 's/^v//')
        VERSION=${LATEST_COMPOSE:-2.24.6}
        log "[INFO] Docker Compose default/LTS detectado: $VERSION"
      fi
      bash /home/maiconparra/Scripts-Bash/modules/docker_compose.sh "$VERSION" "$ACTION"
      ;;
    *)
      bash /home/maiconparra/Scripts-Bash/modules/${APP}.sh "$ACTION"
      ;;
  esac
  echo "---"
done

echo "\nOperação concluída! Veja os logs acima para detalhes."

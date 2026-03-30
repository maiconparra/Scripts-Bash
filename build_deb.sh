#!/bin/bash
set -e

PKG_NAME="wifipirata"
PKG_VERSION="1.0.0"
BUILD_DIR="${PKG_NAME}_${PKG_VERSION}"

# Limpa build anterior
echo "Limpando build anterior..."
rm -rf "$BUILD_DIR" "${BUILD_DIR}.deb"

# Cria estrutura de diretórios
echo "Criando estrutura de diretórios..."
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/usr/bin"
mkdir -p "$BUILD_DIR/usr/lib/wifipirata/bin"
mkdir -p "$BUILD_DIR/usr/lib/wifipirata/modules"
mkdir -p "$BUILD_DIR/usr/lib/wifipirata/utils"

# Copia scripts principais
echo "Copiando scripts principais..."
cp bin/wifipirata "$BUILD_DIR/usr/bin/"
cp bin/setup_menu.sh bin/install.sh "$BUILD_DIR/usr/lib/wifipirata/bin/"
cp modules/*.sh "$BUILD_DIR/usr/lib/wifipirata/modules/"
cp utils/*.sh "$BUILD_DIR/usr/lib/wifipirata/utils/"

# Copia arquivos de controle
echo "Copiando arquivos de controle..."
cp packaging/control "$BUILD_DIR/DEBIAN/"
cp packaging/postinst "$BUILD_DIR/DEBIAN/"
chmod 755 "$BUILD_DIR/DEBIAN/postinst"

# Permissões dos scripts
echo "Ajustando permissões..."
chmod 755 "$BUILD_DIR/usr/bin/wifipirata"
chmod 755 "$BUILD_DIR/usr/lib/wifipirata/bin/"*.sh
chmod 755 "$BUILD_DIR/usr/lib/wifipirata/modules/"*.sh
chmod 755 "$BUILD_DIR/usr/lib/wifipirata/utils/"*.sh

# Build do pacote
echo "Gerando pacote .deb..."
dpkg-deb --build "$BUILD_DIR"

echo "Pacote .deb gerado: ${BUILD_DIR}.deb"

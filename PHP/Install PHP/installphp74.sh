#!/bin/bash

sudo apt update

sudo apt install -y php$1

sudo apt install -y php$1-common php$1-mysql php$1-xml php$1-xmlrpc php$1-curl php$1-gd php$1-imagick php$1-cli php$1-dev php$1-imap php$1-mbstring php$1-opcache php$1-soap php$1-zip php$1-intl


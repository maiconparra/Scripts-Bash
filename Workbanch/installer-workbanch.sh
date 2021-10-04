#!/bin/bash

sudo apt-get update
lsb_release -rs
cd ~/Downloads
wget http://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-community_8.0.25-1ubuntu20.04_amd64.deb -O mysql-workbench-community.deb
sudo dpkg -i mysql-workbench-community.deb
sudo apt-get -f install -y
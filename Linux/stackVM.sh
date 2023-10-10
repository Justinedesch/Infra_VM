#!/bin/sh
chmod +x stackVM.sh

#INSTALLER LA STACK

sudo apt-get update

#Mariadb
sudo apt install mariadb-server
sudo mysql_secure_installation
sudo systemctl status mariadb


#php / composer
sudo apt-get install curl
sudo apt-get install php php-curl
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo composer self-update
composer -v


sudo apt install php-xml 
sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates 
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -

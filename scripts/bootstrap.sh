#!/usr/bin/env bash

echo "Installing nginx..."
sudo apt-get -y update
sudo apt-get -y install nginx

echo "Starting nginx..."
sudo service nginx start

echo "Installing docker prerequisites..."
sudo apt-get install -y apt-transport-https

echo "Installing docker ..."
wget -nv -O - https://get.docker.com/ | sh

echo "Installing dokku..."
wget https://raw.githubusercontent.com/dokku/dokku/v0.20.4/bootstrap.sh;
sudo DOKKU_TAG=v0.20.4 bash bootstrap.sh

# TODO - Move configuration up to terraform
echo "Post-install dokku setup..."
dokku domains:set-global raddeus.com
sudo service dokku-installer stop

echo "Installing and configuring letsencrypt plugin..."
sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku config:set --global DOKKU_LETSENCRYPT_EMAIL=thadblankenship@gmail.com
dokku letsencrypt:cron-job --add
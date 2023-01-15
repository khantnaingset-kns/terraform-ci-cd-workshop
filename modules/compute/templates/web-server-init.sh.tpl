#!/bin/bash

echo "----Installing Docker----"

apt update &&  apt upgrade -y

apt install apt-transport-https curl gnupg-agent ca-certificates software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

apt install docker-ce docker-ce-cli containerd.io -y

systemctl enable docker

echo "----Installing Nginx----"

apt install nginx -y

unlink /etc/nginx/sites-enabled/default

echo "----Pulling Docker Image----"

docker pull khantki/ayapay-simple-node-app:main


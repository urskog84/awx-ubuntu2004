#!/bin/bash

# Variables section

dns_servers="8.8.8.8,8.8.4.4"
admin_password="passw0rd"

# pws
pwd=$(pwd)



sudo apt update -y

# Install docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and config
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker

# Install dependencies for AWX
sudo apt install git ansible nodejs gettext lvm2 bzip2 python3-pip -y
sudo pip3 install docker docker-compose

# Clone AWX
echo "clone awx"
[ ! -d $pwd/awx ] && git clone https://github.com/ansible/awx.git -q

# Config inventory 
if [ -f $pwd/awx/installer/conf_done ]; then
    echo "skipping inventory confg"
else
    secret_key=$(openssl rand -base64 30)

    sudo sed -i "/secret_key=/c\secret_key=$secret_key" awx/installer/inventory 
    sudo sed -i "/awx_alternate_dns_servers=/c\awx_alternate_dns_servers=$dns_servers" awx/installer/inventory 
    sudo sed -i "/admin_password=/c\admin_password=$admin_password" awx/installer/inventory 

    touch $pwd/awx/installer/conf_done
fi

# Create folder /var/lib/pgdocker
[ ! -d /var/lib/pgdocker ] && sudo mkdir /var/lib/pgdocker

# Open firewall ports 80 and 443
sudo ufw allow http
sudo ufw allow https


# Start AWX install
sudo ansible-playbook -i $pwd/awx/installer/inventory $pwd/awx/installer/install.yml

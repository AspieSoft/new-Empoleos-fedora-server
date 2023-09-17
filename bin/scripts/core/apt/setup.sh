#!/bin/bash

dir="$1"
InstallType="$2"


# optimize package manager
# sudo apt -y install nala
# echo -e "\n" | sudo nala fetch
# sudp cp "$dir/bin/assets/nala.sh" /etc/profile.d


# install ufw (firewall)
sudo apt -y install ufw
sudo systemctl enable ufw --now
sudo ufw delete allow SSH
sudo ufw delete allow to 244.0.0.251 app mDNS
sudo ufw delete allow to ff02::fb app mDNS
echo -e "y\n" | sudo ufw delete 1

if [ "$InstallType" = "server" ]; then
  sudo ufw limit 22/tcp
  sudo ufw allow 80/tcp
  sudo ufw allow 443/tcp
fi

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw enable

# cleanup
sudo apt -y update
sudo apt -y autoremove
sudo apt -y autoclean

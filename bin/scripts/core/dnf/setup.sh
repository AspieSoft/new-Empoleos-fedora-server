#!/bin/bash

dir="$1"
InstallType="$2"


if ! grep -R "^# Added For Speed" /etc/dnf/dnf.conf; then
  sed -r -i 's/^best=(.*)$/best=True/m' /etc/dnf/dnf.conf

  echo "# Added For Speed" >> /etc/dnf/dnf.conf
  # echo "fastestmirror=True" >> /etc/dnf/dnf.conf
  echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
  echo "defaultyes=True" >> /etc/dnf/dnf.conf
  echo "keepcache=True" >> /etc/dnf/dnf.conf
  echo "install_weak_deps=False" >> /etc/dnf/dnf.conf
fi

dnf -y update


# install ufw (firewall)
sudo dnf -y install ufw
sudo systemctl disable firewalld
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

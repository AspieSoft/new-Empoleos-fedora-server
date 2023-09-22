#!/bin/bash

dir="$1"

sudo dnf -y install nemo
sudo dnf -y install nemo-fileroller
#todo: find xfce alternative
# xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

if test -d "/usr/share/applications"; then
  sudo sed -r -i 's/^OnlyShowIn=/#OnlyShowIn=/m' "/usr/share/applications/nemo.desktop"
  sudo sed -r -i 's#^inode/directory=(.*)$#inode/directory=nemo.desktop#m' "/usr/share/applications/gnome-mimeapps.list"
  git clone https://github.com/AspieSoft/linux-nemo-fix.git && ./linux-nemo-fix/install.sh
fi


sudo flatpak -y install flathub com.github.tchx84.Flatseal
sudo dnf -y install dconf-editor
sudo dnf -y install gparted
# sudo flatpak -y install flathub org.fedoraproject.MediaWriter
sudo dnf -y install liveusb-creator

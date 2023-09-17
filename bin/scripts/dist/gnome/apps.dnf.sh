#!/bin/bash

dir="$1"

sudo dnf -y install gnome-tweaks gnome-extensions-app
killall gnome-tweaks # this can fix the app if it will not open
# sudo flatpak -y install flathub org.gnome.Extensions
sudo flatpak -y install flathub com.mattjakeman.ExtensionManager
# sudo snap install gnome-extension-manager

sudo dnf -y install gnome-disk-utility
sudo dnf -y install gnome-boxes

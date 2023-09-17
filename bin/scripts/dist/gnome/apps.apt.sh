#!/bin/bash

dir="$1"

sudo apt -y install gnome-tweaks gnome-shell-extensions
killall gnome-tweaks # this can fix the app if it will not open
# sudo flatpak -y install flathub org.gnome.Extensions
sudo flatpak -y install flathub com.mattjakeman.ExtensionManager
# sudo snap install gnome-extension-manager

sudo apt -y install gnome-disk-utility
sudo apt -y install gnome-boxes

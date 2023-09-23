#!/bin/bash

dir="$1"

# install gdm (login manager / display manager)
sudo dnf -y install gdm

# install wayland (window manager / display server)
sudo dnf -y install wayland-devel
sudo dnf -y install wayland-utils

# install gnome
sudo dnf -y install gnome-shell
sudo dnf -y install gnome-session
sudo dnf -y install gnome-software
sudo dnf -y install gnome-terminal
sudo dnf -y install abattis-cantarell-fonts
sudo dnf -y install adwaita-icon-theme

# fix compatability
sudo dnf -y install plasma-framework


# sudo dnf -y install libgnome gnome-common
# sudo dnf -y install gnome-chess
# sudo dnf -y install f38-backgrounds-gnome
# sudo dnf -y install GtkAda-gnome

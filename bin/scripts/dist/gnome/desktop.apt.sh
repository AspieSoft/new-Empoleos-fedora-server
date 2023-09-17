#!/bin/bash

dir="$1"

# install gdm (login manager / display manager)
sudo apt -y install gdm3

# install wayland (window manager / display server)
sudo apt -y install xwayland

# install gnome
sudo apt -y install gnome-shell
sudo apt -y install gnome-session
sudo apt -y install gnome-software
sudo apt -y install gnome-terminal
sudo apt -y install fonts-cantarell
sudo apt -y install adwaita-icon-theme

# fix compatability
sudo apt -y install plasma-framework

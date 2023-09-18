#!/bin/bash

dir="$1"

# install gdm (login manager / display manager)
sudo dnf -y install gdm

# install wayland (window manager / display server)
sudo dnf -y install wayland-devel
sudo dnf -y install wayland-utils

# install xfce
sudo dnf -y install @base-x
sudo dnf -y install xorg-x11-server-Xorg xorg-x11-xinit xorg-x11-drv-libinput mesa-dri-drivers
sudo dnf -y install xfce4-panel xfce4-session xfce4-settings xfconf xfdesktop xfwm4
sudo dnf -y install @multimedia
sudo dnf -y install @networkmanager-submodules

# fix compatability
sudo dnf -y install plasma-framework

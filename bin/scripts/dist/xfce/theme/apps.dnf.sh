#!/bin/bash

dir="$1"

# security
sudo dnf -y install xfce4-fsguard-plugin

# preformance
sudo dnf -y install xfce4-diskperf-plugin


# other
sudo dnf -y install xfce4-whiskermenu-plugin

# sudo dnf -y install xfce4-panel xfce4-panel-profiles
sudo dnf -y install xfce4-docklike-plugin


sudo dnf -y install xfce4-dict
sudo dnf -y install xfce4-dev-tools


sudo dnf -y install libxfce4util-devel
sudo dnf -y install xfce4-sensors-plugin-devel
sudo dnf -y install xfce4-appfinder

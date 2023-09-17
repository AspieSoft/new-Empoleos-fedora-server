#!/bin/bash

sudo apt -y update
sudo apt -y upgrade

sudo dpkg --configure -a

# add repos
# sudo apt -y install ubuntu-restricted-extras
sudo apt-add-repository -y multiverse
sudo apt-add-repository -y universe
sudo apt-add-repository -y ppa:obsproject/obs-studio
sudo apt-add-repository -y ppa:cybermax-dexter/sdl2-backport
sudo apt-add-repository -y ppa:pinta-maintainers/pinta-stable

sudo apt -y update


# install media codecs
sudo apt -y install ffmpeg
sudo apt -y install webp libwebp-dev
sudo add-apt-repository -y ppa:helkaluin/webp-pixbuf-loader
sudo apt -y install webp-pixbuf-loader


# add flatpak
sudo apt -y install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update -y --noninteractive

# install snap
sudo apt -y install snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl enable snapd --now
sudo snap refresh #fix: not seeded yet will trigger and fix itself for the next command
sudo snap install core
sudo snap refresh core
sudo snap refresh

# cleanup
sudo apt -y update
sudo apt -y autoremove
sudo apt -y autoclean

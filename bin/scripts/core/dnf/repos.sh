#!/bin/bash

# add rpmfusion repos
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install fedora-workstation-repositories
sudo fedora-third-party enable
sudo fedora-third-party refresh
sudo dnf -y groupupdate core
sudo dnf -y config-manager --set-enabled google-chrome

# cleanup
sudo dnf clean all
sudo dnf -y autoremove
sudo dnf -y distro-sync


# install media codecs
sudo dnf install -y --skip-broken @multimedia
sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin --skip-broken
sudo dnf -y groupupdate sound-and-video
sudo dnf -y install ffmpeg
sudo dnf -y install libwebp libwebp-devel
sudo dnf -y install webp-pixbuf-loader


# add flatpak
sudo dnf -y install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update -y --noninteractive

# install snap
sudo dnf -y install snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl enable snapd --now
sudo snap refresh #fix: not seeded yet will trigger and fix itself for the next command
sudo snap install core
sudo snap refresh core
sudo snap refresh

# cleanup
sudo dnf clean all
sudo dnf -y autoremove
sudo dnf -y distro-sync

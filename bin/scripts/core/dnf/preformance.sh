#!/bin/bash

dir="$1"

# install preload
dnf -y copr enable elxreno/preload
dnf -y install preload
systemctl enable preload --now

# install tlp
dnf -y install tlp tlp-rdw
systemctl enable tlp --now
sudo tlp start

# install thermald
dnf -y install thermald
systemctl enable thermald --now

# disable time wasting startup programs
systemctl disable NetworkManager-wait-online.service
systemctl disable accounts-daemon.service
systemctl disable debug-shell.service
systemctl disable nfs-client.target
systemctl disable remote-fs.target

dnf -y --noautoremove remove dmraid device-mapper-multipath

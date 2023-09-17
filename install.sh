#!/bin/bash

cd $(dirname "$0")
dir="$PWD"

sudo echo


#todo: verify checksums for script files based on github repo
# verify checksums
# gitSum=$(curl --silent "https://raw.githubusercontent.com/AspieSoft/Empoleos/master/install.sh" | sha256sum | sed -E 's/([a-zA-Z0-9]+).*$/\1/')
# sum=$(cat "install.sh" | sha256sum | sed -E 's/([a-zA-Z0-9]+).*$/\1/')
# if ! [ "$sum" = "$gitSum" ]; then
#   echo "error: checksum failed!"
#   exit
# fi


# get package manager
if [ "$(which apt)" != "" ] &>/dev/null; then
  PackageManager="apt"
elif [ "$(which dnf)" != "" ] &>/dev/null; then
  PackageManager="dnf"
elif [ "$(which rpm-ostree)" != "" ] &>/dev/null; then
  PackageManager="rpm-ostree"
  echo "rpm-ostree is not supported yet!"
  echo "this feature may be available in the future!"
  exit
else
  echo "Error: Package Manager Unsupported"
  echo "Package Manager must be one of the following:"
  echo "apt | dnf"
  exit
fi

if [ "$1" = "server" -o "$1" = "s" ]; then
  InstallType="server"
elif [ "$1" = "gnome" -o "$1" = "desktop" -o "$1" = "g" -o "$1" = "d" ]; then
  InstallType="gnome"
elif [ "$1" = "xfce" -o "$1" = "min-desktop" -o "$1" = "min" -o "$1" = "x" -o "$1" = "m" ]; then
  InstallType="xfce"
else
  echo "./install.sh [server|desktop type]"
  echo
  echo "server: server | s"
  echo "desktop (gnome): gnome | disktop | g | d"
  echo "desktop (xfce): xfce | min-desktop | min | x | m"
  echo
  exit
fi

echo "Starting Install..."

source "$dir/bin/scripts/core/setup.sh" "$dir" "$InstallType" "$PackageManager"

# cleanup
if [ "$PackageManager" = "apt" ]; then
  sudo apt -y update
  sudo apt -y autoremove
  sudo apt -y autoclean
elif [ "$PackageManager" = "dnf" ]; then
  sudo dnf clean all
  sudo dnf -y autoremove
  sudo dnf -y distro-sync
elif [ "$PackageManager" = "rpm-ostree" ]; then
  #todo: figure out what rpm-ostree ceanup commands are
  echo "not yet available"
fi

echo "Install Finished!"

# reboot system
if [ "$InstallType" != "server" ]; then
  sudo systemctl reboot
fi

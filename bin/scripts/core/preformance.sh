#!/bin/bash

dir="$1"
PackageManager="$2"
InstallType="$3"

source "$dir/bin/scripts/core/$PackageManager/preformance.sh" "$dir" "$InstallType"

# change grup timeout
sudo sed -r -i 's/^GRUB_TIMEOUT=(.*)$/GRUB_TIMEOUT=0/m' /etc/default/grub
sudo update-grub
sudo grub2-editenv - set menu_auto_hide=1
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
sudo grub2-mkconfig -o /etc/grub2.cfg

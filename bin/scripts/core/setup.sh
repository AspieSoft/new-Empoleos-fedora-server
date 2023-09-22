#!/bin/bash

dir="$1"
InstallType="$2"
PackageManager="$3"


# move and link directories
# this allows some root directories to be moved within the btrfs partition, instead of the xfs partition
if [ "$(readlink -f /home)" = "/home" ]; then
  mv /home /var/home
  ln -s /var/home /home
fi

if [ "$(readlink -f /root)" = "/root" ]; then
  mv /root /var/roothome
  ln -s /var/roothome /root
fi

if [ "$(readlink -f /usr/share)" = "/usr/share" ]; then
  mv /usr/share /var/usrshare
  ln -s /var/usrshare /usr/share
fi


# optimize package manager
source "$dir/bin/scripts/core/$PackageManager/repos.sh" "$dir" "$InstallType"
source "$dir/bin/scripts/core/$PackageManager/setup.sh" "$dir" "$InstallType"


# install shortcuts
if ! [ -f "/etc/profile.d/empoleos.sh" ]; then
  sudo cp "$dir/bin/assets/empoleos-shortcuts.$PackageManager.sh" "/etc/profile.d/empoleos.sh"
fi

# run install scripts
source "$dir/bin/scripts/core/preformance.sh" "$dir" "$PackageManager" "$InstallType"
source "$dir/bin/scripts/core/$PackageManager/fix.sh" "$dir" "$InstallType"
source "$dir/bin/scripts/core/$PackageManager/langs.sh" "$dir"
source "$dir/bin/scripts/core/$PackageManager/security.sh" "$dir"

if [ "$InstallType" != "server" ]; then
  source "$dir/bin/scripts/core/$PackageManager/apps.sh" "$dir"

  # install optional
  #todo: make optional
  source "$dir/bin/scripts/apps/wine.$PackageManager.sh" "$dir"
  source "$dir/bin/scripts/apps/developer.$PackageManager.sh" "$dir"
  source "$dir/bin/scripts/apps/office.sh" "$dir" "$PackageManager"
fi

source "$dir/bin/scripts/dist/$InstallType/setup.sh" "$dir" "$PackageManager"

if [ "$InstallType" != "server" ]; then
  source "$dir/bin/scripts/core/desktop-security.sh" "$dir"

  # install theme files
  sudo tar -xzf "$dir/bin/theme/themes.tar.gz" -C "usr/share/themes"
  sudo tar -xzf "$dir/bin/theme/icons.tar.gz" -C "usr/share/icons"
  sudo tar -xzf "$dir/bin/theme/sounds.tar.gz" -C "usr/share/sounds"
  sudo tar -xzf "$dir/bin/theme/backgrounds.tar.gz" -C "usr/share/backgrounds"
fi


source "$dir/bin/scripts/core/system.sh" "$dir"


# install auto updates
sudo cp -rf "$dir/bin/assets/empoleos" "/etc"
sudo rm -f "/etc/empoleos/empoleos.service"
sudo cp -f "$dir/bin/assets/empoleos/empoleos.service" "/etc/systemd/system"
gitVer="$(curl --silent 'https://api.github.com/repos/AspieSoft/Empoleos/releases/latest' | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/')"
echo "$gitVer" | sudo tee "/etc/empoleos/version.txt"
sudo sed -r -i "s/^InstallType=\".*\"$/InstallType=\"$InstallType\"/m" "/etc/empoleos/update.sh"
sudo sed -r -i "s/^InstallType=\".*\"$/InstallType=\"$InstallType\"/m" "/etc/empoleos/backup.sh"

sudo systemctl daemon-reload
sudo systemctl enable empoleos.service --now

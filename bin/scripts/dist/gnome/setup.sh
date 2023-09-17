#!/bin/bash

dir="$1"
PackageManager="$2"

source "$dir/bin/scripts/dist/gnome/desktop.$PackageManager.sh" "$dir"

# install jetbrains font
FONT_VERSION=$(curl -s "https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -sSLo jetbrains-mono.zip https://download.jetbrains.com/fonts/JetBrainsMono-$FONT_VERSION.zip
unzip -qq jetbrains-mono.zip -d jetbrains-mono
sudo mkdir /usr/share/fonts/truetype/jetbrains-mono
sudo mv jetbrains-mono/fonts/ttf/*.ttf /usr/share/fonts/truetype/jetbrains-mono
rm -rf jetbrains-mono.zip jetbrains-mono

# config
sudo update-alternatives --config gdm3-theme.gresource

# setup gdm config
sudo sed -r -i 's/^#WaylandEnable=(.*)$/WaylandEnable=true/m' "/etc/gdm/custom.conf"

# enable gdm
if [ "$PackageManager" = "apt" ]; then
  if ! [ "$(cat /etc/os-release | grep '^NAME="Zorin OS"' 2>/dev/null)" != "" ]; then
    sudo systemctl set-default graphical.target
    sudo systemctl enable gdm3
  fi
else
  sudo systemctl set-default graphical.target
  sudo systemctl enable gdm
fi


# install apps and extensions
source "$dir/bin/scripts/dist/gnome/apps.$PackageManager.sh" "$dir"

sudo pip3 install --upgrade git+https://github.com/essembeh/gnome-extensions-cli

# config gnome
source "$dir/bin/scripts/dist/gnome/theme/config.sh" "$dir"

source "$dir/bin/scripts/dist/gnome/theme/core-ext.sh" "$dir"
source "$dir/bin/scripts/dist/gnome/theme/core-ext-config.sh" "$dir"

# move gnome core extensions to root
sudo mv $HOME/.local/share/gnome-shell/extensions/* /usr/share/gnome-shell/extensions
for file in $(ls /usr/share/gnome-shell/extensions); do
  sudo chown -R root:root "/usr/share/gnome-shell/extensions/$file"
done

source "$dir/bin/scripts/dist/gnome/theme/user-ext.sh" "$dir"
source "$dir/bin/scripts/dist/gnome/theme/user-ext-config.sh" "$dir"

source "$dir/bin/scripts/dist/gnome/fix-keyboard-shortcuts.sh" "$dir"

# copy extension settings for new users
sudo mkdir -p "/etc/skel/.local/share/gnome-shell/extensions"
sudo mkdir -p "/etc/skel/.config"
sudo cp -rf "$HOME/.local/share/gnome-shell/extensions" "/etc/skel/.local/share/gnome-shell/extensions"
sudo cp -rf "$HOME/.config/burn-my-windows" "/etc/skel/.config"

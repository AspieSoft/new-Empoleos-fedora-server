#!/bin/bash

dir="$1"

sudo dnf -y install nemo
sudo dnf -y install nemo-fileroller
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

if test -d "/usr/share/applications"; then
  sudo sed -r -i 's/^OnlyShowIn=/#OnlyShowIn=/m' "/usr/share/applications/nemo.desktop"
  sudo sed -r -i 's#^inode/directory=(.*)$#inode/directory=nemo.desktop#m' "/usr/share/applications/gnome-mimeapps.list"
  git clone https://github.com/AspieSoft/linux-nemo-fix.git && ./linux-nemo-fix/install.sh
fi

sudo flatpak -y install flathub com.github.tchx84.Flatseal
sudo dnf -y install dconf-editor
sudo dnf -y install gparted
# sudo flatpak -y install flathub org.fedoraproject.MediaWriter
sudo dnf -y install liveusb-creator


# install text editor
sudo dnf -y install gnome-text-editor

# install photo viewer
sudo dnf -y install shotwell

# install music player
sudo dnf -y install rhythmbox # may be able to add an extension
# plugin did not seem to make any difference
# dnf copr enable mochaa/rhythmbox-alternative-toolbar
# sudo dnf -y install rhythmbox-alternative-toolbar

# install video player
sudo dnf -y install celluloid

# install calendar
sudo dnf -y install gnome-calendar

# install browser
#todo: add option of browser choice
sudo dnf -y install google-chrome-stable
# sudo dnf -y install chromium
# sudo dnf -y install firefox

#todo: find alternative webcam app with better quality (OBS studio can also handle webcams with much better quality)
# install webcam app
# sudo flatpak -y install flathub org.gnome.Snapshot # may be under development and so far bad quality on my laptop


# install common tools
sudo dnf -y install blender
sudo dnf -y install gimp
sudo dnf -y install pinta
sudo dnf -y install video-downloader
sudo dnf -y install audacity
sudo dnf -y install nm-connection-editor
sudo dnf -y install obs-studio
sudo dnf -y install shotcut

# install other important apps
sudo dnf -y install gnome-system-monitor
sudo dnf -y install gnome-characters
sudo dnf -y install gnome-calculator
sudo dnf -y install gnome-clocks
sudo dnf -y install gnome-connections
sudo dnf -y install gnome-contacts
sudo dnf -y install evince # document viewer
sudo dnf -y install simple-scan # document scanner
sudo dnf -y install gnome-font-viewer
sudo dnf -y install gnome-logs
sudo dnf -y install gnome-screenshot

sudo dnf -y install gnome-maps
sudo dnf -y install gnome-weather

sudo dnf -y install gnome-power-manager


# install steam
sudo dnf -y module disable nodejs
sudo dnf -y install steam
sudo dnf -y module install -y --allowerasing nodejs:16/development

# hide steam folder
if ! grep -q "Steam" "$HOME/.hidden" ; then
  echo "Steam" | sudo tee -a "$HOME/.hidden"
fi
if ! grep -q "Steam" "/etc/skel/.hidden" ; then
  echo "Steam" | sudo tee -a "/etc/skel/.hidden"
fi

#todo: will need to add a script to run when new users are created, to automatically create a user specific steam folder in the "/games" directory
# may use symlinks to make steam games always use "/games" folder by default

# ensure root games directory exists
if ! test -d "/games"; then
  sudo mkdir "/games"
fi

# add games folder for user
sudo mkdir "/games/$USER"
sudo chown "$USER:$USER" "/games/$USER"
sudo chmod -R 700 "/games/$USER"
sudo ln -s /games/$USER "$HOME/.games"

# link steam dirs to .games
mkdir "$HOME/.games/Steam"

function linkSteamDir {
  if ! test -d "$HOME/.local/share/Steam/$1"; then
    mkdir -p "$HOME/.local/share/Steam/$1"
  fi
  mv "$HOME/.local/share/Steam/$1" "$HOME/.games/Steam/$1"
  ln -s "$HOME/.games/Steam/$1" "$HOME/.local/share/Steam/$1"
}

linkSteamDir "steamapps"
linkSteamDir "steam"
linkSteamDir "servers"
linkSteamDir "appcache"
linkSteamDir "depotcache"
linkSteamDir "package"
linkSteamDir "linux64"
linkSteamDir "linux32"
linkSteamDir "ubuntu12_64"
linkSteamDir "ubuntu12_32"
linkSteamDir "legacycompat"
linkSteamDir "graphics"

# sudo cp "$dir/bin/assets/adduser.local" "/usr/local/sbin"


#todo: consider adding
# sudo dnf install lite-xl

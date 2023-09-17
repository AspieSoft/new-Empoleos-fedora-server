#!/bin/bash

if ! test -d "/games/$USER" && ! test -d "$HOME/.games"; then
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
fi

#!/bin/bash

#todo: add functions to detect apt, flatpak, and snap install and remove commands for backups

# optional useful functions
function update {
  sudo apt -y update
  sudo apt -y upgrade
  sudo bash /etc/empoleos/update.sh
  sudo apt autoremove
}

function backup {
  update
  sudo bash /etc/empoleos/backup.sh
}

function avscan {
  local scanDir="$1"
  if [ "$scanDir" = "" ]; then
    scanDir="$HOME"
  fi
  sudo nice -n 15 clamscan -r --bell --move="/VirusScan/quarantine" --exclude-dir="/VirusScan/quarantine" --exclude-dir="/home/$USER/.clamtk/viruses" --exclude-dir="smb4k" --exclude-dir="/run/user/$USER/gvfs" --exclude-dir="/home/$USER/.gvfs" --exclude-dir=".thunderbird" --exclude-dir=".mozilla-thunderbird" --exclude-dir=".evolution" --exclude-dir="Mail" --exclude-dir="kmail" --exclude-dir="^/sys" "$scanDir"
}

function mvlink {
  mv "$1" "$2"
  ln -s "$2" "$1"
}

function go {
  local flagS="-1"
  local flagA="0"
  local cmd=""
  for flag in $@; do
    if [ "$flag" = "-s" ]; then
      flagS="0"
    elif [ "$flag" = "-S" ]; then
      flagS="1"
    elif [ "$flag" = "-A" ]; then
      flagA="1"
    else
      cmd="$cmd $flag"
    fi
  done

  if [ "$1" = "build" -a "$flagS" != "-1" -a "$flagA" = "1" ]; then
    mkdir "go-dist"
    CGO_ENABLED="$flagS" command go $cmd -o "go-dist/default"
    CGO_ENABLED="$flagS" GOOS="linux" GOARCH="amd64" command go $cmd -o "go-dist/linux.amd64"
    CGO_ENABLED="$flagS" GOOS="linux" GOARCH="arm64" command go $cmd -o "go-dist/linux.arm64"
    CGO_ENABLED="$flagS" GOOS="linux" GOARCH="arm" command go $cmd -o "go-dist/linux.arm"
    CGO_ENABLED="$flagS" GOOS="windows" GOARCH="amd64" command go $cmd -o "go-dist/windows.amd64.exe"
    CGO_ENABLED="$flagS" GOOS="windows" GOARCH="386" command go $cmd -o "go-dist/windows.386.exe"
    CGO_ENABLED="$flagS" GOOS="android" GOARCH="arm64" command go $cmd -o "go-dist/android.arm64"
    CGO_ENABLED="$flagS" GOOS="ios" GOARCH="arm64" command go $cmd -o "go-dist/ios.arm64"
    CGO_ENABLED="$flagS" GOOS="js" GOARCH="wasm" command go $cmd -o "go-dist/js.wasm"
  elif [ "$1" = "build" -a "$flagS" != "-1" ]; then
    CGO_ENABLED="$flagS" command go $cmd
  elif [ "$1" = "build" -a "$flagA" = "1" ]; then
    mkdir "go-dist"
    command go $cmd -o "go-dist/default"
    GOOS="linux" GOARCH="amd64" command go $cmd -o "go-dist/linux.amd64"
    GOOS="linux" GOARCH="arm64" command go $cmd -o "go-dist/linux.arm64"
    GOOS="linux" GOARCH="arm" command go $cmd -o "go-dist/linux.arm"
    GOOS="windows" GOARCH="amd64" command go $cmd -o "go-dist/windows.amd64.exe"
    GOOS="windows" GOARCH="386" command go $cmd -o "go-dist/windows.386.exe"
    GOOS="android" GOARCH="arm64" command go $cmd -o "go-dist/android.arm64"
    GOOS="ios" GOARCH="arm64" command go $cmd -o "go-dist/ios.arm64"
    GOOS="js" GOARCH="wasm" command go $cmd -o "go-dist/js.wasm"
  elif [ "$1" = "help" -a "$2" = "build" ]; then
    command go $@
    echo "-----"
    echo "empoleos mod"
    echo "-s  set CGO_ENABLED=0 for an independent binary"
    echo "-S  set CGO_ENABLED=1 for an independent binary"
    echo "-A  generate a binary for a large number of devices"
  else
    command go $@
  fi
}

#!/bin/bash

dir="$1"
PackageManager="$2"

if [ "$(which "libreoffice" 2>/dev/null)" = "" ]; then
  sudo snap install libreoffice
fi

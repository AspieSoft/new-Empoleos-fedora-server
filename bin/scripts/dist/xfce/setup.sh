#!/bin/bash

dir="$1"
PackageManager="$3"

source "$dir/bin/scripts/dist/xfce/desktop.$PackageManager.sh" "$dir"

#todo: setup and enable desktop environment

# install apps and extensions
source "$dir/bin/scripts/dist/xfce/apps.$PackageManager.sh" "$dir"

source "$dir/bin/scripts/dist/xfce/theme/apps.$PackageManager.sh" "$dir"

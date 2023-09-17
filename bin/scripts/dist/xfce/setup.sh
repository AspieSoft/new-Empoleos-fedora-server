#!/bin/bash

dir="$1"
PackageManager="$3"

source "$dir/bin/scripts/dist/xfce/desktop.$PackageManager.sh" "$dir"

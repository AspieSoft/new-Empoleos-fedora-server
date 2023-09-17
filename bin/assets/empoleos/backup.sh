#!/bin/bash

cd $(dirname "$0")
dir="$PWD"

InstallType=""

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


echo "cloud backups are not yet available. maybe this feature will be available in the future..."
exit 1


# wait for wifi (timeout=5min)
tries=0
while [ "$(ping -c1 www.google.com 2>/dev/null)" == "" ]; do
  if [ "$tries" -gt "30" ]; then
    echo "error: failed to connect to wifi"
    exit
  fi

  tries=$((tries+1))
  echo "waiting for wifi..."
  sleep 10
done

sleep 1

echo "starting backup for empoleos..."

# todo: create a cloud backup system with app installs included
# also remember to include encrypted home folder (without steam games and large temp files)
# also remember to run for multiple users, and use their personal cloud for backups (will need a file in the user directory containing info for this cloud backup)
# will also need to disable read permission for other users with the encrypt key for backups (may restrict reading to root user)


echo "error: empoleos backups are not yet supported!"

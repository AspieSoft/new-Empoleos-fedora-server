#!/bin/bash

dir="$1"
InstallType="$2"
PackageManager="$3"


# set bash profile $PS1
if ! [ -f "etc/profile.d/bash_ps.sh" ]; then
  echo 'if [ "$PS1" ]; then' | sudo tee -a "etc/profile.d/bash_ps.sh" &>/dev/null
  echo '  PS1="\[\e[m\][\[\e[1;32m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]]\[\e[0;31m\](\$?)\[\e[1;0m\]\\$ \[\e[m\]"' | sudo tee -a "etc/profile.d/bash_ps.sh" &>/dev/null
  echo 'fi' | sudo tee -a "etc/profile.d/bash_ps.sh" &>/dev/null
fi


if [ "$(grep "^hostname=" /etc/conf.d/hostname)" != "" ]; then
  sed -r -i 's/^hostname=".*"$/hostname="empoleos"/m' /etc/conf.d/hostname
else
  echo 'hostname="empoleos"' >> /etc/conf.d/hostname
fi

sed -r -i 's/^(127\.0\.0\.1|::1)(\s*)localhost$/\1\2empoleos localhost/m' /etc/hosts

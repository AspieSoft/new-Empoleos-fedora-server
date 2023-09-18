#!/bin/bash

dir="$1"
InstallType="$2"
PackageManager="$3"


# set bash profile $PS1
if ! [ -f "/etc/profile.d/bash_ps.sh" ]; then
  echo 'if [ "$PS1" ]; then' >> /etc/profile.d/bash_ps.sh &>/dev/null
  echo '  PS1="\[\e[m\][\[\e[1;32m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]]\[\e[0;31m\](\$?)\[\e[1;0m\]\\$ \[\e[m\]"' >> /etc/profile.d/bash_ps.sh &>/dev/null
  echo 'fi' >> /etc/profile.d/bash_ps.sh &>/dev/null
  echo '' >> /etc/profile.d/bash_ps.sh &>/dev/null
  echo 'if [ "$EUID" = "0" -a "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/. 2>/dev/null)" ]; then' >> /etc/profile.d/bash_ps.sh &>/dev/null
  echo '  PS1="\[\e[1;35m\](chroot)\[\e[m\]${PS1}"' >> /etc/profile.d/bash_ps.sh &>/dev/null
  echo 'fi' >> /etc/profile.d/bash_ps.sh &>/dev/null
fi

# set hostname
echo 'empoleos' > /etc/hostname
hostname empoleos

sed -r -i 's/^(127\.0\.0\.1|::1)(\s*)localhost(.*)$/\1\2empoleos localhost\3/m' /etc/hosts

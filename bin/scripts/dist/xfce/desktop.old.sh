#!/bin/bash


#*New XFCE Install


dnf -y install @base-x
dnf -y install xorg-x11-server-Xorg xorg-x11-xinit xorg-x11-drv-libinput mesa-dri-drivers
dnf -y install xfce4-panel xfce4-session xfce4-settings xfconf xfdesktop xfwm4
dnf -y install @multimedia
dnf -y install @networkmanager-submodules


#?OLD



dnf -y install xfwm4


dnf -y install xfce4-session


#!OLD



# setup sddm (login manager / display manager)
dnf -y install sddm
systemctl enable sddm

# install dwm (window manager / display server)
# https://gitlab.com/-/snippets/2048501
dnf -y install libX11-devel libXft-devel libXinerama-devel libXrandr-devel xorg-x11-xinit-session
dnf -y install feh xautolock


mkdir dwm
cd dwm

git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/slock
git clone https://git.suckless.org/slstatus
git clone https://git.suckless.org/st

for file in $(ls); do
  cd "./$file"
  make clean
  make
  make install
  make clean
  cd ..
done

cd ..
rm -rf dwm


#todo: may need to run this at the end of the install
systemctl set-default graphical.target


# install xfce
dnf -y install xfce4

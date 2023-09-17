# Empoleos

## Notice: this script is still in beta. Use at your own risk

## Installation

First you will need to install [Fedora Server](https://fedoraproject.org/server/download/) or another fedora cli based on dnf.
Fedora Server is used for both the Desktop GUI and Server CLI.

After booting into the server cli, run one of the following scripts.

```shell
sudo dnf -y install git || sudo apt -y install git

git clone https://github.com/AspieSoft/Empoleos.git
```

### For Desktop GUI

```shell
Empoleos/install.sh gnome
```

### For Minimal Desktop GUI

```shell
Empoleos/install.sh xfce
```

### For Server CLI

```shell
Empoleos/install.sh server
```

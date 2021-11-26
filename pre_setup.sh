#!/bin/bash

# dependency installation, which must be run as root!

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

apt --version > /dev/null
if [[ $? != 0 ]]
    then echo "this script uses the apt package manager, but it is not installed on your system"
    exit 1
fi

apt-get install -y neovim zsh fzf fd-find screen mutt irssi

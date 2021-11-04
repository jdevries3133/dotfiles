#!/bin/bash

# WARNING: this script is currently untetsed; see how it goes next time we
# need to move to a new system.

# this script will only work on the following platforms:
# - macOS
# - linux with the apt package manager

if [ "$EUID" -eq 0 ]
  then echo "Do not run this script as root"
  exit 1
fi

exit 0

PYTHON_VERSION=3.9.6
NODE_VERSION="--lts"

# order matters for some of these, so the sequence is listed explicitly
[[ $OSTYPE == "darwin"* ]] && bash setup_scripts/install_homebrew.sh
bash setup_scripts/git.sh
bash setup_scripts/pyenv.sh $PYTHON_VERSION
bash setup_scripts/nvm.sh $NODE_VERSION
bash setup_scripts/zsh_setup.sh
bash setup_scripts/vim.sh
bash setup_scripts/mutt.sh
bash setup_scripts/irssi.sh
bash setup_scripts/screen.sh

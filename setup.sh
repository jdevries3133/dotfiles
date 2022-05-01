#!/bin/bash

# WARNING: this script is currently untested; see how it goes next time we
# need to move to a new system.

# this script will only work on the following platforms:
# - macOS
# - debian linux (with the apt package manager)

if [ "$EUID" -eq 0 ]
  then echo "Do not run this script as root"
  exit 1
fi

# order matters for some of these, so the sequence is listed explicitly
[[ $OSTYPE == "darwin"* ]] && bash setup_scripts/install_homebrew.sh
bash setup_scripts/git.sh
bash setup_scripts/zsh_setup.sh
bash setup_scripts/vim.sh

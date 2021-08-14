#!/bin/bash

# WARNING: this script is currently untetsed; see how it goes next time we
# need to move to a new system.

# this script will only work on the following platforms:
# - macOS
# - linux with the apt package manager

PYTHON_VERSION=3.9.6
NODE_VERSION="--lts"

[[ $OSTYPE == "darwin"* ]] && bash setup_scripts/install_homebrew.sh
bash setup_scripts/make_symlinks.sh
bash setup_scripts/pyenv.sh $PYTHON_VERSION
bash setup_scripts/nvm.sh $NODE_VERSION
bash setup_scripts/zsh_setup.sh
bash setup_scripts/vim.sh

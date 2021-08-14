#!/bin/bash

# --- make symlinks ---

REPO=$(pwd)
ln -s $REPO/zshrc $HOME/.zshrc
ln -s $REPO/vim $HOME/.vim
mkdir -p $HOME/.config
ln -s $REPO/nvim $HOME/.config/nvim
ln -s $REPO/gitconfig $HOME/.gitconfig

#!/bin/bash

# install vim plug and vim/nvim packages


# vim
# ===

# symlink config
ln -s $(pwd)/vim $HOME/.vim
echo "source $HOME/.vim/vimrc" > $HOME/.vimrc

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install plugins via vim-plug
vim -c 'PlugInstall'


# neovim
# =====

# symlink config
mkdir -p $HOME/.config
ln -s $(pwd)/nvim $HOME/.config/nvim

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# install plugins via vim-plug
nvim -c 'PlugInstall'

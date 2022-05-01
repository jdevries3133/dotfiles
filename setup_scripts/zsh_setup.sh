#!/bin/bash

# symlink zshrc
ln -s $(pwd)/zshrc $HOME/.zshrc

# zsh
command -v zsh --version
if [[ $? -ne 0 ]] ; then
    sudo apt-get install -y zsh
fi

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#!/bin/bash

# symlink zshrc
ln -s $(pwd)/zshrc $HOME/.zshrc

# zsh
command -v zsh --version
if [[ $? -ne 0 ]] ; then
    sudo apt-get install -y zsh
    [[ $? -ne 0 ]] && \
        echo "Error: cannot install zsh. Does this system have a package manager other than apt?" && \
        exit 1
fi


# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

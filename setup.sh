#!/bin/bash

# WARNING: this script is currently untetsed; see how it goes next time we
# need to move to a new system

PYTHON_VERSION=3.9.6
NODE_VERSION="--lts"

# --- setup dependencies ---
if [[ $OSTYPE == "darwin"* ]] ; then
    # install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    INSTALL_PACKAGE="brew install"
else
    INSTALL_PACKAGE="sudo apt-get install -y"
    is_linux=true
fi

# --- make symlinks ---
REPO=$(pwd)
ln -s $REPO/zshrc $HOME/.zshrc
ln -s $REPO/vim $HOME/.vim
mkdir -p $HOME/.config
ln -s $REPO/nvim $HOME/.config/nvim


# --- install pyenv and nvm ---
curl https://pyenv.run | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh | bash
# Add pyenv executable to PATH and enable shims
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Load pyenv into the shell
eval "$(pyenv init -)"

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

nvm install $NODE_VERSION
nvm use $NODE_VERSION


# --- zsh and oh-my-zsh ---
if [[ is_linux ]] ; then
    $INSTALL_PACKAGE zsh
fi
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# --- install vim plug and vim/nvim packages ---
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
vim -c 'PlugInstall'
nvim -c 'PlugInstall'

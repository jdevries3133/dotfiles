#!/bin/bash

# setup homebrew (mac only), git, and zsh for unix-like systems


install_warning() {
    which $1 > /dev/null
    if [[ $? != 0 ]]; then
        echo "warning: $1 must be installed"
    fi
}


if [ "$EUID" -eq 0 ]
  then echo "Do not run this script as root"
  exit 1
fi


# homebrew
if [[ $OSTYPE == "darwin"* ]]; then
    # install homebrew
    echo "note: homebrew installation will request sudo access"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# git
ln -s $PWD/gitconfig $HOME/.gitconfig
mkdir -p $HOME/.config/git
ln -s $PWD/gitexcludes $HOME/.config/git/ignore


# zsh
ln -s $PWD/zshrc $HOME/.zshrc
ln -s $PWD/zshenv $HOME/.zshenv

which zsh > /dev/null
if [[ $? != 0 ]] ; then
    echo "warning: zsh must be installed"
    echo "re-run the setup script to install oh-my-zsh after installing zsh"
else
    # install oh-my-zsh if zsh is already installed
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# tmux
install_warning tmux
ln -s $PWD/tmux.conf $HOME/.tmux.conf


# mutt
install_warning mutt

mkdir -p $HOME/.mutt
ln -s $PWD/muttrc $HOME/.muttrc
ln -s $PWD/mutt_view_attachment.sh $HOME/.mutt/view_attachment.sh
ln -s $PWD/mailcap $HOME/.mailcap
echo "Thanks!
Jack DeVries" >> $HOME/.mutt/signature_personal

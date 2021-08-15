#!/bin/bash

# setup git by symlinking gitconfig and gitexcludes

REPO=$(pwd)

ln -s $REPO/gitconfig $HOME/.gitconfig
mkdir -p $HOME/.config/git
ln -s $REPO/gitexcludes $HOME/.config/git/ignore

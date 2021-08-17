#!/bin/bash

# apply configuration for irssi chat client

config_target=$HOME/.irssi/config

mkdir -p $HOME/.irssi
cp $(pwd)/irssi_config $config_target

echo "Enter your nick password for jack__d on LiberaChat"
read pw

# different sed implementations on OS X vs Linux :|
if [[ $OSTYPE == "darwin"* ]] ; then
    sed -i '' -e "s/{{{ password }}}/$pw/g" "$config_target"
else
    sed -i "s/{{{ password }}}/$pw/g" "$config_target"
fi

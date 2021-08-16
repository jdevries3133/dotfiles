#!/bin/bash

# just make symlinks to conf files.

mkdir $HOME/.mutt

ln -s $(pwd)/mutt/muttrc $HOME/.muttrc
ln -s $(pwd)/mutt/view_attachment.sh $HOME/.mutt/view_attachment.sh
ln -s $(pwd)/mutt/mailcap $HOME/.mailcap

vim $(pwd)/mutt/example_client_config

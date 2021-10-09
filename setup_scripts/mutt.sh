#!/bin/bash

# just make symlinks to conf files.

mkdir -p $HOME/.mutt

ln -s $(pwd)/muttrc $HOME/.muttrc
ln -s $(pwd)/mutt_view_attachment.sh $HOME/.mutt/view_attachment.sh
ln -s $(pwd)/mailcap $HOME/.mailcap

echo "Thanks!\nJack DeVries" >> $HOME/.mutt/signature_personal
echo "

vim $(pwd)/mutt_example_client_config

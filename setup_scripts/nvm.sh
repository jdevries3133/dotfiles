#!/bin/bash

# setup node version manager (nvm)

NODE_VERSION=$1

curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh -o install_nvm.sh | bash


# this is already in our .zshrc, we just need to set it here so that the next
# two commands will work.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install $NODE_VERSION
nvm use $NODE_VERSION

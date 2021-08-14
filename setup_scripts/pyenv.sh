#!/bin/bash

# setup pyenv

PYTHON_VERSION=$1

curl https://pyenv.run | bash
# Add pyenv executable to PATH and enable shims
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Load pyenv into the shell
eval "$(pyenv init -)"

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

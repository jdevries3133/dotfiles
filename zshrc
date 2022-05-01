# -------------------------- INITIALIZATION -------------------------

# homebrew
if [[ $OSTYPE == "darwin"* ]] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# pyenv
if [[ -d $HOME/.pyenv ]] ; then
    # Add pyenv executable to PATH and enable shims
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/versions/3.9.6/bin:$PATH"
    eval "$(pyenv init --path)"
    # Load pyenv into the shell
    eval "$(pyenv init -)"
fi


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# -------------------------- PREFERENCES & SHORTCUTS ----------------

alias dl="youtube-dl -x"

export EDITOR="nvim"
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export KUBE_CONFIG_PATH=$HOME/.kube/config

if [[ -f .env ]] then
    source ~/.env
fi

# generic push notes to GitHub
alias notes="pushd $HOME/notes; git add -A && git commit -m "." && git push > /dev/null; popd"

# venv-related aliases
VENV_NAME="venv"
alias vnv="python3.10 -m venv $VENV_NAME \
    && source $VENV_NAME/bin/activate \
    && pip install --upgrade pip"
alias vnvr="vnv && pip install -r requirements.txt"
alias act="source $VENV_NAME/bin/activate"

# screen
alias ss="screen -d -r" # screen session
alias sn="screen -S"    # screen new (session)
alias sl="screen -ls"

# terraform
alias tf="terraform"

# misc
alias nt="nvim -c \"terminal\""
alias temp="cd $(mktemp -d)"

# git
alias ggg="nvim ~/.oh-my-zsh/plugins/git/README.md"
alias gsur="git submodule update --remote --merge"

# bat
which bat > /dev/null
if [[ $? -eq 0 ]] then
    alias cat="bat"
fi

# kubectl
alias kubeall="kubectl get all --all-namespaces"
alias k="kubectl"

# docker
alias d="docker"
alias de="docker exec"
alias dei="docker exec -it"
alias dl="docker logs"
alias dp="docker ps"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcb="docker-compose build"
alias dcl="docker-compose logs"

# GNU Make
alias m="make"

# make fzf index hidden directories
export FZF_DEFAULT_COMMAND='fd --type f -H'


#####################################################################
############################   macOS   ##############################
############################   only    ##############################
if [[ $OSTYPE == "darwin"* ]] ; then
#####################################################################

nvm use --lts > /dev/null

export XDG_CONFIG_HOME=$HOME/.config


# -------------------------- TEACHER HELPER -------------------------------

export HELPER_DATA="$HOME/.teacherhelper"

# -------------------------- HOMEBREW PACKAGES --------------------------------

# openssl
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"


# autoconf 
export PATH="/opt/homebrew/opt/autoconf@2.69/bin:$PATH"

# postgres
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"


# llvm
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/llvm/include"

# mysql-client
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"



# -------------------------- PYTHON ---------------------------------

export PATH=$PATH:/Users/johndevries/Library/Python/3.8/bin


# -------------------------- DJANGO ---------------------------------

export DJANGO_DEBUG=1

# -------------------------- MACOS STUPIDITY ------------------------

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"


#####################################################################
fi  # macOS only ####################################################
#####################################################################


# -------------------------- NVM ------------------------------------



# -------------------------- OH-MY-ZSH ------------------------------

# Make zsh path act like bash path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"

# automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# add a cloud to the prompt when I am not on my own machine
if [[ $USER != 'johndevries' ]] ; then
    export PROMPT="☁️  $PROMPT"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

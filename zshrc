# -------------------------- PREFERENCES & SHORTCUTS ----------------

export EDITOR="nvim"
export PATH=$PATH:/Users/johndevries/bin

# venv-related aliases
VENV_NAME="venv"
alias vnv="python3 -m venv $VENV_NAME \
    && source $VENV_NAME/bin/activate \
    && pip install --upgrade pip"
alias vnvr="vnv && pip install -r requirements.txt"
alias act="source $VENV_NAME/bin/activate"

# screen
alias ss="screen -d -r" # screen session
alias sn="screen -S"    # screen new (session)
alias sl="screen -ls"

# misc
alias nt="nvim -c \"terminal\""
alias temp="cd $(mktemp -d)"

# git
alias ggg="nvim ~/.oh-my-zsh/plugins/git/README.md"
alias gsur"git submodule update --remote --merge"



#####################################################################
############################   macOS   ##############################
############################   only    ##############################
#####################################################################
if [[ $OSTYPE == "darwin"* ]] ; then


# -------------------------- HOMEBREW -------------------------------

eval "$(/opt/homebrew/bin/brew shellenv)"


# -------------------------- OPENSSL --------------------------------

export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"


# -------------------------- AUTOCONF -------------------------------

export PATH="/opt/homebrew/opt/autoconf@2.69/bin:$PATH"

# -------------------------- LIBGMP ---------------------------------
# (gdb build dependency)

export LDFLAGS="$LDFLAGS -L/opt/homebrew/Cellar/gmp/6.2.1/lib"


# -------------------------- MACOS STUPIDITY ------------------------

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"


#####################################################################
fi  # macOS only ####################################################
#####################################################################


# -------------------------- NVM ------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# -------------------------- PYENV ----------------------------------

# on ubuntu, I don't always use pyenv because of the whole apt-python
# chaos situation
if [[ -d $HOME/.pyenv ]] ; then
    # Add pyenv executable to PATH and enable shims
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"

    # Load pyenv into the shell
    eval "$(pyenv init -)"
fi

# -------------------------- DJANGO ---------------------------------

export DJANGO_DEBUG=1


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
if [ $HOST != "Jacks-MacBook-Pro.local" ] ; then
    export PROMPT="☁️  $PROMPT"
fi

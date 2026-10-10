export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
plugins=(git kubectl vi-mode terraform)
source $ZSH/oh-my-zsh.sh

# bat
which bat > /dev/null
if [ $? = 0 ]
then
    alias cat="bat"
fi

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export KUBE_CONFIG_PATH=$HOME/.kube/config

export XDG_CONFIG_HOME=$HOME/.config

# Disable DSUSP, which cause ^y to put process in background good for mutt
# because I can scroll up without exiting
stty dsusp undef

export DJANGO_DEBUG=1

# A spot for machine-specific stuff which isn't tracked in version control.
if [ -f ~/shell-cfg.zsh ]
then
    source ~/shell-cfg.zsh
fi

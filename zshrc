# BEGIN oh-my-zsh [DUPLICATED; see ./shell_aliases.zsh]
#
# Note: for now, I run this twice, which slows down shell startup quite a bit.
# I source it once from `~/.zshenv`, because I want the aliases in
# non-interactive terminals. I source it again in `~/.zshrc` because I want
# the oh-my-zsh prompt, which I think isn't setup when we source from
# `~/.zshenv`, since `~/.zshenv` runs in a non-interactive context. I'm not
# sure if there is a workaround where I can source only the alias part of
# oh-my-zsh first, and then source the setup for interactive components later.
#
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
plugins=(git kubectl vi-mode terraform)
source $ZSH/oh-my-zsh.sh
# END oh-my-zsh

# pyenv
if [ -d $HOME/.pyenv ]
then
    # Add pyenv executable to PATH and enable shims
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/versions/3.9.6/bin:$PATH"
    eval "$(pyenv init --path)"
    # Load pyenv into the shell
    eval "$(pyenv init -)"
fi

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


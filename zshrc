# -------------------------- ENVIRONMENT ----------------------------

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

export EDITOR=$(which nvim)
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export KUBE_CONFIG_PATH=$HOME/.kube/config

# make fzf index hidden directories
export FZF_DEFAULT_COMMAND='fd --type f -H'

if [[ -f ~/.env ]] then
    source ~/.env
fi

alias kibana="k port-forward -n kube-system service/kibana-logging 5601"


# -------------------------- ALIASES --------------------------------


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
alias dcl="docker-compose logs"

# git worktree
alias gwa="git worktree add"
alias gwl="git worktree list"
alias gwr="git worktree remove"
alias grao="git remote add origin"
alias grro="git remote rm origin"

# tmux (warning: collisions with trunk)
alias t="tmux"
alias tl="tmux ls"
alias ta="tmux attach-session -t"
alias tn="tmux new-session -t"

# Make
alias m="make"

# cargo
alias c="cargo"
alias cr="cargo run"
alias cb="cargo build"
alias cf="cargo fmt"
alias ct="cargo test"
alias cl="cargo clippy"

# trunk (warning: collisions with tmux)
alias ts="trunk serve"

# npm
alias n="npm"
alias nr="npm run"
alias nrt="npm run test"
alias nrl="npm run lint"
alias nrd="npm run dev"
alias nrc="npm run check"
alias nrs="npm run start"
alias nrs="npm run build"
alias ni="npm install"
alias nid="npm install --save-dev"

alias listen="lsof -i -P -n | grep LISTEN"


alias n="npm"
alias nrs="npm run start"
alias nrd="npm run dev"
alias nrt="npm run test"
alias ni="npm install"


function nvims() {
    if [ -f Session.vim ]; then
        nvim -S Session.vim
    else
        echo "no session.vim file found"
    fi
}


#####################################################################
############################   macOS   ##############################
############################   only    ##############################
if [[ $OSTYPE == "darwin"* ]] ; then
#####################################################################

export XDG_CONFIG_HOME=$HOME/.config

# Disable DSUSP, which cause ^y to put process in background
# good for mutt because I can scroll up without exiting
stty dsusp undef


# -------------------------- HOMEBREW PACKAGES --------------------------------




# -------------------------- DJANGO ---------------------------------

export DJANGO_DEBUG=1

# -------------------------- MACOS STUPIDITY ------------------------

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"


#####################################################################
fi  # macOS only ####################################################
#####################################################################



# -------------------------- OH-MY-ZSH ------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"

DISABLE_UPDATE_PROMPT="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

alias gbc="gb --sort=committerdate"
alias grbpr='git rebase -i $(git merge-base $(git_main_branch) HEAD)'
alias grrs='git reset --soft'
alias grl='git reflog'
alias grph='git rev-parse HEAD'
alias gp!='git push --force'
alias gdpr='git diff $(git merge-base $(git_main_branch) HEAD) HEAD'

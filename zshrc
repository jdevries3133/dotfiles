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

# bat
which bat > /dev/null
if [[ $? -eq 0 ]] then
    alias cat="bat"
fi

export EDITOR=$(which nvim)
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export KUBE_CONFIG_PATH=$HOME/.kube/config

# make fzf index hidden directories
export FZF_DEFAULT_COMMAND='fd --type f -H'

alias kibana="k port-forward -n kube-system service/kibana-logging 5601"


# -------------------------- ALIASES --------------------------------

# my darling boy
alias n='nvim'

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
alias tfa!="terraform apply -auto-approve"

# misc
alias nt="nvim -c \"terminal\""
alias temp="cd $(mktemp -d)"

# git
alias ggg="nvim ~/.oh-my-zsh/plugins/git/README.md"
alias gsur="git submodule update --remote --merge"


# kubectl
alias k="kubectl"
alias kd="kubectl describe"
function kns() {
    if [ -z $1 ]
    then
        kubectl get ns
    else
        if [ -z "$(k get namespaces | grep "$1")" ]
        then
            echo "namespace $1 does not exist"
            return 1
        fi
        kubectl config set-context \
            $(kubectl config current-context) \
            --namespace=$1
    fi
}

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
alias tso="trunk serve --open"

# npm
alias nr="npm run"
alias nrt="npm run test"
alias nrl="npm run lint"
alias nrd="npm run dev"
alias nrc="npm run check"
alias nrs="npm run start"
alias nrs="npm run build"
alias nrtc="npm run typecheck"

alias listen="lsof -i -P -n | grep LISTEN"

function nvims() {
    if [ -f Session.vim ]; then
        nvim -S Session.vim
    else
        echo "no session.vim file found"
    fi
}

export MONGO_URI="mongodb://mongoadmin:supersecret@localhost:27017?authSource=admin"
function mongoup() {
    docker run -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=supersecret -d  mongo:latest
    echo "connection string is $MONGO_URI"
    echo 'available as $MONGO_URI'
}

share() {
    abspath="$1"
    if [ "$(echo "$1" | cut -c 1-2)" != "/" ]
    then
        abspath="$(pwd)/$1"
    fi
    cd "$(mktemp -d)"
    cp "$abspath" .
    open .
    cd -
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
plugins=(git kubectl vi-mode terraform)

source $ZSH/oh-my-zsh.sh
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

alias gbc="gb --sort=committerdate"
alias grbpr='git rebase -i $(git merge-base $(git_main_branch) HEAD)'
alias grrs='git reset --soft'
alias grl='git reflog'
alias grph='git rev-parse HEAD'
alias gpsup!='gpsup --force'
alias gfix="git add -A; git commit -m 'fixup'; grbpr"

# Git branch name; for when I need to manually do the above workflow, but still want
# a commit-stable branch name (maybe for later).
function gbrn() {
    merge_base_message="$(git log $(git merge-base $(git_main_branch) HEAD)...HEAD  --pretty='format:%s' | tail -n 1)"
    sanitized_message=$(echo $merge_base_message \
            | sed 's/ /-/g' \
            | sed 's/(.*)//g' \
            | sed 's/://g' \
            | sed 's/\`//g' \
            | sed 's/"//g' \
            | sed 's/&//g' \
            | sed "s/'//g" \
            | sed "s/<//g" \
            | sed "s/>//g" \
            | sed 's/\///g' \
            | sed 's/\$//g' \
            | sed 's/\[//g' \
            | sed 's/\]//g' \
            | sed 's/\*//g' \
            | sed 's/\.//g' \
    )

    echo $sanitized_message
}

# The glue of the one-branch workflow. Treating a single branch as a personal
# trunk is great, because it allows you to use interactive rebasing to manage
# an evolving stack of personal changes. Better yet, when commits merge into
# the main branch, they will "dissapear" from your personal trunk and provide
# a little notification to you! For example:
#
#     dropping e2eb1d215a87d0c6cfb06580ccab80bbc2432ace feat: some change
#     -- patch contents already upstream
#
# The tricky part of this workflow is picking individual commits off of your
# trunk and creating downstream branches for pull requests. That process is
# automated by `goo`.
#
# After running `goo`, you will be presented with the opportunity to make a
# rebase plan on your personal trunk. Here, you should craft your _target
# branch_ (the one you intend to open an MR for). Typically, this means
# deleting every line except for the one commit you intend to keep.
#
# When you save an exist the rebase plan, and then complete the rebase, `goo`
# will;
#
# - automatically generate a branch name based on the base-commit title
# - reset the target branch to its merge-base with the main branch
# - cherry-pick each commit on the branch you crafted to the target branch
#
# Ultimately, this gives you a branch that you can force-push up to your PR.
# 
# Since the branch name is based on the branch's base commit, the name will
# be stable as long as you don't change the base commit's title. You can keep
# adding more commits to your PR if you wish, just stack them on top of the
# original base commit.
#
# If you wish to amend to your original commit instead of creating new commits
# (this is what I do because it's easier to manage), this is well-supported
# too. Notice that the generated branch retains the same merge-base with
# master, even if you have rebased your personal trunk. This means that your
# reviwer can easily see what changed in-between force-pushes, without all
# the noise that is typically introduced from rebasing.
#
# See also https://jackdevries.com/post/oneBranch
function goo() {

    # See https://chatgpt.com/share/b88cf4e0-519d-4d51-a47e-9013fc4ed23d
    setopt sh_word_split

    main_branch=$(git_main_branch)
    starting_branch=$(git_current_branch)
    auto_branch=$(date '+jack__%m/%d/%Y__%s')

    git checkout -b $auto_branch
    git rebase -i $(git merge-base $(git_main_branch) HEAD)

    # If the previous rebase had some merge conflicts, we're done; need to
    # defer to the human. Human can later re-run `goo` to proceed.
    if [ $? != 0 ]
    then
        return
    fi

    # At this point, sitting on a crappy generated branch. Instead, let's create a
    # semantic branch name from the commit message, destroying the temporary
    # branch that we're on, so that we are left with a nicely named
    # one.

    # rename the branch to match the commit message
    semantic_branch_name=$(gbrn)
    git branch -m $semantic_branch_name
    if [ $? != 0 ]
    then
        # The semantic branch already exists. We need to update it instead of
        # creating it.
        git checkout $semantic_branch_name
        git reset --hard $(git merge-base $main_branch HEAD)
        auto_branch_commits="$(
            git log --format="%H" $main_branch..$auto_branch | tac | xargs
        )"
        for commit in $auto_branch_commits
        do
            git cherry-pick $commit > /dev/null
            if [ $? != 0 ]
            then
                return
            fi
        done
    fi

    # # Finally, delete the generated branch to cleanup after ourselves
    git branch -D $auto_branch
}

# Goo with a fixup before-hand. Generally used for amending pull requests.
function goof() {
    gfix
    goo $@
}

# I use this with my one-branch workflow to create visual delimiters. See
# also https://jackdevries.com/post/oneBranch
alias gdelim='git commit --allow-empty -m "-------------------------------"; git commit --allow-empty -m "-------------------------------"'
alias gbt='gb -D temp; gco -b temp'
alias gp!='git push --force-with-lease'
# Note: I'm overriding `git blame`, but I never use git-blame from the command
# line.
alias gbl='git branch-log'

setopt rmstarsilent
if [ -f ~/shell-cfg.zsh ]
then
    source ~/shell-cfg.zsh
fi

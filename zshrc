setopt rmstarsilent

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

# `goo` is the essential glue of my One-Branch git workflow. See
# https://jackdevries.com/post/oneBranch to learn more.
function goo() {

    # See https://chatgpt.com/share/b88cf4e0-519d-4d51-a47e-9013fc4ed23d
    setopt sh_word_split

    main_branch=$(git_main_branch)
    starting_branch=$(git_current_branch)
    auto_branch=$(date '+temp_goo__%m/%d/%Y__%s')
    target_branch=$auto_branch

    git checkout -b $auto_branch || git checkout $auto_branch
    git reset --hard $starting_branch

    # aka `grbpr`
    git rebase -i $(git merge-base $(git_main_branch) HEAD)

    # If the previous rebase had some merge conflicts, we're done; need to
    # defer to the human.
    if [ $? != 0 ]
    then
        return
    fi

    # Rename the automatic branch to match the commit message, derived from
    # the branch base commit.
    semantic_branch_name=$(gbrn)
    git branch -m $semantic_branch_name

    # The semantic branch may already exist, in which case the above branch
    # rename will have failed. In that case, we want to put this branch's
    # commits onto that branch, with the caveat that it's nice to maintain
    # a consistent merge-base on branches who have pull requests. If we're
    # going to force-push, maintaining a consistent merge-base with the
    # main branch allows the reviewer to directly diff the previous and
    # current HEAD of the PR branch. GitHub and GitLab also have features in
    # their web UI which work better if we maintain a consistent merge-base.
    #
    # To maintain a consistent merge-base, we will;
    #
    # 1. Checkout to the PR branch.
    # 2. Hard-reset it to its own merge-base with the main branch.
    # 3. Cherry-pick each commit from the generated branch onto this branch.
    if [ $? != 0 ]
    then
        git checkout $semantic_branch_name
        git reset --hard $(git merge-base $main_branch HEAD)
        auto_branch_commits="$(
            git log --format="%H" $main_branch..$auto_branch | tac | xargs
        )"
        for commit in $auto_branch_commits
        do
            git cherry-pick $commit

            # Again, if the cherry-pick introduces conflicts, we need to stop
            # and defer to the human. This could be exacerbated if your PR
            # branch is too far behind. If that is the case, you can always
            # manually rebase the PR branch on the main branch, which will
            # update its merge-base to be closer to the current HEAD of
            # the main branch.
            if [ $? != 0 ]
            then
                return
            fi
        done

        # Finally, delete the generated branch to cleanup after ourselves.
        git branch -D $auto_branch

    fi
}

# Goo with a fixup before-hand
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

# Colors.
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Nicer prompt.
export PS1=$'\n'"%F{green} %*%F %3~ %F{white}"$'\n'"$ "

# Enable plugins.
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/bin:/usr/local/bin:/opt/homebrew/bin:$HOME/Library/Python/3.9/bin
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

ZSH_DISABLE_COMPFIX="true"
source $ZSH/oh-my-zsh.sh

# User configuration
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# docker compose alias
alias zshconfig="vim ~/.zshrc"
alias dcup="docker-compose up"
alias dcdown="docker-compose down"

# Git aliases.
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Git upstream branch syncer.
# Usage: gsync master (checks out master, pull upstream, push origin).
function gsync() {
 if [[ ! "$1" ]] ; then
     echo "You must supply a branch."
     return 0
 fi

 BRANCHES=$(git branch --list $1)
 if [ ! "$BRANCHES" ] ; then
    echo "Branch $1 does not exist."
    return 0
 fi

 git checkout "$1" && \
 git pull upstream "$1" && \
 git push origin "$1"
}

# Super useful Docker container oneshots.
# Enter a running Docker container.
function denter() {
 if [[ ! "$1" ]] ; then
     echo "You must supply a container ID or name."
     return 0
 fi

 docker exec -it $1 bash
 return 0
}

# Delete a given line number in the known_hosts file.
knownrm() {
 re='^[0-9]+$'
 if ! [[ $1 =~ $re ]] ; then
   echo "error: line number missing" >&2;
 else
   sed -i '' "$1d" ~/.ssh/known_hosts
 fi
}
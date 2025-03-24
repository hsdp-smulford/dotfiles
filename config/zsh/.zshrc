# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Oh My Zsh Configuration
export ZSH="${XDG_DATA_HOME}/oh-my-zsh"
ZSH_CUSTOM="$ZSH/custom"

# History Configuration
HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt HIST_SAVE_NO_DUPS

# Modern completion system
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
zmodload zsh/complist

# Directory Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# PATH setup with Homebrew priority
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$PATH"

# Python setup
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH:."
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Go setup
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Node.js setup
export NVM_DIR="${XDG_DATA_HOME}/nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

# Modern environment variables
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export EDITOR='nvim'
export VISUAL='nvim'
export KUBE_EDITOR='nvim'
export LANG=en_US.UTF-8
export BAT_THEME="Dracula"
export BAT_PAGING="never"
export BAT_STYLE="plain"

# FZF Configuration
export FZF_BASE="$(brew --prefix)/opt/fzf"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Unified plugin list
plugins=(
  ansible
  aws
  azure
  brew
  direnv
  docker
  docker-compose
  fzf
  gcloud
  gh
  git
  gitignore
  golang
  helm
  history-substring-search
  httpie
  kubectl
  kubectx
  kube-ps1
  minikube
  node
  npm
  pip
  python
  rust
  terraform
  vagrant
  virtualenv
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Powerlevel10k theme
source ${XDG_DATA_HOME}/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh

# Tool Completions
source <(kubectl completion zsh)
complete -F __start_kubectl k
complete -C '/usr/local/bin/aws_completer' aws

# DevOps/Container aliases
alias k='kubectl'
alias kns='kubens'
alias kctx='kubectx'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias ke='kubectl exec -it'
alias ka='kubectl apply -f'
alias kds='kubectl delete -f'

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dexec='docker exec -it'
alias dlogs='docker logs'

# AWS aliases
alias aws-whoami='aws sts get-caller-identity'
alias awsp='export AWS_PROFILE=$(aws configure list-profiles | fzf)'
export AWS_PAGER=
export AWS_DEFAULT_REGION=us-east-1

# Modern CLI replacements
alias cat='bat'
alias du='dust'
alias find='fd'
alias ls='eza'
alias ll='eza -l --git'
alias la='eza -la --git'
alias ps='procs'
alias top='btop'
alias tree='eza --tree'
alias vi='nvim'
alias vim='nvim'

# Git aliases
alias g='git'
alias gst='git status -sb'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gcn='git commit --no-verify'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gp='git push'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias mkdir='mkdir -pv'

# System aliases
alias ports='netstat -tulanp'
alias ssha='eval $(ssh-agent) && ssh-add'
alias cpuinfo='sysctl -n machdep.cpu.brand_string'
alias meminfo='ps aux | sort -nr -k 4 | head -10'

# HAP
export ADDONS=~/hap/terraform-k8s-addons
export COMMON=~/hap/terraform-common
export EKS=~/hap/terraform-eks
export INFRA=~/hap/infra
export HAP=~/hap/hsp-aws-platform
export PLAY=~/hap/playground
export VPC=~/hap/terraform-vpc
alias hap='cd $HAP'

# Homebrew
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/brew/Brewfile"
export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
export HOMEBREW_LOGS="$XDG_STATE_HOME/homebrew/logs"

# Needed for 1password ssh keys
SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# Utility functions
function mkcd() { mkdir -p "$@" && cd "$@"; }

function extract() {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xjf $1     ;;
           *.tar.gz)    tar xzf $1     ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar e $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xf $1      ;;
           *.tbz2)      tar xjf $1     ;;
           *.tgz)       tar xzf $1     ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)          echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

function al() {
    if [ -z "$1" ]; then
        echo "Usage: al <profile-name>"
        echo "Current AWS_PROFILE: $AWS_PROFILE"
        return 1
    fi
    if ! grep -q "\[profile $1\]" ~/.aws/config; then
        echo "Profile '$1' not found in ~/.aws/config"
        return 1
    fi
    export AWS_PROFILE="$1"
    if ! aws sts get-caller-identity &> /dev/null; then
        echo "Not authenticated. Initiating SSO login..."
        export AWS_NO_BROWSER=true
        aws sso login
    else
        echo "AWS profile set to: $1"
    fi
}

function weather() {
    curl "wttr.in/${1:-}"
}

# Custom functions for DevOps
kube-pods() { kubectl get pods --all-namespaces | grep -i "$1"; }
aws-instances() { aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value | [0], InstanceId, State.Name, PrivateIpAddress]' --output table; }

# Brew maintenance (both names for compatibility)
function brew-maintenance() {
    brew-housekeeping
}

function brew-housekeeping() {
    echo "🍺 Updating Homebrew..."
    brew update

    echo "🍺 Upgrading packages..."
    brew upgrade

    echo "🍺 Cleaning up..."
    brew cleanup -s

    echo "🍺 Removing dead symlinks..."
    brew cleanup --prune=all

    echo "🍺 Running doctor..."
    brew doctor

    echo "🍺 Checking for missing dependencies..."
    brew missing

    echo "🍺 Updating Brewfile..."
    brew bundle dump --force --file="$HOMEBREW_BUNDLE_FILE"

    echo "✨ Brew maintenance complete!"
}

# Utility aliases
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'
alias uuidc='uuid | tr -d "\n" | pbcopy'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias utcnow='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias ip="curl -s https://ipinfo.io/ip"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Quick edits
alias zshrc='$EDITOR ${ZDOTDIR}/.zshrc'

# Housekeeping
alias docker-clean='docker system prune -af'

# Initialize modern tools
eval "$(direnv hook zsh)"
eval "$(atuin init zsh)"  # Modern shell history
eval "$(zoxide init zsh)" # Modern directory jumping
eval "$(thefuck --alias)"

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
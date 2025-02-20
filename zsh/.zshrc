# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Path to Oh My Zsh installation - Updated for XDG
export ZSH="${XDG_DATA_HOME}/oh-my-zsh"

# History Configuration - Updated for XDG
HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

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

# Python setup with modern tools
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Modern Node.js setup
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
export BAT_THEME="Dracula"

# FZF with modern defaults
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# Modern plugins for DevOps/Platform Engineering
plugins=(
  ansible
  aws
  azure
  brew
  direnv
  docker
  fzf
  gcloud
  gh
  git
  gitignore
  golang
  helm
  httpie
  kubectl
  kubectx
  kube-ps1
  minikube
  pip
  python
  rust
  terraform
  vagrant
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Powerlevel10k theme with XDG
source ${XDG_DATA_HOME}/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh

# DevOps aliases

alias aws-whoami='aws sts get-caller-identity'
alias awsp='export AWS_PROFILE=$(aws configure list-profiles | fzf)'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias graf='grafana'
alias helm-list='helm ls --all-namespaces'
alias k='kubectl'
alias kc='kubectl config get-contexts'
alias kctx='kubectx'
alias kns='kubens'
alias t='terraform'
alias tg='terragrunt'

# Development aliases
export BAT_PAGING="never"
export BAT_STYLE="plain"
alias cat='bat'
alias dig='dog'
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

# Git aliases - modern workflow
alias gca='git commit --amend'
alias gcb='git checkout -b'
alias gcn='git commit --no-verify'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gpr='git pull --rebase'
alias gst='git status -sb'

#HAP
export ADDONS=/~hap/terraform-k8s-addons
export COMMON=~/hap/terraform-common
export EKS=~/hap/terraform-eks
export INFRA=~/hap/infra
export PLAT=~/hap/hsp-aws-platform
export PLAY=~/hap/playground
export VPC=~/hap/terraform-vpc

# Initialize modern tools
eval "$(direnv hook zsh)"
eval "$(atuin init zsh)"  # Modern shell history
eval "$(zoxide init zsh)" # Modern directory jumping

# Key bindings for modern terminal experience
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Custom functions for DevOps
kube-pods() { kubectl get pods --all-namespaces | grep -i "$1"; }
aws-instances() { aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value | [0], InstanceId, State.Name, PrivateIpAddress]' --output table; }

# brew
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/brew/Brewfile"
export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
export HOMEBREW_LOGS="$XDG_STATE_HOME/homebrew/logs"

# AWS
export AWS_PAGER=
export AWS_DEFAULT_REGION=us-east-1

# Shawns nice stuff
al () {
	if [ -z "$1" ]
	then
		echo "Usage: al <profile-name>"
		echo "Current AWS_PROFILE: $AWS_PROFILE"
		return 1
	fi
	if ! grep -q "\[profile $1\]" ~/.aws/config
	then
		echo "Profile '$1' not found in ~/.aws/config"
		return 1
	fi
	export AWS_PROFILE="$1"
	if ! aws sts get-caller-identity &> /dev/null
	then
		echo "Not authenticated. Initiating SSO login..."
		export AWS_NO_BROWSER=true
		aws sso login
	else
		echo "AWS profile set to: $1"
	fi
}

weather () {
	curl "wttr.in/${1:-}"
}

# UUID generators
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'
alias uuidc='uuid | tr -d "\n" | pbcopy'

alias now='date +"%Y-%m-%d %H:%M:%S"'
alias utcnow='date -u +"%Y-%m-%dT%H:%M:%SZ"'

# IP addresses
alias ip="curl -s https://ipinfo.io/ip"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# System
alias cpuinfo='sysctl -n machdep.cpu.brand_string'
alias meminfo='ps aux | sort -nr -k 4 | head -10'

# Housekeeping
alias docker-clean='docker system prune -af'

# Quick edits
alias zshrc='$EDITOR ${ZDOTDIR}/.zshrc'

# Directory shortcuts (complementing your zoxide)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Simple version
alias brew-clean='brew update && brew upgrade && brew cleanup && brew doctor'

# More comprehensive function version
brew-maintenance() {
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
    
    # Optional: update Brewfile
    echo "🍺 Updating Brewfile..."
    brew bundle dump --force --file="$HOMEBREW_BUNDLE_FILE"
    
    echo "✨ Brew maintenance complete!"
}

alias c='code .'
alias ports='lsof -i -P -n | grep LISTEN | awk "{printf \"%-20s %-10s %-10s %s\n\", \$1, \$3, \$8, \$9}"'


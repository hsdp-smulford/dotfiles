#!/bin/zsh
# Enable Powerlevel10k instant prompt
# shellcheck disable=SC2296
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # shellcheck disable=SC1090
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_AI_HOME="$XDG_CONFIG_HOME/ai"

# Oh My Zsh Configuration
export ZSH="${XDG_DATA_HOME}/oh-my-zsh"
ZSH_CUSTOM="$ZSH/custom"

# Rust
#export CARGO_HOME="$XDG_DATA_HOME/cargo"
#export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
#export PATH="$CARGO_HOME/bin:$PATH"

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

# completion system
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
# shellcheck disable=SC2296
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
zmodload zsh/complist

# Directory Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$PATH"

export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH:."
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

alias python='python3'

# Go setup
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Node.js setup
export NVM_DIR="${XDG_DATA_HOME}/nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

# npm XDG configuration
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"
export PATH="$XDG_DATA_HOME/npm/bin:$PATH"

# uv (Python package manager) XDG configuration
export UV_CONFIG_FILE="$XDG_CONFIG_HOME/uv/uv.toml"
export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"

# environment variables
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export EDITOR='nvim'
export VISUAL='nvim'
export KUBE_EDITOR='nvim'
export LANG=en_US.UTF-8
export BAT_THEME="Dracula"
export BAT_PAGING="never"
export BAT_STYLE="plain"

# Anthropic/claude cli
export CLAUDE_CONFIG_HOME="$XDG_CONFIG_HOME/claude"
export CLAUDE_CODE_CONFIG_HOME="$CLAUDE_CONFIG_HOME"

# FZF Configuration
FZF_BASE=$(brew --prefix)/opt/fzf
export FZF_BASE
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
# shellcheck disable=SC1090
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugin list
plugins=(
  direnv
  fast-syntax-highlighting
  fzf
  git
  gitignore
  history-substring-search
  zsh-autosuggestions
  forgit
  keychain

  # DevOps tools
  ansible
  aws
  azure
  docker
  docker-compose
  gcloud
  gh
  helm
  kubectl
  kubectx
  kube-ps1
  minikube
  terraform
  vagrant

  # Development languages and tools
  brew
  golang
  httpie
  node
  npm
  pip
  python
  rust
  virtualenv
)

zstyle :omz:plugins:keychain identities id_ed25519_pmf id_ed25519_sft
zstyle :omz:plugins:keychain options --quiet --quick

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Powerlevel10k theme
source ${XDG_DATA_HOME}/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh

# Tool Completions
# shellcheck disable=SC1090
source <(kubectl completion zsh)
complete -F __start_kubectl k
complete -C '/opt/homebrew/bin/aws_completer' aws

# k8s aliases
alias k='kubectl'
alias kns='kubens'
alias kn='kubens'
alias kctx='kubectx'
alias kx='kubectx'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias ke='kubectl exec -it'
alias ka='kubectl apply -f'
alias kds='kubectl delete -f'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgi='kubectl get ingress'

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dexec='docker exec -it'
alias dlogs='docker logs'
alias dcp='docker compose pull'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'
alias dcps='docker compose ps'

# AWS stuff
#export AWS_CLI_AUTO_PROMPT=on
export AWS_DEFAULT_OUTPUT=json
export AWS_PAGER=
export AWS_DEFAULT_REGION=us-east-1
export AWS_COLOR=on

# Terraform/OpenTofu setup
export TENV_AUTO_INSTALL=true

# Terraform aliases
alias t='terraform'
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tff='terraform fmt -recursive'
alias tfv='terraform validate'

# OpenTofu aliases (use these in OpenTofu projects)
alias to='tofu'
alias toi='tofu init'
alias top='tofu plan'
alias toa='tofu apply'
alias tod='tofu destroy'
alias tof='tofu fmt -recursive'
alias tov='tofu validate'

# CLI replacements
alias cat='bat'
alias du='dust'
alias find='fd'
alias ls='eza'
alias ll='eza -l --git --icons'
alias la='eza -la --git --icons'
alias ps='procs'
alias top='btop'
alias tree='eza --tree --icons'
alias vi='nvim'
alias vim='nvim'
alias ff='fastfetch'

# AI stuff
# if [[ -z "$ANTHROPIC_API_KEY" ]]; then
#     export ANTHROPIC_API_KEY=$(keybase fs read keybase://private/jerseyshawn/secrets/anthropic/api_key)
# fi

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
alias gcl='git clone'
alias gf='git fetch --all --prune'
alias grhh='git reset --hard HEAD'
alias gsta='git stash'
alias gstp='git stash pop'

# GH
alias ghtoken='export GITHUB_TOKEN=$(gh auth token) && echo "GITHUB_TOKEN: ${GITHUB_TOKEN}"'

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
alias addons='cd $ADDONS'
alias common='cd $COMMON'
alias eks='cd $EKS'
alias infra='cd $INFRA'
alias hap='cd $HAP'
alias play='cd $PLAY'
alias vpc='cd $VPC'

# Homebrew
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/brew/Brewfile"
export HOMEBREW_BUNDLE_FILE_GLOBAL="$XDG_CONFIG_HOME/brew/Brewfile"
export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
export HOMEBREW_LOGS="$XDG_STATE_HOME/homebrew/logs"

# common brew commands
alias bi='brew install && echo "🍺 Updating Brewfile..." && brew bundle dump --force --file="$HOMEBREW_BUNDLE_FILE" && echo "✅ Brewfile updated"'
alias bu='brew uninstall && echo "🍺 Updating Brewfile..." && brew bundle dump --force --file="$HOMEBREW_BUNDLE_FILE" && echo "✅ Brewfile updated"'
alias bt='brew tap && echo "🍺 Updating Brewfile..." && brew bundle dump --force --file="$HOMEBREW_BUNDLE_FILE" && echo "✅ Brewfile updated"'
alias but='brew untap && echo "🍺 Updating Brewfile..." && brew bundle dump --force --file="$HOMEBREW_BUNDLE_FILE" && echo "✅ Brewfile updated"'

## Needed for 1password ssh keys
GPG_TTY=$(tty)
export GPG_TTY

# Utility functions
function mkcd() { mkdir -p "$@" && cd "$@" || return; }

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

# Claude setup function - ADDED
function claude-setup() {
  echo "Setting up Claude configuration..."
  mkdir -p "$CLAUDE_CONFIG_HOME"
  mkdir -p "$XDG_CACHE_HOME/claude"

  # Migrate claude-code if needed
  if [[ -d "$XDG_CONFIG_HOME/claude-code" && ! -d "$CLAUDE_CONFIG_HOME/code" ]]; then
    echo "Migrating claude-code → claude/code..."
    mkdir -p "$CLAUDE_CONFIG_HOME/code"
    cp -R "$XDG_CONFIG_HOME/claude-code/"* "$CLAUDE_CONFIG_HOME/code/"
    echo "Migration complete. You can remove $XDG_CONFIG_HOME/claude-code after verifying."
  fi

  # Check if the claude.sh script exists
  if [[ ! -f "$CLAUDE_CONFIG_HOME/claude.sh" ]]; then
    echo "Creating claude.sh script..."
    # If you have it locally
    cp ~/Downloads/claude.sh "$CLAUDE_CONFIG_HOME/claude.sh"
    chmod +x "$CLAUDE_CONFIG_HOME/claude.sh"
  else
    echo "claude.sh script already exists."
  fi

  # Check if CLAUDE.md exists
  if [[ ! -f "$CLAUDE_CONFIG_HOME/CLAUDE.md" ]]; then
    echo "Creating CLAUDE.md preferences file..."
    # If you have it locally
    cp ~/Downloads/Integrated\ CLAUDE.md "$CLAUDE_CONFIG_HOME/CLAUDE.md"
  else
    echo "CLAUDE.md already exists."
  fi

  echo "Claude configuration setup complete!"
}

# Custom functions for DevOps
kube-pods() { kubectl get pods --all-namespaces | grep -i "$1"; }
aws-instances() { aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value | [0], InstanceId, State.Name, PrivateIpAddress]' --output table; }

function brew-housekeeping() {
    # Default settings
    local SKIP_DOCTOR=false
    local SKIP_BREWFILE_UPDATE=false
    local VERBOSE=false
    local START_TIME
    START_TIME=$(date +%s)

    # Colors
    local GREEN='\033[0;32m'
    local YELLOW='\033[0;33m'
    local BLUE='\033[0;34m'
    local RED='\033[0;31m'
    local NC='\033[0m' # No Color

    # Parse arguments
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --skip-doctor) SKIP_DOCTOR=true ;;
            --skip-brewfile-update) SKIP_BREWFILE_UPDATE=true ;;
            --verbose) VERBOSE=true ;;
            --help)
                echo -e "${BLUE}Homebrew Housekeeping${NC}"
                echo "Usage: brew-housekeeping [options]"
                echo ""
                echo "Options:"
                echo "  --skip-doctor             Skip 'brew doctor' checks"
                echo "  --skip-brewfile-update    Skip updating the Brewfile"
                echo "  --verbose                 Show detailed output"
                echo "  --help                    Show this help message"
                return 0
                ;;
            *) echo "Unknown parameter: $1"; return 1 ;;
        esac
        shift
    done

    # Suppress non-critical warnings
    export HOMEBREW_NO_ENV_HINTS=1

    # Ensure we have a Brewfile location
    if [[ -z "$HOMEBREW_BUNDLE_FILE" ]]; then
        if [[ -f "$HOME/.config/brew/Brewfile" ]]; then
            export HOMEBREW_BUNDLE_FILE="$HOME/.config/brew/Brewfile"
        else
            export HOMEBREW_BUNDLE_FILE="$HOME/Brewfile"
        fi
        echo -e "${YELLOW}ℹ️  Using Brewfile at: ${HOMEBREW_BUNDLE_FILE}${NC}"
    fi

    echo -e "${GREEN}🔄 Updating Homebrew...${NC}"
    brew update

    echo -e "${GREEN}📋 Checking for differences between installed packages and Brewfile...${NC}"
    if $VERBOSE; then
        brew bundle check --verbose --file="$HOMEBREW_BUNDLE_FILE" || {
            echo -e "${YELLOW}📦 Differences found. Would you like to install from Brewfile? (y/n)${NC}"
            read -r response
            if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
                echo -e "${GREEN}📥 Installing from Brewfile...${NC}"
                brew bundle install --file="$HOMEBREW_BUNDLE_FILE"
            else
                echo -e "${BLUE}⏩ Skipping Brewfile installation.${NC}"
            fi
        }
    else
        brew bundle check --file="$HOMEBREW_BUNDLE_FILE" &>/dev/null || {
            echo -e "${YELLOW}📦 Differences found. Would you like to install from Brewfile? (y/n)${NC}"
            read -r response
            if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
                echo -e "${GREEN}📥 Installing from Brewfile...${NC}"
                brew bundle install --file="$HOMEBREW_BUNDLE_FILE"
            else
                echo -e "${BLUE}⏩ Skipping Brewfile installation.${NC}"
            fi
        }
    fi

    echo -e "${GREEN}⬆️  Upgrading packages...${NC}"
    brew upgrade

    echo -e "${GREEN}🧹 Cleaning up...${NC}"
    brew cleanup -s

    echo -e "${GREEN}🔗 Removing dead symlinks...${NC}"
    brew cleanup --prune=all

    if ! $SKIP_DOCTOR; then
        echo -e "${GREEN}🩺 Running doctor...${NC}"
        brew doctor 2>&1 | grep -v "No Cask quarantine support available"
    else
        echo -e "${BLUE}⏩ Skipping brew doctor check.${NC}"
    fi

    echo -e "${GREEN}🔍 Checking for missing dependencies...${NC}"
    brew missing

    if ! $SKIP_BREWFILE_UPDATE; then
        echo -e "${GREEN}💾 Updating Brewfile...${NC}"
        brew bundle dump --force --file="$HOMEBREW_BUNDLE_FILE"
    else
        echo -e "${BLUE}⏩ Skipping Brewfile update.${NC}"
    fi

    # Calculate execution time
    local END_TIME
    END_TIME=$(date +%s)
    local DURATION=$((END_TIME - START_TIME))

    echo -e "${GREEN}✨ Brew maintenance complete in ${DURATION}s!${NC}"

    # Unset environment variable
    unset HOMEBREW_NO_ENV_HINTS
}

# Utility aliases
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'
alias uuidc='uuid | tr -d "\n" | pbcopy'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias utcnow='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias ip="curl -s https://ipinfo.io/ip"
alias localip="ipconfig getifaddr en0"
alias cip="colima status --json | jq -r .ip_address"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
function path() {
  echo $PATH | tr ':' '\n'
}
# Quick edits
alias zshrc='$EDITOR ${ZDOTDIR}/.zshrc'

# Housekeeping
alias docker-clean='docker system prune -af'

# tool initialization
eval "$(direnv hook zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# JSON/YAML processing
alias jq='jq -C'  # Colorized output
alias yqy='yq -y' # YAML output
alias yqj='yq -j' # JSON output

# Enhanced AWS profile selection with preview
function awsp() {
  local profile
  profile=$(aws configure list-profiles | fzf --preview 'aws sts get-caller-identity --profile {} 2>/dev/null || echo "Not authenticated"')
  if [[ -n $profile ]]; then
    export AWS_PROFILE=$profile
    echo "AWS profile set to: $profile"
  fi
}

# Enhanced kubectx with preview
function kctxf() {
  local context
  context=$(kubectx | fzf --preview 'kubectl config get-contexts {} | head -n 1; echo "\nNodes:"; kubectl get nodes --context {} 2>/dev/null')
  if [[ -n $context ]]; then
    kubectx $context
  fi
}

# Quick access to HAP directories with autocomplete
function hcd() {
  local dir
  dir=$(find ~/hap -type d -maxdepth 2 | fzf)
  if [[ -n $dir ]]; then
    cd "$dir" || return
  fi
}

# AWS enhanced functions
function aws-ssh() {
  local instance
  instance=$(aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,Tags[?Key==`Name`].Value|[0],State.Name,PrivateIpAddress]' --output text | grep running | fzf | awk '{print $1}')
  if [[ -n $instance ]]; then
    echo "Connecting to $instance..."
    aws ssm start-session --target $instance
  fi
}

# terminal enhancements
alias rainbow='lolcat'
alias yolo='git add . && git commit -m "$(curl -s https://whatthecommit.com/index.txt)" && git push'
alias matrix='cmatrix -s -b'
alias pipes='pipes.sh'

# Start terminal with a random header
function header() {
  figlet -f "$(find /usr/local/share/figlet/fonts -name "*.flf" | sort -R | head -1)" "$(hostname)" | lolcat
}

# Show random quote on startup
function random_quote() {
  curl -s https://api.quotable.io/random | jq -r '"\(.content)" - \(.author)'
}

# Execute on startup if you want
# header
# random_quote

# Lotion: /etc/zshrc
# System-wide profile for interactive zsh(1) shells.

# Setup user specific overrides for this in ~/.zshrc. See zshbuiltins(1)
# and zshoptions(1) for more details.

# Correctly display UTF-8 with combining characters.
if [[ "$(locale LC_CTYPE)" == "UTF-8" ]]; then
    setopt COMBINING_CHARS
fi

# Disable the log builtin, so we don't conflict with /usr/bin/log
disable log

# XDG Base Directory Specification
# These should be in /etc/zshenv, but we'll check/set them here if they're not set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

# Ensure ZDOTDIR is set
export ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"

# Save command history in XDG state directory
HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=2000
SAVEHIST=1000

# Create history directory if it doesn't exist
[[ ! -d "${XDG_STATE_HOME}/zsh" ]] && mkdir -p "${XDG_STATE_HOME}/zsh"

# Beep on error
setopt BEEP

# Use keycodes (generated via zkbd) if present, otherwise fallback on
# values from terminfo
if [[ -r "${ZDOTDIR}/.zkbd/${TERM}-${VENDOR}" ]] ; then
    source "${ZDOTDIR}/.zkbd/${TERM}-${VENDOR}"
else
    typeset -g -A key

    # Your existing key mappings here
    [[ -n "$terminfo[kf1]" ]] && key[F1]=$terminfo[kf1]
    [[ -n "$terminfo[kf2]" ]] && key[F2]=$terminfo[kf2]
    [[ -n "$terminfo[kcuf1]" ]] && key[Right]=$terminfo[kcuf1]
fi

# Default key bindings
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search

# Useful support for interacting with Terminal.app or other terminal programs
[ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"

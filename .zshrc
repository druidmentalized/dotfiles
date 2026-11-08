# ==============================================================================
# 0. PRE INSTANT PROMPT
# ==============================================================================
# Load direnv env before instant prompt: its output after the preamble triggers p10k's warning.
# The hook itself still comes from the oh-my-zsh 'direnv' plugin (section 3).
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# ==============================================================================
# 1. POWERLEVEL10K INSTANT PROMPT
# ==============================================================================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# 2. PATH & ENVIRONMENT SETUP
# ==============================================================================
# Ensure path array doesn't contain duplicates (deduplicate)
typeset -U path

# Basic Exports
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8

# Preferred editor
export EDITOR="nvim"

# Orbstack instead of Docker (for programms orienting on env var for socket placement)
export DOCKER_HOST="unix://$HOME/.orbstack/run/docker.sock"

# Lazygit (on macOS it otherwise reads ~/Library/Application Support/lazygit)
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yaml"

# --- Custom Paths ---

# Antigravity
path+=("$HOME/.antigravity/antigravity/bin")

# User Binaries
# NOTE: ~/.local/bin goes first so local overrides win over Homebrew installations
# Example: uv-managed pythong
path=("$HOME/.local/bin" $path)
path+=("$HOME/bin")

# Maven
path+="$HOME/.m2/wrapper/dists/apache-maven-3.9.9-bin/4nf9hui3q3djbarqar9g711ggc/apache-maven-3.9.9/bin"

# psql
path+=("/opt/homebrew/opt/libpq/bin")

# ==============================================================================
# 3. OH-MY-ZSH CONFIGURATION
# ==============================================================================
ZSH_THEME="powerlevel10k/powerlevel10k"

# Load Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    web-search
    direnv
    extract
    sudo
)

source $ZSH/oh-my-zsh.sh

# ==============================================================================
# 4. MODERN TOOLS INITIALIZATION
# ==============================================================================

# Initialize Zoxide (Better CD)
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# Initialize FZF (Fuzzy Finder): completion + Ctrl-R/Ctrl-T/Alt-C key bindings
if command -v fzf > /dev/null; then
    source <(fzf --zsh)
fi

# Direnv is hooked by the oh-my-zsh 'direnv' plugin (section 3); its env is loaded in section 0

# ==============================================================================
# 5. ALIASES & FUNCTIONS
# ==============================================================================

# Config management
alias zshconfig="nvim ~/.zshrc"
alias zshupdate="source ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# Modern Replacements (Linux parity)
alias vim="nvim"
alias vi="nvim"

# ls -> eza (Modern ls)
alias ls="eza --icons --git"
alias ll="eza -lha --icons --git"
alias lt="eza --tree --level=2 --icons"

# cat -> bat (Syntax highlighting cat)
alias cat="bat"

# Ghostty's screensaver (I just really like it)
alias boo="ghostty +boo"

# Docker compose neat call
alias compose="docker compose"

# YAZI CONFIGURATION (Shell Wrapper)
# This function allows to use 'y' to open yazi, and upon quiting,
# the shell changes directory to wherever you were in yazi.
function y() {
	local tmp cwd
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}

# Alias for yazi to call wrapper
alias yazi="y"

# Load Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

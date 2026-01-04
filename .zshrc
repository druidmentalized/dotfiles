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
export EDITOR='nvim'

# --- Custom Paths ---
# Dotnet
export DOTNET_ROOT="$HOME/.dotnet"
path+=("$DOTNET_ROOT" "$DOTNET_ROOT/tools")

export YAZI_ID=1

# Sencha
path+=("/opt/Sencha/Cmd")

# Antigravity
path+=("$HOME/.antigravity/antigravity/bin")

# User Binaries (Standard locations)
path+=("$HOME/bin" "$HOME/.local/bin")

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
  eval "$(zoxide init zsh)"
fi

# Initialize FZF (Fuzzy Finder)
# Uses brew prefix to find the script regardless of Intel vs Apple Silicon
if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
    [ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
    [ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ] && source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
fi

# Direnv (Hook)
if command -v direnv > /dev/null; then
    emulate zsh -c "$(direnv export zsh)"
    emulate zsh -c "$(direnv hook zsh)"
fi

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
alias cd="z"

# ls -> eza (Modern ls)
alias ls="eza --icons --git"
alias ll="eza -lha --icons --git"
alias lt="eza --tree --level=2 --icons"

# cat -> bat (Syntax highlighting cat)
alias cat="bat" 

# Ghostty's screensaver (I just really like it)
alias boo="ghostty +boo"

# YAZI CONFIGURATION (Shell Wrapper)
# This function allows to use 'y' to open yazi, and upon quiting, 
# the shell changes directory to wherever you were in yazi.
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"

    command yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Alias for yazi to call wrapper
alias yazi="y"

# Load Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

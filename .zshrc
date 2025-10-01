# ============================================================================
# DOTFILES - Optimized ZSH Configuration
# ============================================================================

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Powerlevel10k instant prompt - must be near the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# PATH CONFIGURATION
# ============================================================================
typeset -U PATH  # Ensure unique PATH entries
export PATH="$HOME/bin:$HOME/.local/bin:$(brew --prefix)/bin:$(brew --prefix)/opt/libpq/bin:~/.console-ninja/.bin:$PATH"

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
export REDO_HISTORY_PATH="$HOME/.zsh_history"
export REDO_EDITOR="code"
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export NVM_DIR="$HOME/.nvm"

# ============================================================================
# OH MY ZSH CONFIGURATION
# ============================================================================
ZSH_THEME="powerlevel10k/powerlevel10k"

# Performance and behavior settings
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins - optimized list
plugins=(
    git
    nvm
    node
    npm
    heroku
    macos
    command-not-found
    zsh-interactive-cd
    zsh-navigation-tools
    fzf
)

# NVM lazy loading for better performance
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd
zstyle ':omz:plugins:nvm' autoload yes
zstyle ':omz:plugins:nvm' silent-autoload yes

# Initialize Oh My Zsh
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
source $ZSH/oh-my-zsh.sh

# ============================================================================
# NVM SETUP
# ============================================================================
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# ============================================================================
# ALIASES
# ============================================================================

# System & Navigation
alias zr="source ~/.zshrc"
alias ez="code ~/.zshrc"
alias §="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias op="code -a ."

# Git shortcuts
alias gaa="git add ."
alias gs="git status"

# ============================================================================
# FUNCTIONS
# ============================================================================
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions

# ============================================================================
# THEME & PROMPT CONFIGURATION
# ============================================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================================================
# ADDITIONAL TOOLS & COMPLETIONS
# ============================================================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Docker CLI completions
fpath=(/Users/juan.calle/.docker/completions $fpath)
autoload -Uz compinit
compinit

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

#!/usr/bin/env zsh
### Zsh configuration
# usage: ln -fns $(pwd)/.zshrc ~/.zshrc

### initial setup configured by zsh-newuser-install
# To re-run setup: autoload -U zsh-newuser-install; zsh-newuser-install -f
# See man zshoptions or http://zsh.sourceforge.net/Doc/Release/Options.html
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=50000
setopt autocd extendedglob globdots histignorespace noautomenu nomatch

### keybindings: based on https://github.com/romkatv/zsh4humans
bindkey -e
bindkey -s '^[[1~' '^[[H'
bindkey -s '^[[4~' '^[[F'
bindkey -s '^[[5~' ''
bindkey -s '^[[6~' ''
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^H' backward-kill-word
bindkey '^[[3;3~' kill-word
bindkey '^N' kill-buffer

### exports
if command -v code &>/dev/null; then
  export EDITOR='code --wait'
else
  export EDITOR='vim'
fi
TTY=$(tty)
export GPG_TTY=$TTY
export PATH=$PATH:$HOME/.local/bin:$HOME/.poetry/bin
export SSH_KEY_PATH=$HOME/.ssh/id_rsa_$USER
export DOTFILES=$HOME/.dotfiles
export ZSH=$HOME/.oh-my-zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" #This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" #This loads nvm bash_completion

### aliases
  # Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias sudo_refresh="source $HOME/.zshrc"
alias c="clear"

  # Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias development="cd $HOME/Development"
alias desktop="cd $HOME/Desktop"
alias projects="cd $HOME/Development/Projects"

  # JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

  # Git
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias gcz="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"


### prompt: https://github.com/sindresorhus/pure
if ! command -v npm &>/dev/null || [[ $(uname) = 'Linux' ]]; then
  [[ -d $HOME/.zsh/pure ]] && fpath+=$HOME/.zsh/pure
fi
autoload -U promptinit
promptinit
prompt pure

### homebrew
case $(uname) in
Darwin)
  if [[ $(uname -m) == 'arm64' ]]; then
    BREW_PREFIX='/opt/homebrew'
  elif [[ $(uname -m) == 'x86_64' ]]; then
    BREW_PREFIX='/usr/local'
  fi
  ;;
Linux) BREW_PREFIX='/home/linuxbrew/.linuxbrew' ;;
esac
eval $($BREW_PREFIX/bin/brew shellenv)

### completions
if type brew &>/dev/null; then
  fpath+=$HOME/.zfunc:$(brew --prefix)/share/zsh/site-functions
  if [[ -d $(brew --prefix)/bin/terraform ]]; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C $(brew --prefix)/bin/terraform terraform
  fi
fi

zstyle :compinstall filename $HOME/.zshrc
autoload -Uz compinit
# ignore insecure directories (perms issues for non-admin user)
[[ $(whoami) = 'brendon.smith' ]] && compinit -i || compinit

### syntax highlighting
if [[ -d $(brew --prefix)/share/zsh-syntax-highlighting ]]; then
  . $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -d $HOME/.zsh/zsh-syntax-highlighting ]]; then
  . $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

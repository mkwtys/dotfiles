setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space

export PATH=/usr/local/sbin:$PATH

# zshrc.local
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="refined"
DISABLE_AUTO_TITLE="true"
plugins=(git node npm)
source $ZSH/oh-my-zsh.sh

#volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# go
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH

# rbenv
if [ -d $HOME/.rbenv/ ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  # rbenv global 2.3.1
fi

# phpbrew
[[ -e $HOME/.phpbrew/bashrc ]] && source $HOME/.phpbrew/bashrc

# direnv
eval "$(direnv hook zsh)"

# openssl
export PATH=$HOME/usr/local/opt/openssl@1.1/bin:$PATH

# android sdk
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# arduino avrdude
PATH=$PATH:$HOME/bin:/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin/

# flutter
export PATH="$PATH:$HOME/src/github.com/flutter/flutter/bin"

# peco
function peco-src() {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  # zle clear-screen
}

zle -N peco-select-history
bindkey '^r' peco-select-history

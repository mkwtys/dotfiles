setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space

# homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# zshrc.local
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="refined"
DISABLE_AUTO_TITLE="true"
plugins=(git node npm)
source $ZSH/oh-my-zsh.sh

#mise
eval "$(mise activate zsh)"

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
if [ -d /opt/homebrew/opt/openssl@3/bin ]; then
  export PATH=/opt/homebrew/opt/openssl@3/bin:$PATH
elif [ -d /usr/local/opt/openssl@3/bin ]; then
  export PATH=/usr/local/opt/openssl@3/bin:$PATH
fi

# android sdk
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# arduino avrdude
PATH=$PATH:$HOME/bin:/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin/

# flutter
export PATH="$PATH:$HOME/src/github.com/flutter/flutter/bin"

# python
alias python='python3'

# docker
alias docker-compose="docker compose"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

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
# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pure"
DISABLE_AUTO_TITLE="true"
plugins=(git node npm zsh-syntax-highlighting)
export PATH=$HOME/bin:/usr/local/bin:$PATH
source $ZSH/oh-my-zsh.sh

# nodebrew
if [ -f $HOME/.nodebrew/nodebrew ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
  nodebrew use v6
fi

# go
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH

# rbenv
if [ -d $HOME/.rbenv/ ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv global 2.3.1
fi

# direnv
eval "$(direnv hook zsh)"

# peco
function peco-src () {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

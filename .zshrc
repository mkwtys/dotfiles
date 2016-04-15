# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="cloud"
DISABLE_AUTO_TITLE="true"
plugins=(git node npm)
export PATH=$HOME/bin:/usr/local/bin:$PATH
source $ZSH/oh-my-zsh.sh

# nodebrew
if [ -f $HOME/.nodebrew/nodebrew ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
  nodebrew use v4
fi

# go
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH

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

#!/usr/bin/env sh

dotfiles=".vim .gitconfig .gitignore_global .npmrc .vimrc .zshrc"
for dotfile in $dotfiles
do
  ln -s "$PWD/$dotfile" $HOME
done

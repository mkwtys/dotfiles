#!/usr/bin/env sh

dotfiles=".vim .zsh .gitconfig .gitignore_global .npmrc .vimrc .zshrc"

for dotfile in $dotfiles
do
  ln -snfv "$PWD/$dotfile" "$HOME/$dotfile"
done

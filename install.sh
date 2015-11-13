#!/usr/bin/env sh

for f in .??*
do
  [ "$f" = ".git" ] && continue
  [ "$f" == ".DS_Store" ] && continue
  ln -snfv "$PWD/$f" "$HOME"/"$f"
done

#!/bin/bash

FILES=( config.cson init.coffee keymap.cson snippets.cson styles.less packages.cson )

for file in ${FILES[@]}
do
  if ! [ -f $HOME/.atom/$file ]; then
    ln -s $HOME/dotfiles/atom/$file $HOME/.atom/$file
  fi
done

apm install package-sync


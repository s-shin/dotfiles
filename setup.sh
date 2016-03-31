#!/bin/bash
set -eux

DOT_FILES=( .vimrc dein.toml .vim .tmux.conf .emacs.d )

for file in ${DOT_FILES[@]}
do
    if ! test -e $HOME/$file; then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

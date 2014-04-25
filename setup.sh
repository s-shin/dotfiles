#!/bin/bash

DOT_FILES=( .vimrc .vim .tmux.conf .emacs.d )

for file in ${DOT_FILES[@]}
do
    if ! test -e $HOME/$file; then
    	ln -s $HOME/dotfiles/$file $HOME/$file
	fi
done




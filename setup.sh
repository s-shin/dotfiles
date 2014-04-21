#!/bin/bash

DOT_FILES=( .vimrc .vim .tmux.conf )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

#[ ! -d ~/.vim/bundle ] && curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh



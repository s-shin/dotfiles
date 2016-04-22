#!/bin/bash

COMPLETION_FILES=( git-completion.bash git-prompt.sh )

for file in ${COMPLETION_FILES[@]}; do
  rm $HOME/dotfiles/$file
  curl -L -o $HOME/dotfiles/$file https://raw.githubusercontent.com/git/git/master/contrib/completion/$file
done

if ! [ -f ~/.gitconfig ]; then
    ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
fi

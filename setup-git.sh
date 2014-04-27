#!/bin/bash

curl -LO https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

if ! [ -f ~/.gitconfig ]; then
    ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
fi


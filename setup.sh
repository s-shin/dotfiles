#!/bin/bash
set -eux

# symlink dotfiles
for file in \
  .vimrc .vim dein.toml \
  .tmux.conf .tmux \
  .emacs.d \
  .gitconfig \
; do
  if [[ ! -s $HOME/$file ]]; then
    ln -s $HOME/dotfiles/$file $HOME/$file
  fi
done

# source bash files
for file in \
  .bashrc .bash_profile \
; do
  dir='. $HOME/dotfiles/'
  src=$dir$file
  if ! $(grep "$src" $HOME/$file >/dev/null); then
    printf "$src\n\n" >> $HOME/$file
  fi
done

# .atom/*
mkdir -p $HOME/.atom
for file in \
  config.cson init.coffee keymap.cson snippets.cson styles.less \
; do
  if [[ ! -s $HOME/.atom/$file ]]; then
    ln -s $HOME/dotfiles/atom/$file $HOME/.atom/$file
  fi
done

# vscode
vscode_user_dir="${HOME}/Library/Application Support/Code/User"
if [[ -d "$vscode_user_dir" ]]; then
  for file in settings.json keybindings.json; do
    mv "${vscode_user_dir}/${file}" "${vscode_user_dir}/${file}.bk"
    ln -s "${HOME}/dotfiles/vscode/${file}" "${vscode_user_dir}/${file}"
  done
fi

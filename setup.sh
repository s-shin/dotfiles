#!/bin/bash
set -eu

: ${DEFAULT_TARGETS:=vim tmux git bash}

run() { echo "RUN: $*"; "$@"; }
log.i() { echo "INFO: $*"; }
log.e() { echo "ERROR: $*"; }

apply_to_files() {
  local cmd="$1"; shift
  while (($# > 0)); do
    local file="$1"; shift
    if [[ -a "${HOME}/${file}" ]]; then
      log.i "Skip ~/${file} that already exists."
      continue
    fi
    run $cmd "${HOME}/dotfiles/${file}" "${HOME}/${file}"
  done
}

link() { apply_to_files 'ln -s' "$@"; }
copy() { apply_to_files 'cp' "$@"; }

setup.bash() {
  # source bash files
  local file
  for file in \
    .bashrc .bash_profile
  do
    local src=". \"\${HOME}/dotfiles/${file}\""
    if ! (grep "$src" "${HOME}/${file}" >/dev/null); then
      echo -ne "${src}\n\n" >>"${HOME}/${file}"
    fi
  done
}

setup.zsh() {
  local file
  for file in \
    .zprofile .zshrc .zshenv
  do
    local src=". \"\${HOME}/dotfiles/${file}\""
    if ! (grep "$src" "${HOME}/${file}" >/dev/null 2>&1); then
      echo -ne "${src}\n\n" >>"${HOME}/${file}"
    fi
  done
}

setup.fish() {
  # NOTE: Referring XDG_CONFIG_HOME would be better.
  mkdir -p "${HOME}/.config/fish"
  link .config/fish/*
}

setup.tmux() {
  git submodule update --init .tmux/plugins/tpm
  link .tmux.conf .tmux
}

setup.git() {
  copy .gitconfig
}

setup.vim() {
  link .vimrc .vim dein.toml
}

setup.emacs() {
  link .emacs.d
}

setup.atom() {
  mkdir -p "${HOME}/.atom"
  for file in \
    config.cson init.coffee keymap.cson snippets.cson styles.less
  do
    if [[ ! -s "${HOME}/.atom/${file}" ]]; then
      ln -s "${HOME}/dotfiles/atom/${file}" "${HOME}/.atom/${file}"
    fi
  done
}

setup.vscode() {
  if [[ "$(uname)" != Darwin ]]; then
    log.i 'Not supported now.'
    return
  fi
  local vscode_user_dir="${HOME}/Library/Application Support/Code/User"
  if [[ -d "$vscode_user_dir" ]]; then
    for file in settings.json keybindings.json; do
      if [[ -f "${vscode_user_dir}/${file}" ]]; then
        mv "${vscode_user_dir}/${file}" "${vscode_user_dir}/${file}.bk"
      fi
      ln -s "${HOME}/dotfiles/vscode/${file}" "${vscode_user_dir}/${file}"
    done
  fi
  # Fix cursor problem in vim plugin.
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
}

setup.karabiner() {
  if [[ "$(uname)" != Darwin ]]; then
    log.i 'Only macOS supported, skipped.'
    return
  fi
  local p='.config/karabiner/assets/complex_modifications'
  mkdir -p "${HOME}/${p}"
  ln -s "${HOME}/dotfiles/${p}/my_default.json" "${HOME}/${p}/"
}

setup.starship() {
  mkdir -p "${HOME}/.config"
  ln -s "${HOME}/dotfiles/starship.toml" "${HOME}/.config/starship.toml"
}

while IFS=$'\n' read -r line; do TARGETS+=("$line"); done < <(compgen -A function setup. | cut -d. -f2)

help() {
  cat <<EOT
Usage: $0 [-a | --all | all] [-h | --help] [-l | --list] [<targets>...]
EOT
}

list() {
  local target
  for target in "${TARGETS[@]}"; do
    echo "$target"
  done
}

main() {
  # shellcheck disable=SC2206
  local targets=($DEFAULT_TARGETS)
  if (($# > 0)); then
    case "$1" in
      -h | --help ) help; exit 1;;
      -l | --list ) list; exit;;
      -a | --all | all ) targets=("${TARGETS[@]}");;
      -* ) log.e "Unknown option: $1"; exit 1;;
      * ) targets=("$@");;
    esac
  fi
  log.i "Targets: ${targets[*]}"
  local target
  for target in "${targets[@]}"; do
    log.i "Setup ${target}..."
    "setup.${target}"
  done
}

main "$@"

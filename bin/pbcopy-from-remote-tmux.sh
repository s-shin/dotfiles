#!/bin/sh

set -eu

usage() {
  echo "$0 REMOTE"
}

if [[ -z "${1+x}" ]]; then
  usage
  exit 1
fi

ssh "$@" "tmux save-buffer -" | pbcopy

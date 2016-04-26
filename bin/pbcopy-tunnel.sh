#!/bin/sh

usage() {
  echo "PBCOPY_PORT=... $0 REMOTE"
}

if [[ -z "${1+x}" ]]; then
  usage
  exit 1
fi

if [[ -z "${PBCOPY_PORT+x}" ]]; then
  echo "The declaration of PBCOPY_PORT is required."
  exit 1
fi

ssh -R $PBCOPY_PORT:localhost:22 $1

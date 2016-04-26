#!/bin/sh

if [[ -z "${PBCOPY_PORT+x}" ]]; then
  echo "The declaration of PBCOPY_PORT is required."
  exit 1
fi

tmux save-buffer - | ssh -p $PBCOPY_PORT localhost pbcopy

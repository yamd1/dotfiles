#!/bin/bash
set -ue

if [[ ! -x "$HOME/.local/bin/mise" ]]; then
  # avoid use sudo
  curl https://mise.jdx.dev/mise-latest-linux-x64 > ~/.local/bin/mise
fi

mise install

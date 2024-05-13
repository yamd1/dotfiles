#!/bin/bash
set -ue

# SEE: https://aquaproj.github.io/docs/products/aqua-installer#shell-script
if [[ ! -x "$HOME/.local/share/aquaproj-aqua/bin/aqua" ]]; then
  curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.1/aqua-installer
  echo "fb4b3b7d026e5aba1fc478c268e8fbd653e01404c8a8c6284fdba88ae62eda6a  aqua-installer" | sha256sum -c
  chmod +x aqua-installer
  ./aqua-installer
fi

AQUA_CONFIG=$HOME/.config/aquaproj-aqua
export AQUA_POLICY_CONFIG=$AQUA_CONFIG/policy.yaml
# $HOME/.local/share/aquaproj-aqua/bin/aqua allow policy
$HOME/.local/share/aquaproj-aqua/bin/aqua -c $AQUA_CONFIG/aqua.yaml i

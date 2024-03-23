#!/bin/bash
set -ue

# SEE: https://aquaproj.github.io/docs/products/aqua-installer#shell-script
if [[ ! -x "$HOME/.local/share/aquaproj-aqua/bin/aqua" ]]; then
  curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.3.0/aqua-installer
  echo "1577b99b74751a5ddeea757198cee3b600fce3ef18990540e4d0e667edcf1b5f  aqua-installer" | sha256sum -c
  chmod +x aqua-installer
  ./aqua-installer
fi

AQUA_CONFIG=$HOME/.config/aquaproj-aqua
export AQUA_POLICY_CONFIG=$AQUA_CONFIG/policy.yaml
# $HOME/.local/share/aquaproj-aqua/bin/aqua allow policy
$HOME/.local/share/aquaproj-aqua/bin/aqua -c $AQUA_CONFIG/aqua.yaml i

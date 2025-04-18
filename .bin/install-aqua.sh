#!/bin/bash
set -ue

# SEE: https://aquaproj.github.io/docs/products/aqua-installer#shell-script
if [[ ! -x "$HOME/.local/share/aquaproj-aqua/bin/aqua" ]]; then
  curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.1/aqua-installer
  echo "e9d4c99577c6b2ce0b62edf61f089e9b9891af1708e88c6592907d2de66e3714  aqua-installer" | sha256sum -c -
  chmod +x aqua-installer
  ./aqua-installer -v v2.48.1
fi

AQUA_CONFIG=$HOME/.config/aquaproj-aqua
export AQUA_POLICY_CONFIG=$AQUA_CONFIG/policy.yaml
$HOME/.local/share/aquaproj-aqua/bin/aqua policy allow
$HOME/.local/share/aquaproj-aqua/bin/aqua -c $AQUA_CONFIG/aqua.yaml i --only-link

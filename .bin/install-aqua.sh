#!/bin/bash

set -ue

# SEE: https://aquaproj.github.io/docs/products/aqua-installer#shell-script

if [[ ! -x "$HOME/.local/share/aquaproj-aqua/bin/aqua" ]]; then
  curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.2.0/aqua-installer
  echo "d13118c3172d90ffa6be205344b93e8621de9bf47c852d80da188ffa6985c276  aqua-installer" | sha256sum -c
  chmod +x aqua-installer
  ./aqua-installer
fi

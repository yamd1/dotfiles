#!/bin/bash
set -ue

# avoid use sudo
curl https://mise.jdx.dev/mise-latest-linux-x64 > ~/.local/bin/mise

mise install

#!/bin/bash
set -ue

# avoid use sudo
curl https://mise.run | sh

$HOME/.local/bin/mise install

#!/bin/bash

set -ue

if [ -z ${1:-} ]; then
  nvim .
else
  nvim "$1"
fi

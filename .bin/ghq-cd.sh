#!/bin/bash

set -ue

cd $(ghq list -p | fzf)

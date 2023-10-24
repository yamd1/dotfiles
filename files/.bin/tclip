#!/bin/sh

if [ $# -eq 0 ]; then
    printf "\e]52;c;%s\a" "$(base64 -w 0)"
else
    printf "\e]52;c;%s\a" "$(printf "%s" "$*" | base64 -w 0)"
fi

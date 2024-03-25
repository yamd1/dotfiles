#/bin/bash
set -ue

git status --porcelain \
  | fzf -m --preview 'echo {} | cut -c -3 | grep -q "??" && echo {} | cut -c 4- | xargs -I_ delta /dev/null _ --width ${FZF_PREVIEW_COLUMNS} || echo {} | cut -c 4- | xargs -I@ git diff @ @ | delta --width ${FZF_PREVIEW_COLUMNS}' --preview-window=70% \
  | cut -c 4- \
  | tr '\n' ' '

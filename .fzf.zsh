# Setup fzf
# ---------
if [[ ! "$PATH" == */home/yosky/.fzf/bin* ]]; then

  PATH="${PATH:+${PATH}:}/home/yosky/.fzf/bin"

fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/yosky/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/yosky/.fzf/shell/key-bindings.zsh"

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/yosky/.fzf/bin* ]]; then

  PATH="${PATH:+${PATH}:}/home/$USER/.fzf/bin"

fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/$USRE/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/$USER/.fzf/shell/key-bindings.zsh"

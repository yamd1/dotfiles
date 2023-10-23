# Setup fzf
# ---------
if [[ ! "$PATH" == */home/y-yamada/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/y-yamada/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/y-yamada/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/y-yamada/.fzf/shell/key-bindings.bash"

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/yskym/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/yskym/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/yskym/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/yskym/.fzf/shell/key-bindings.bash"

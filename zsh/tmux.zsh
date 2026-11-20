#for use tmux
alias tmux-changekey='tmux set-option -ag prefix C-b'
alias tmux-revertkey='tmux set-option -ag prefix C-a'

attach-tmux() {
  [[ -n $TMUX ]] && return 0
  tmux new-session -A -s main
}

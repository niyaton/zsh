#for use tmux
alias tmux-changekey='tmux set-option -ag prefix C-b'
alias tmux-revertkey='tmux set-option -ag prefix C-a'

function attach_tmux(){
  if ( ! test $TMUX ) ; then 
    if ( tmux has-session ); then
	if (tmux list-session | grep -v attached); then
            tmux attach-session
        fi
    else
	    tmux
    fi
  fi
}
attach_tmux

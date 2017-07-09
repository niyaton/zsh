#for use tmux
alias tmux-changekey='tmux set-option -ag prefix C-b'
alias tmux-revertkey='tmux set-option -ag prefix C-a'

function attach_tmux(){
  if test $TMUX ; then
	  return
  fi
  if ( tmux has-session 2> /dev/null ); then
	  if (tmux list-session | grep -v attached); then
		  tmux attach-session
	  fi
  else
	    tmux
  fi
}

function save-tmux-session(){
	tmux ls | while read session_line
	do
		session=`echo $session_line | cut -d ' ' -f 1`

		tmux list-windows -t $session | while read window_line
		do
			echo hoge
			echo $window_line
			window=`echo $window_line | cut -d ' ' -f 1`

			tmux select-window -t $window[1,-2]
			echo `pwd`
		done
	done
}

function print_color_pallet(){
	for i in {000..255}; do
		printf "\e[38;5;${i}m ${i}\e[0m"
		[ $(($i % 16)) -eq 15 ] && echo
	done
}

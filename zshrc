export ZSHHOME="${HOME}/.zsh"

local -a PATTERNS
PATTERNS+="*.zsh"
[[ ${OSTYPE} == darwin* ]] && PATTERNS+="*.zsh.osx"

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for pattern in $PATTERNS; do
    	for i in $ZSHHOME/*.zsh; do
       		[ \( -f $i -o -h $i \) -a -r $i ] && source $i
    	done
    done
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

attach_tmux

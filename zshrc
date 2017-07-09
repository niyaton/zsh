export ZSHHOME="${HOME}/.zsh"

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/*.zsh; do
        [ \( -f $i -o -h $i \) -a -r $i ] && source $i
    done
fi

# TODO need refactoring
case "${OSTYPE}" in
	darwin*)
		for i in $ZSHHOME/*.zsh.osx; do
			[ \( -f $i -o -h $i \) -a -r $i ] && source $i
		done
		;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

attach_tmux

export ZSHHOME="${HOME}/.zsh"

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/*.zsh; do
        [ \( -f $i -o -h $i \) -a -r $i ] && source $i
    done
fi

[[ -f ~/.config/fzf/fzf.zsh ]] && source ~/.config/fzf/fzf.zsh

if command -v mise >/dev/null; then
  eval "$(mise activate zsh)"
fi

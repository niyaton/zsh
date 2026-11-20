export ZSHHOME="${HOME}/.zsh"

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/*.zsh; do
        [ \( -f $i -o -h $i \) -a -r $i ] && source $i
    done
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# TODO:
# Replace this runtime activation with a generated script (zsh build).
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if [[ -o interactive ]] && (( $+commands[tmux] )) && [[ -z $TMUX && $TERM_PROGRAM != WezTerm ]]; then
	attach-tmux
fi

# WezTerm: copy the last completed command and its terminal output.
if [[ -o interactive && -n $WEZTERM_PANE && -z $TMUX ]]; then
  [[ -r "$HOME/work/wezterm/shell/copy-last-command.zsh" ]] && source "$HOME/work/wezterm/shell/copy-last-command.zsh"
fi

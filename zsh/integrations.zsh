# WezTerm integration
if [[ -n $WEZTERM_PANE ]]; then
  local wezterm_integration="/Applications/WezTerm.app/Contents/Resources/wezterm.sh"
  if [[ -f $wezterm_integration ]]; then
    source "$wezterm_integration"
  fi
fi

# WezTerm: copy the last completed command and its terminal output.
if [[ -o interactive && -n $WEZTERM_PANE && -z $TMUX ]]; then
  [[ -r "$HOME/work/wezterm/shell/copy-last-command.zsh" ]] && source "$HOME/work/wezterm/shell/copy-last-command.zsh"
fi

# WezTerm integration
if [[ -n $WEZTERM_PANE ]]; then
  local wezterm_integration="/Applications/WezTerm.app/Contents/Resources/wezterm.sh"
  if [[ -f $wezterm_integration ]]; then
    source "$wezterm_integration"
  fi
fi
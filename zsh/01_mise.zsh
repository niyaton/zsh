# Generate mise activation while the remaining Zsh files load.
if [[ -o interactive ]] && command -v mise >/dev/null; then
  _mise_activation_path=$PATH
  exec {_mise_activation_fd}< <(
    activation=$(command mise activate zsh) && print -r -- "$activation"
  )
fi

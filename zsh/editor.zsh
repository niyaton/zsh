if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
  export VISUAL=nvim
  alias vim='nvim'
else
  export EDITOR=vim
  export VISUAL=vim
fi

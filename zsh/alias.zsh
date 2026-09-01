# macOS標準コマンドだけで使える短縮形。
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# nvimがある場合だけvimとして使う。
if (( $+commands[nvim] )); then
  alias vim='nvim'
fi

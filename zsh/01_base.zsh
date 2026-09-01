autoload -Uz compinit
compinit

# macOS標準のEmacs風キー操作（Ctrl-A、Ctrl-Eなど）を使う。
bindkey -e

setopt auto_cd          # ディレクトリ名だけでcdできる
setopt auto_pushd       # cdの履歴を保存する
setopt interactive_comments

# 大文字・小文字を区別せず、途中までの入力でも補完する。
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*'
zstyle ':completion:*' menu select

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
  export VISUAL=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi

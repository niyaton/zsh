export ZSHHOME="${HOME}/.zsh"

# ファイル名の順番で設定を読み込む。
if [[ -d "$ZSHHOME" ]]; then
  for config in "$ZSHHOME"/*.zsh(N); do
    source "$config"
  done
fi

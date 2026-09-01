#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
backup_suffix=".backup-$(date +%Y%m%d-%H%M%S)-$$"

backup_path() {
  target=$1
  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "${target}${backup_suffix}"
    printf '既存の %s を %s に退避しました。\n' "$target" "${target}${backup_suffix}"
  fi
}

backup_path "$HOME/.zsh"
backup_path "$HOME/.zshrc"

# 教員アカウント内のリポジトリを参照し続けないよう、学生のホームへコピーする。
# 古いコンパイル済み設定（*.zwc）などを混ぜないよう、管理対象だけを選ぶ。
mkdir "$HOME/.zsh"
for config in "$repo_dir"/zsh/*.zsh; do
  cp "$config" "$HOME/.zsh/"
done
cp "$repo_dir/zshrc" "$HOME/.zshrc"

printf '設定が完了しました。次のコマンドでZshを起動してください。\n  exec zsh\n'

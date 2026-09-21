#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
backup_suffix=".backup-$(date +%Y%m%d-%H%M%S)-$$"

link_config() {
  source_path=$1
  target_path=$2

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    printf '%s は設定済みです。\n' "$target_path"
    return
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    mv "$target_path" "${target_path}${backup_suffix}"
    printf '既存の %s を %s に退避しました。\n' "$target_path" "${target_path}${backup_suffix}"
  fi

  ln -s "$source_path" "$target_path"
}

link_config "$repo_dir/zsh" "$HOME/.zsh"
link_config "$repo_dir/zshrc" "$HOME/.zshrc"
link_config "$repo_dir/Dracula.dircolors" "$HOME/.dircolors"

printf '設定が完了しました。次のコマンドで再読み込みできます。\n  exec zsh\n'

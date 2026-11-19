set -eu # -e: Exit on command errors; -u: Treat unset variables as errors.

# Link source_path to target_path:
# - Missing target: Create a symlink.
# - Existing or broken symlink: Replace it.
# - Regular file or directory: Stop without changing it.
link_config() {
  local source_path="$1" target_path="$2"

  # -e: Check if target_path exists; ! -L: Check that it is not a symlink.
  if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
    printf 'Error: %s already exists and is not a symlink.\n' "$target_path" >&2
    return 1
  fi

  # -f: Replace an existing destination symlink.
  # -n: Treat a destination symlink to a directory as the link itself.
  ln -sfn "$source_path" "$target_path"
}

# set repo_dir to the absolute path of the directory containing this script
repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

link_config "$repo_dir/zsh" "$HOME/.zsh"
link_config "$repo_dir/zshrc" "$HOME/.zshrc"

printf 'Setup complete. Please restart zsh to load the new configuration.\n'

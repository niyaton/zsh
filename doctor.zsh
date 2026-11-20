# Check tools using the same search path as the installed configuration.
source "${0:A:h}/zsh/00_path.zsh" || exit 1

missing_required=0
for tool in gls gdircolors nvim; do
  if command -v "$tool" >/dev/null; then
    printf 'OK: %s\n' "$tool"
  else
    printf 'Missing required tool: %s\n' "$tool" >&2
    missing_required=1
  fi
done

for tool in fzf zstd python3 mise; do
  if ! command -v "$tool" >/dev/null; then
    printf 'Missing optional tool: %s\n' "$tool"
  fi
done

exit "$missing_required"

# Check tools using the same search path as the installed configuration.
source "${0:A:h}/zsh/00_path.zsh" || exit 1

missing_required=0
for tool in gls gdircolors nvim fzf; do
  if command -v "$tool" >/dev/null; then
    printf 'OK: %s\n' "$tool"
  else
    printf 'Missing required tool: %s\n' "$tool" >&2
    missing_required=1
  fi
done

for tool in zstd python3 mise; do
  if ! command -v "$tool" >/dev/null; then
    printf 'Missing optional tool: %s\n' "$tool"
  fi
done

fzf_script="${0:A:h}/zsh/fzf.zsh"
if [[ -f "$fzf_script" && -r "$fzf_script" ]]; then
  printf 'OK: %s\n' "$fzf_script"
else
  printf 'Missing or unreadable optional file: %s\n' "$fzf_script"
  printf 'Generate it with: fzf --zsh > %q\n' "$fzf_script"
fi

exit "$missing_required"

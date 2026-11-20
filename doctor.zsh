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

if [[ -f ~/.config/fzf/fzf.zsh && -r ~/.config/fzf/fzf.zsh ]]; then
  printf 'OK: ~/.config/fzf/fzf.zsh\n'
else
  printf 'Missing or unreadable optional file: ~/.config/fzf/fzf.zsh\n'
  printf '%s\n' 'Generate it with: mkdir -p ~/.config/fzf && fzf --zsh > ~/.config/fzf/fzf.zsh'
fi

exit "$missing_required"

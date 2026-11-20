update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     echo 'compiling zshrc.' $i
     zcompile $i
  done
}

# Select a directory with fzf and cd into it.
fcd() {
  local dir
  dir=$(find "${1:-.}" -path '*/\.*' -prune \
              -o -type d -print 2> /dev/null | fzf +m) &&
  builtin cd "$dir"
}

zstdrm() {
  zstd --rm "$@"
}

tz() {
  # By default, the pipeline status comes from zstd, so a tar failure can be missed.
  # local_options: Limit option changes to this function.
  # pipe_fail: Fail the pipeline if either tar or zstd fails.
  setopt local_options pipe_fail

  if [[ $# -ne 1 ]]; then
    echo 'Usage: tz <directory>' >&2
    return 1
  fi

  # ${1%/}: Remove a trailing slash from the first argument.
  local dir=${1%/}

  if [[ ! -d "$dir" ]]; then
    echo "Error: '$dir' is not a directory." >&2
    return 1
  fi

  tar -cf - -- "$dir" | zstd -T0 -o "${dir}.tar.zst" || return $?

  printf 'Created: %s\n' "${dir}.tar.zst"
  printf 'Archived path: %s/ (parent directories are preserved; a leading / is removed).\n' "${dir#/}"
}

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

  local archive="${dir}.tar.zst"
  if [[ -e "$archive" || -L "$archive" ]]; then
    printf 'Error: %s already exists.\n' "$archive" >&2
    return 1
  fi

  # Publish the archive only after both tar and zstd succeed.
  local temporary_file
  temporary_file=$(mktemp -- "${archive}.tmp.XXXXXXXX") || return
  {
    tar -cf - -- "$dir" | zstd -T0 -c >| "$temporary_file" || return
    if [[ -d "$archive" ]]; then
      printf 'Error: %s already exists.\n' "$archive" >&2
      return 1
    fi
    command mv -nh -- "$temporary_file" "$archive" || return
    # mv -n may report success when it skips an existing destination.
    if [[ -e "$temporary_file" ]]; then
      printf 'Error: %s already exists.\n' "$archive" >&2
      return 1
    fi
  } always {
    command rm -f -- "$temporary_file"
  }

  printf 'Created: %s\n' "$archive"
  printf 'Archived path: %s/ (parent directories are preserved; a leading / is removed).\n' "${dir#/}"
}

print-color-palette() {
  local i
  for i in {000..255}; do
    printf "\e[38;5;${i}m ${i}\e[0m"
    [ $(($i % 16)) -eq 15 ] && echo
  done
}

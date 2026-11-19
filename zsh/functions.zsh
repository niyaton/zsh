update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     echo 'compiling zshrc.' $i
     zcompile $i
  done
}

function encrypt() {
  echo 'encrypt was removed. Use age instead.'
  echo ''
  echo 'Example:'
  echo '  age -p FILE > FILE.age'
  return 1
}

# Decrypt files created by the old encrypt function:
# openssl aes-256-cbc -e -in "$1" -out "$1.encrypted"
function legacy_decrypt() {
  if [[ $# -ne 1 ]]; then
    echo 'Usage: legacy_decrypt FILE.encrypted' >&2
    return 1
  fi

  openssl aes-256-cbc -d -in "$1" -out "$1.plain"
}

function tar-pbzip2() {
  echo 'tar-pbzip2 was removed. Use tz <directory> instead.' >&2
  return 1
}

# Select a directory with fzf and cd into it.
fcd() {
  local dir
  dir=$(find "${1:-.}" -path '*/\.*' -prune \
              -o -type d -print 2> /dev/null | fzf +m) &&
  builtin cd "$dir"
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

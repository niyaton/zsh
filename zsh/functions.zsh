function encrypt(){
	openssl aes-256-cbc -e -in $1 -out $1.encrypted
}

function decrypt(){
	openssl aes-256-cbc -d -in $1 -out $1.plain
}

function zstdrm() {
	if (( ! $+commands[zstd] )); then
		echo 'zstd is not installed.' >&2
		return 127
	fi
	zstd --rm "$@"
}

function tar-pbzip2() {
	echo 'tar-pbzip2 was removed. Use tz <directory> instead.' >&2
	return 1
}

# fd - cd to selected directory
fd() {
  if (( ! $+commands[fzf] )); then
    echo 'fzf is not installed.' >&2
    return 127
  fi
  local dir
  dir=$(find "${1:-.}" -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  builtin cd "$dir"
}

tz() {
  if [[ $# -ne 1 ]]; then
    echo 'Usage: tz <directory>' >&2
    return 1
  fi
  if (( ! $+commands[zstd] )); then
    echo 'zstd is not installed.' >&2
    return 127
  fi

  local dir=${1%/}
  if [[ ! -d "$dir" ]]; then
    echo "Error: '$dir' is not a directory." >&2
    return 1
  fi

  tar -cf - -- "$dir" | zstd -T0 -o "${dir}.tar.zst"
}

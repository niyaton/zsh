function encrypt(){
	openssl aes-256-cbc -e -in $1 -out $1.encrypted
}

function decrypt(){
	openssl aes-256-cbc -d -in $1 -out $1.plain
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

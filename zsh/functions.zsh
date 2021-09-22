function encrypt(){
	openssl aes-256-cbc -e -in $1 -out $1.encrypted
}

function decrypt(){
	openssl aes-256-cbc -d -in $1 -out $1.plain
}

function tar-pbzip2() {
    tar cf $1 --use-compress-program=pbzip2 $argv[2,-1]
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

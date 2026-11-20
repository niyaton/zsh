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

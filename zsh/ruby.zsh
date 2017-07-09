# Initialize rbenv.
# Only execute eval rbenv init on startup
if [[ "$(whence -w rbenv 2>/dev/null )" != *(function|none) ]]; then
	eval "$(rbenv init -)"
fi

# Initialize rbenv.
# Only execute eval rbenv init on startup
if [[ "$(whence -w rbenv 2>/dev/null )" != *function ]]; then
	if which pyenv > /dev/null; then
		eval "$(rbenv init -)"
	fi
fi

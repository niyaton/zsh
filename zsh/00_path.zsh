case "${OSTYPE}" in
	darwin*)
		#for homebrew
		export PATH=/usr/local/bin:$PATH
		export PATH=/usr/local/sbin:$PATH

		#for my scripts
		export PATH=~/local/bin:$PATH

		#for MacTeX
		export PATH=$PATH:/usr/texbin

		#for Heroku Toolbelt
		export PATH=/usr/local/heroku/bin:$PATH
		;;
	linux*)
		;;
esac

# Initialize rbenv.
# Only execute eval rbenv init on startup
if [[ "$(whence -w rbenv 2>/dev/null )" != *function ]]; then
	if which pyenv > /dev/null; then
		eval "$(rbenv init -)"
	fi
fi

typeset -U path

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

		#for composer
		export PATH=$PATH:$HOME/.composer/vendor/bin
		;;
	linux*)
		;;
esac

typeset -U path

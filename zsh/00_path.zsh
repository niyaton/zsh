typeset -U path fpath

case "${OSTYPE}" in
	darwin*)
		path=(
			"$HOME/local/bin"
			"$HOME/.nodebrew/current/bin"
			/usr/local/bin
			/usr/local/sbin
			/opt/homebrew/bin
			/opt/homebrew/sbin
			$path
			/usr/texbin
		)
		export HOMEBREW_PREFIX="/opt/homebrew";
		export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
		export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}";
		export FPATH=$FPATH:/opt/homebrew/share/zsh/site-functions
		export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
		export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";
		;;
	linux*)
		;;
esac

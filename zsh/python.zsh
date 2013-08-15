# Initialize pyenv.
if [ -z "$(printenv TMUX)" ]; then
	hash pyenv 2>/dev/null && eval "$(pyenv init -)"
fi

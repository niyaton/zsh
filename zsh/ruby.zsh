# Initialize rbenv.
if [ -z "$(printenv TMUX)" ]; then
	hash rbenv 2>/dev/null && eval "$(rbenv init -)"
fi

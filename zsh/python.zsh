# Initialize pyenv.
# "eval pyenv init -" is much heavy. use cached script.
if [ -n "$(printenv TMUX)" ]; then
	source $ZSHHOME/pyenv.init-no-rehash
else
	source $ZSHHOME/pyenv.init
fi

check_pyenv_init() {
	pyenv init - | diff - $ZSHHOME/pyenv.init
	pyenv init - --no-rehash | diff - $ZSHHOME/pyenv.init-no-rehash
}

update_pyenv_init() {
	pyenv init - > $ZSHHOME/pyenv.init
	pyenv init - --no-rehash > $ZSHHOME/pyenv.init-no-rehash
}

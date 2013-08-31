check_pyenv_init() {
	pyenv init - | diff - $ZSHHOME/pyenv.init
	pyenv init - --no-rehash | diff - $ZSHHOME/pyenv.init-no-rehash
}

update_pyenv_init() {
	pyenv init - > $ZSHHOME/pyenv.init
	pyenv init - --no-rehash > $ZSHHOME/pyenv.init-no-rehash
}

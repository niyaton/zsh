check_rbenv_init() {
	rbenv init - zsh| diff - $ZSHHOME/rbenv.init
	rbenv init - --no-rehash zsh| diff - $ZSHHOME/rbenv.init-no-rehash
}

update_rbenv_init() {
	rbenv init - zsh> $ZSHHOME/rbenv.init
	rbenv init - --no-rehash zsh> $ZSHHOME/rbenv.init-no-rehash
}

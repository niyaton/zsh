# Initialize rbenv.
# "eval rbenv init -" is much heavy. use cached script.
if [ -n "$(printenv TMUX)" ]; then
	source $ZSHHOME/rbenv.init-no-rehash
else
	source $ZSHHOME/rbenv.init
fi

check_rbenv_init() {
	rbenv init - | diff - $ZSHHOME/rbenv.init
	rbenv init - --no-rehash | diff - $ZSHHOME/rbenv.init-no-rehash
}

update_rbenv_init() {
	rbenv init - > $ZSHHOME/rbenv.init
	rbenv init - --no-rehash > $ZSHHOME/rbenv.init-no-rehash
}

ln -i -n -s $PWD/zsh ~/.zsh
ln -i -n -s $PWD/zshrc ~/.zshrc
if [ -n "`uname -ar | grep Microsoft`" ]; then
	ln -i -n -s $PWD/Dracula.dircolors.bow ~/.dircolors
else
	ln -i -n -s $PWD/Dracula.dircolors ~/.dircolors
fi

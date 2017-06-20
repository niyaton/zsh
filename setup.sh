ln -i -n -s $PWD/zsh ~/.zsh
ln -i -n -s $PWD/zshrc ~/.zshrc
ln -i -n -s $PWD/zshenv ~/.zshenv
if [ -n "`uname -ar | grep Microsoft`" ]; then
	ln -i -n -s $PWD/Dracula.dircolors.bow ~/.dircolors
else
	ln -i -n -s $PWD/Dracula.dircolors ~/.dircolors
fi

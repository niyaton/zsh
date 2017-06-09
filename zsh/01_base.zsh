zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit

autoload zed

#setting keybind
bindkey -v

#setting cd history
setopt auto_pushd

#coloring ls
eval `dircolors ~/.dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}

update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     echo 'compiling zshrc.' $i
     zcompile $i
  done
  if [ ! -h ${fpath[1]}/_brew ]; then
	  echo "link homebrew completion to ${fpath[1]}"
	  ln -s /usr/local/Library/Contributions/brew_zsh_completion.zsh ${fpath[1]}/_brew
  fi
  echo "update pyenv init cache"
  update_pyenv_init
  echo "update rbenv init cache"
  update_rbenv_init
  echo "update JAVAHOME path"
  echo $(/usr/libexec/java_home) > $ZSHHOME/java_home
}

function tar-pbzip2() {
    tar cf $1 --use-compress-program=pbzip2 $argv[2,-1]
}

#for z
#. `brew --prefix`/etc/profile.d/z.sh

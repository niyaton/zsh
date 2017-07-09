zstyle :compinstall filename "${HOME}/.zshrc"
setopt extended_glob

# from https://gist.github.com/ctechols/ca1035271ad134841284
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
autoload -Uz compinit
if [[ -n ${ZSHHOME}/compaudit_check(#qN.mh+24) ]]; then
	echo check compaudit
	compinit -d
	touch ${ZSHHOME}/compaudit_check
else
	compinit -C -d
fi

autoload zed

#setting keybind
bindkey -v

#setting cd history
setopt auto_pushd

#coloring ls
# TODO too slow
case "${OSTYPE}" in
	darwin*)
		eval `gdircolors ~/.dircolors`
		;;
	linux*)
		eval `dircolors ~/.dircolors`
		;;
esac
zstyle ':completion:*:default' list-colors ${LS_COLORS}

update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     echo 'compiling zshrc.' $i
     zcompile $i
  done
  #TODO need refactoring
  if [[ ${OSTYPE} == darwin* ]]; then
	  for i in $ZSHHOME/*.zsh.osx; do
	  	echo 'compiling zshrc.' $i
	  	zcompile $i
  done
  fi
}

function tar-pbzip2() {
    tar cf $1 --use-compress-program=pbzip2 $argv[2,-1]
}

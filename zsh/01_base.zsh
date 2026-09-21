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
	compinit -d
	touch ${ZSHHOME}/compaudit_check
else
	compinit -C -d
fi

#setting keybind
bindkey -v

#setting cd history
setopt auto_pushd

#coloring ls
# TODO too slow
case "${OSTYPE}" in
	darwin*)
		if (( $+commands[gdircolors] )) && [[ -r ~/.dircolors ]]; then
			eval "$(gdircolors ~/.dircolors)"
		fi
		;;
	linux*)
		if (( $+commands[dircolors] )) && [[ -r ~/.dircolors ]]; then
			eval "$(dircolors ~/.dircolors)"
		fi
		;;
esac
[[ -n ${LS_COLORS:-} ]] && zstyle ':completion:*:default' list-colors ${LS_COLORS}

update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     echo 'compiling zshrc.' $i
     zcompile $i
  done
}

if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    export VISUAL=nvim
else
    export EDITOR=vim
    export VISUAL=vim
fi

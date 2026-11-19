zstyle :compinstall filename "${HOME}/.zshrc"
setopt extended_glob

bindkey -v # Use vi-style key bindings.
setopt auto_pushd # Save visited directories in the directory stack.

# Run the slower compinit -d only once every 24 hours.
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

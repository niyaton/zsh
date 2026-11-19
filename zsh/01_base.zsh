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

# Regenerate colors for the current and previously cached terminal types.
update_dircolors() {
  local dircolors_command
  case "$OSTYPE" in
    darwin*) dircolors_command=gdircolors ;;
    linux*) dircolors_command=dircolors ;;
    *) return ;;
  esac
  # :A resolves the ~/.zsh symlink; :h selects its parent (the repository).
  local dircolors_file="${ZSHHOME:A:h}/Dracula.dircolors"
  # Equivalent command check: ! command -v "$dircolors_command" >/dev/null
  if (( ! $+commands[$dircolors_command] )); then
    return
  fi

  local cache_dir="$ZSHHOME/.cache/dircolors"
  local cache_file="$cache_dir/${OSTYPE}-${TERM//\//_}.sh"
  command mkdir -p -- "$cache_dir" || return

  # -U removes duplicates; (N) allows no existing cache files.
  local -aU cache_files=("$cache_file" "$cache_dir/${OSTYPE}-"*.sh(N))
  local cached_file cached_term
  # Update the cached color settings for all listed terminal types.
  for cached_file in "${cache_files[@]}"; do
    # :t takes the filename; remove the OS prefix and .sh suffix to recover TERM.
    cached_term=${${cached_file:t}#${OSTYPE}-}
    cached_term=${cached_term%.sh}
    [[ "$cached_file" == "$cache_file" ]] && cached_term=$TERM
    TERM="$cached_term" "$dircolors_command" -b "$dircolors_file" > "$cached_file" || return
  done

  source "$cache_file" || return
  if [[ -n ${LS_COLORS:-} ]]; then
    zstyle ':completion:*:default' list-colors ${LS_COLORS}
  else
    zstyle -d ':completion:*:default' list-colors
  fi
}

# Normally just source the cache; regenerate caches when this terminal type is missing.
() {
  local cache_file="$ZSHHOME/.cache/dircolors/${OSTYPE}-${TERM//\//_}.sh"
  if [[ -r "$cache_file" ]]; then
    source "$cache_file"
  else
    update_dircolors
  fi
}
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

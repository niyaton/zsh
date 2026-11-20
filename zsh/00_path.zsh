typeset -U path fpath

# Avoid running brew at startup; occasionally ask Codex to compare this
# configuration with `brew shellenv zsh` and review any differences.
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}";

path=(
	"$HOME/local/bin"
	/usr/local/bin
	"${HOMEBREW_PREFIX}/bin"
	"${HOMEBREW_PREFIX}/sbin"
	$path
)

fpath+=("${HOMEBREW_PREFIX}/share/zsh/site-functions")

# -T ties INFOPATH to a colon-separated array, like PATH/path and MANPATH/manpath.
typeset -T INFOPATH infopath
typeset -U manpath infopath
# Keep one empty entry so the default documentation paths are still searched.
manpath=(/usr/local/share/man "${HOMEBREW_PREFIX}/share/man" "${manpath[@]}" "")
infopath=("${HOMEBREW_PREFIX}/share/info" "${infopath[@]}" "")
export FPATH MANPATH INFOPATH

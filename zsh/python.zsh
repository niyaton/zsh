case "${OSTYPE}" in
  darwin*)
    source ~/anaconda3/etc/profile.d/conda.sh
    ;;
  linux*)
    if which pyenv &> /dev/null; then eval "$(pyenv init -)"; fi
    # Initialize pyenv.
    # Only execute eval pyenv init on startup
    if [[ "$(whence -w pyenv 2>/dev/null )" != *(function|none) ]]; then
           eval "$(pyenv init -)"
    fi
    ;;
esac

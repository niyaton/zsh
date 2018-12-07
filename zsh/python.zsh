export VIRTUAL_ENV_DISABLE_PROMPT=1
case "${OSTYPE}" in
  darwin*)
    source ~/anaconda3/etc/profile.d/conda.sh
    export CONDA_CHANGEPS1=no
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

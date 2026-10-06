# Python: uv-managed

# uv-installed tools usually live here.
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Fallback for machines that still use pyenv while migrating to uv.
if ! command -v uv >/dev/null 2>&1 && [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"

  if [ -d "$PYENV_ROOT/bin" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
  fi

  if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
fi

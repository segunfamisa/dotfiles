# Mozilla/Firefox development

_mozilla_config_dir="${DOTFILES_CONFIG_DIR:-$HOME/.config/dotfiles}/mozilla"

export UV_PYTHON_INSTALL_DIR="$HOME/mozilla-source/.python"

# Automatically load the nearest Firefox workspace .venv via .envrc.
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if [ -f "$_mozilla_config_dir/worktree.sh" ]; then
  . "$_mozilla_config_dir/worktree.sh"
fi

GYP_PATH="$HOME/tools/gyp"
if [ -d "$GYP_PATH" ]; then
  export PATH="$GYP_PATH:$PATH"
fi

export NSS_DIR="$HOME/mozilla-source/application-services/libs/desktop/darwin-aarch64/nss"
export NSS_STATIC=1

unset _mozilla_config_dir

# Backwards-compatible entrypoint.
# Purpose-specific shell config lives in ~/.config/dotfiles/.

DOTFILES_CONFIG_DIR="$HOME/.config/dotfiles"
if [ -f "$DOTFILES_CONFIG_DIR/env.sh" ]; then
  . "$DOTFILES_CONFIG_DIR/env.sh"
fi
unset DOTFILES_CONFIG_DIR

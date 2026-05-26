# Backwards-compatible entrypoint.
# Aliases live in ~/.config/dotfiles/aliases.sh.

if [ -f "$HOME/.config/dotfiles/aliases.sh" ]; then
  . "$HOME/.config/dotfiles/aliases.sh"
fi

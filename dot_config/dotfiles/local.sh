# Optional local/private shell configuration.
# Add machine-specific, non-secret overrides here or source extra local files.

if [ -f "$HOME/.local-dotfiles.sh" ]; then
  . "$HOME/.local-dotfiles.sh"
fi

# Optional private secrets.
# This file intentionally delegates to ~/.secrets.sh, which should not be tracked.

if [ -f "$HOME/.secrets.sh" ]; then
  . "$HOME/.secrets.sh"
fi

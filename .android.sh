#!/bin/sh
# Backwards-compatible entrypoint.
# Android shell config lives in ~/.config/dotfiles/toolchains/android.sh.

if [ -f "$HOME/.config/dotfiles/toolchains/android.sh" ]; then
  . "$HOME/.config/dotfiles/toolchains/android.sh"
fi

# Flutter/Dart
#
# Homebrew installs the Flutter SDK at $HOMEBREW_PREFIX/share/flutter. Add its
# bin directory explicitly because the cask's command symlinks are not present
# in every Homebrew installation. This also supports an SDK unpacked at the
# conventional ~/development/flutter path.

if [ -n "${HOMEBREW_PREFIX:-}" ] && [ -d "$HOMEBREW_PREFIX/share/flutter/bin" ]; then
  export PATH="$HOMEBREW_PREFIX/share/flutter/bin:$PATH"
elif ! command -v flutter >/dev/null 2>&1 && [ -d "$HOME/development/flutter/bin" ]; then
  export PATH="$HOME/development/flutter/bin:$PATH"
fi

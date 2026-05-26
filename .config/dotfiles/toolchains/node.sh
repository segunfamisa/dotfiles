# Node.js: fnm

if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --shell zsh)"
elif [ -x /opt/homebrew/opt/fnm/bin/fnm ]; then
  eval "$(/opt/homebrew/opt/fnm/bin/fnm env --shell zsh)"
fi

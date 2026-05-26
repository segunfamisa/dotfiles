# Node.js: fnm

if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
elif [ -x /opt/homebrew/opt/fnm/bin/fnm ]; then
  eval "$(/opt/homebrew/opt/fnm/bin/fnm env --use-on-cd --shell zsh)"
fi

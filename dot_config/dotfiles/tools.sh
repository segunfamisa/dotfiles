# General developer/tooling setup

# fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# zoxide smart directory jumping
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Television shell integration
if command -v tv >/dev/null 2>&1; then
  eval "$(tv init zsh)"
fi

# Local binaries
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# LM Studio CLI (lms)
if [ -d "$HOME/.lmstudio/bin" ]; then
  export PATH="$PATH:$HOME/.lmstudio/bin"
fi

# Antigravity
if [ -d "$HOME/.antigravity/antigravity/bin" ]; then
  export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
fi

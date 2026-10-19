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

# jj shell completion
if command -v jj >/dev/null 2>&1; then
  source <(COMPLETE=zsh jj)
fi

# Android CLI completion
if command -v compdef >/dev/null 2>&1; then
  typeset -gA _android_completion_cache

  _android_help_commands() {
    local cache_key="${(j.:.)@}" output
    [[ -n $cache_key ]] || cache_key=root

    if (( ${+_android_completion_cache[$cache_key]} )); then
      print -r -- "${_android_completion_cache[$cache_key]}"
      return
    fi

    if (( $# == 0 )); then
      output=$(android --help 2>/dev/null)
    else
      output=$(android "$@" --help 2>/dev/null)
    fi

    output=$(print -r -- "$output" | awk '
      /^  [a-z][a-z0-9-]*[[:space:]]+/ {
        name = $1
        sub(/^[^[:space:]]+[[:space:]]*/, "")
        sub(/[[:space:]]+$/, "")
        print name ":" $0
      }
    ')

    _android_completion_cache[$cache_key]="$output"
    print -r -- "$output"
  }

  _android() {
    local -a command_path commands

    if (( CURRENT > 2 )); then
      command_path=("${words[2,$((CURRENT - 1))]}")
    fi

    commands=("${(@f)$(_android_help_commands "${command_path[@]}")}")
    _describe 'command' commands
  }

  compdef _android android
fi

# Google Cloud SDK (PATH + zsh completion)
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

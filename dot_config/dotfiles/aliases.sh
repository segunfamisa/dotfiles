# Shell aliases and lightweight shortcuts

# Run a command and fuzzy-search its output, e.g. `f git branch`.
f() {
  if ! command -v fzf >/dev/null 2>&1; then
    printf '%s\n' "f: fzf is not installed" >&2
    return 127
  fi

  if [ "$#" -eq 0 ]; then
    fzf
  else
    "$@" | fzf
  fi
}

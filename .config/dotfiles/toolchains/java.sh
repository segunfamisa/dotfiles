# Java: jenv

if [ -d "$HOME/.jenv/bin" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
fi

if command -v jenv >/dev/null 2>&1; then
  eval "$(jenv init -)"
fi

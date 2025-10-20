# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# GitHub tokens stored in a .gh file
GH_SECRETS=$HOME/.ghsecrets
if [ -f $GH_SECRETS ]; then
  source $GH_SECRETS
fi

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# jenv/java set up
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pyenv/python set up
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pipx executables
if [ -e $HOME/.local/bin ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# rbevn set up
eval "$(rbenv init -)"

# RUST
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.cargo/env"

# LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"

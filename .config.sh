# Firefox
FIREFOX_ALIASES=$HOME/.firefox.sh
if [ -f $FIREFOX_ALIASES ]; then
  source $FIREFOX_ALIASES
fi

GYP_PATH=$HOME/tools/gyp
if [ -e $GYP_PATH ]; then
  export PATH="~/tools/gyp:$PATH"
fi
export NSS_DIR=$HOME/Dev/firefox/tools/application-services/libs/desktop/darwin-aarch64/nss
export NSS_STATIC=1

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Secrets
SECRETS_FILE=$HOME/.secrets.sh
if [ -f $SECRETS_FILE ]; then
  source $SECRETS_FILE
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

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "$(fnm env --shell zsh)"
fi

# ZSH extensions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/.android.sh
source ~/.aliases.sh

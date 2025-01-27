# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# jenv/java set up
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Android config
export ANDROID_HOME=~/Library/Android/sdk
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# Perfetto set up
PERFETTO_HOME=$HOME/.perfetto
PERFETTO_RECORD_TRACE=$PERFETTO_HOME/record_android_trace
if [ ! -f $PERFETTO_RECORD_TRACE ]; then
  mkdir -p $PERFETTO_HOME
  curl -o $PERFETTO_HOME/record_android_trace https://raw.githubusercontent.com/google/perfetto/main/tools/record_android_trace
fi
chmod +x $HOME/.perfetto/record_android_trace
export PATH="$PERFETTO_HOME:$PATH"

# pyenv/python set up
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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

# Android config
export ANDROID_HOME=~/Library/Android/sdk
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# Perfetto set up
PERFETTO_HOME=$HOME/.perfetto
PERFETTO_RECORD_TRACE=$PERFETTO_HOME/record_android_trace
PERFETTO_HEAP_PROFILE=$PERFETTO_HOME/heap_profile
PERFETTO_HEAP_DUMP=$PERFETTO_HOME/java_heap_dump
# download record trace
if [ ! -f $PERFETTO_RECORD_TRACE ]; then
  mkdir -p $PERFETTO_HOME
  curl -Lo $PERFETTO_RECORD_TRACE https://raw.githubusercontent.com/google/perfetto/main/tools/record_android_trace
  chmod +x $PERFETTO_RECORD_TRACE
fi
# download heap profile
if [ ! -f $PERFETTO_HEAP_PROFILE ]; then
  mkdir -p $PERFETTO_HOME
  curl -Lo $PERFETTO_HEAP_PROFILE https://raw.githubusercontent.com/google/perfetto/main/tools/heap_profile
  chmod +x $PERFETTO_HEAP_PROFILE
fi
# download java heap dump
if [ ! -f $PERFETTO_HEAP_DUMP ]; then
  mkdir -p $PERFETTO_HOME
  curl -Lo $PERFETTO_HEAP_DUMP https://raw.githubusercontent.com/google/perfetto/refs/heads/main/tools/java_heap_dump
  chmod +x $PERFETTO_HEAP_DUMP
fi
export PATH="$PERFETTO_HOME:$PATH"

# pyenv/python set up
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

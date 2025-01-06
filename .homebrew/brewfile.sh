cask_args appdir: "/Applications"

# install packages + some apps
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"

# apps casks
cask "iterm2"
cask "slack"
cask "notion"
cask "visual-studio-code"

# jdk casks
cask "temurin@17"
cask "temurin@21"

# brews
brew "git"
brew "jenv"
brew "pyenv"
brew "python@3.10"
brew "rbenv"
brew "scrcpy"
brew "zsh"
brew "zsh-completions"

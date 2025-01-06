cask_args appdir: "/Applicatoins"

# install packages + some apps
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"

# apps casks
cask "iterm2"
cask "slack"
cask "notion"

# jdk casks
cask "temurin@17"
cask "temurin@21"

# brews
brew "git"
brew "jenv"
brew "pyenv"
brew "scrcpy"
brew "zsh"
brew "zsh-completions"

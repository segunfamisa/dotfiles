# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
# See https://github.com/ohmyzsh/ohmyzsh/
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Environment configuration
source ~/.config.sh
source ~/.aliases.sh

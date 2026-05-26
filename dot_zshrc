# Path to your Oh My Zsh installation.
# See https://github.com/ohmyzsh/ohmyzsh/
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  . "$ZSH/oh-my-zsh.sh"
fi

# Environment configuration
DOTFILES_CONFIG_DIR="$HOME/.config/dotfiles"
if [ -f "$DOTFILES_CONFIG_DIR/init.sh" ]; then
  . "$DOTFILES_CONFIG_DIR/init.sh"
fi
unset DOTFILES_CONFIG_DIR

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

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/sf/.lmstudio/bin"
# End of LM Studio CLI section


# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi

# Added by Antigravity
export PATH="/Users/sf/.antigravity/antigravity/bin:$PATH"

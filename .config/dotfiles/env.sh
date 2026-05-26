# Main shell environment entrypoint.
# Keep this file focused on load order and put purpose-specific setup in sibling files.

_dotfiles_config_dir="${DOTFILES_CONFIG_DIR:-$HOME/.config/dotfiles}"

source_if_exists() {
  file="$1"
  if [ -f "$file" ]; then
    . "$file"
  fi
}

source_if_exists "$_dotfiles_config_dir/homebrew.sh"
source_if_exists "$_dotfiles_config_dir/secrets.sh"
source_if_exists "$_dotfiles_config_dir/toolchains.sh"
source_if_exists "$_dotfiles_config_dir/firefox.sh"
source_if_exists "$_dotfiles_config_dir/tools.sh"
source_if_exists "$_dotfiles_config_dir/aliases.sh"
source_if_exists "$_dotfiles_config_dir/local.sh"

unset _dotfiles_config_dir file
unset -f source_if_exists 2>/dev/null || unfunction source_if_exists 2>/dev/null

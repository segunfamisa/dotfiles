# Main shell environment entrypoint.
# Keep this file focused on load order and put purpose-specific setup in sibling files.

_dotfiles_config_dir="${DOTFILES_CONFIG_DIR:-$HOME/.config/dotfiles}"

__dotfiles_source_if_exists() {
  __dotfiles_file="$1"
  if [ -f "$__dotfiles_file" ]; then
    . "$__dotfiles_file"
  fi
}

__dotfiles_source_if_exists "$_dotfiles_config_dir/homebrew.sh"
__dotfiles_source_if_exists "$_dotfiles_config_dir/secrets.sh"
__dotfiles_source_if_exists "$_dotfiles_config_dir/toolchains.sh"
__dotfiles_source_if_exists "$_dotfiles_config_dir/firefox.sh"
__dotfiles_source_if_exists "$_dotfiles_config_dir/tools.sh"
__dotfiles_source_if_exists "$_dotfiles_config_dir/aliases.sh"
__dotfiles_source_if_exists "$_dotfiles_config_dir/local.sh"

unset _dotfiles_config_dir __dotfiles_file
unset -f __dotfiles_source_if_exists 2>/dev/null || unfunction __dotfiles_source_if_exists 2>/dev/null

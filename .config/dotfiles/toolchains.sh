# Development toolchains and SDKs.

_dotfiles_config_dir="${DOTFILES_CONFIG_DIR:-$HOME/.config/dotfiles}"
_dotfiles_toolchains_dir="$_dotfiles_config_dir/toolchains"

source_if_exists() {
  file="$1"
  if [ -f "$file" ]; then
    . "$file"
  fi
}

source_if_exists "$_dotfiles_toolchains_dir/java.sh"
source_if_exists "$_dotfiles_toolchains_dir/python.sh"
source_if_exists "$_dotfiles_toolchains_dir/ruby.sh"
source_if_exists "$_dotfiles_toolchains_dir/rust.sh"
source_if_exists "$_dotfiles_toolchains_dir/node.sh"
source_if_exists "$_dotfiles_toolchains_dir/android.sh"

unset _dotfiles_config_dir _dotfiles_toolchains_dir file
unset -f source_if_exists 2>/dev/null || unfunction source_if_exists 2>/dev/null

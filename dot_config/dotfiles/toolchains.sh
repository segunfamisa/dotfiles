# Development toolchains and SDKs.

_dotfiles_config_dir="${DOTFILES_CONFIG_DIR:-$HOME/.config/dotfiles}"
_dotfiles_toolchains_dir="$_dotfiles_config_dir/toolchains"

__dotfiles_toolchains_source_if_exists() {
  __dotfiles_toolchains_file="$1"
  if [ -f "$__dotfiles_toolchains_file" ]; then
    . "$__dotfiles_toolchains_file"
  fi
}

__dotfiles_toolchains_source_if_exists "$_dotfiles_toolchains_dir/java.sh"
__dotfiles_toolchains_source_if_exists "$_dotfiles_toolchains_dir/python.sh"
__dotfiles_toolchains_source_if_exists "$_dotfiles_toolchains_dir/ruby.sh"
__dotfiles_toolchains_source_if_exists "$_dotfiles_toolchains_dir/rust.sh"
__dotfiles_toolchains_source_if_exists "$_dotfiles_toolchains_dir/node.sh"
__dotfiles_toolchains_source_if_exists "$_dotfiles_toolchains_dir/android.sh"

unset _dotfiles_config_dir _dotfiles_toolchains_dir __dotfiles_toolchains_file
unset -f __dotfiles_toolchains_source_if_exists 2>/dev/null || unfunction __dotfiles_toolchains_source_if_exists 2>/dev/null

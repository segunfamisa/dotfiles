#!/usr/bin/env bash
set -euo pipefail

readonly REPO_URL="https://github.com/segunfamisa/dotfiles.git"
readonly DOTFILES_DIR="$HOME/.dotfiles"
readonly BACKUP_DIR="$HOME/.dotfiles-backup"

dotfiles() {
  /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

checkout_dotfiles() {
  if dotfiles checkout; then
    echo "Checked out dotfiles."
    return 0
  fi

  echo "Existing files conflict with dotfiles checkout."
  echo "Backing them up to $BACKUP_DIR."
  mkdir -p "$BACKUP_DIR"

  dotfiles checkout 2>&1 \
    | grep -E "^[[:space:]]+\." \
    | awk '{print $1}' \
    | while IFS= read -r file; do
        if [ -e "$HOME/$file" ] || [ -L "$HOME/$file" ]; then
          mkdir -p "$BACKUP_DIR/$(dirname "$file")"
          mv "$HOME/$file" "$BACKUP_DIR/$file"
        fi
      done

  dotfiles checkout
  echo "Checked out dotfiles after backing up conflicts."
}

main() {
  cd "$HOME"

  if [ -d "$DOTFILES_DIR" ]; then
    echo "Dotfiles repository already exists at $DOTFILES_DIR."
  else
    echo "Cloning dotfiles repository to $DOTFILES_DIR."
    git clone --bare "$REPO_URL" "$DOTFILES_DIR"
  fi

  checkout_dotfiles
  dotfiles config status.showUntrackedFiles no

  echo "Dotfiles installed successfully."
}

main "$@"

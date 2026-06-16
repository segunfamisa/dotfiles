# --- FIREFOX WORKTREE KIT ---
unalias fgit 2>/dev/null

fgit() {
  local COMMAND="$1"
  local BASE_DIR="$HOME/mozilla-source/firefox"
  local HUB_DIR="$BASE_DIR/bare"
  local WT_DIR="$BASE_DIR/worktrees"

  case "$COMMAND" in
    setup)
      # Updated for new visible folder names
      shift
      local MAIN_BR="${1:-main}"
      [[ ! -d ".git" ]] && echo "❌ Run from inside a repo!" && return 1
      
      mv .git "$HUB_DIR"
      git --git-dir="$HUB_DIR" config --bool core.bare true
      git --git-dir="$HUB_DIR" branch -m "$MAIN_BR"
      mkdir -p "$WT_DIR"
      
      git --git-dir="$HUB_DIR" worktree add "$WT_DIR/artifact" "$MAIN_BR"
      git --git-dir="$HUB_DIR" worktree add "$WT_DIR/full" "$MAIN_BR" --detach

      echo "ac_add_options --enable-project=mobile/android" > "$WT_DIR/artifact/mozconfig"
      echo "ac_add_options --enable-artifact-builds\nmk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-artifact" >> "$WT_DIR/artifact/mozconfig"
      echo "mk_add_options AUTOCLOBBER=1" >> "$WT_DIR/artifact/mozconfig"

      echo "ac_add_options --enable-project=mobile/android" > "$WT_DIR/full/mozconfig"
      echo "mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj-full" >> "$WT_DIR/full/mozconfig"
      echo "mk_add_options AUTOCLOBBER=1" >> "$WT_DIR/full/mozconfig"
      ;;

    new)
      shift
      local REBASE=false
      local BUILD_TYPE="artifact"
      while [[ "$1" == -* ]]; do
        case "$1" in
          -r) REBASE=true ;;
          --full) BUILD_TYPE="full" ;;
        esac
        shift
      done
      
      local NEW_BR="$1"
      local BASE_BR="${2:-main}"
      local TARGET="$WT_DIR/$NEW_BR"
      local START_POINT="$BASE_BR"

      if [[ -z "$NEW_BR" ]]; then
        echo "Usage: fgit new [-r] [--full] <branch-name> [base-branch]"
        return 1
      fi

      if [[ "$REBASE" == "true" ]]; then
        echo "Fetching latest from origin..."
        git --git-dir="$HUB_DIR" fetch origin
        START_POINT="origin/$BASE_BR"
      fi

      echo "Creating worktree '$NEW_BR' from '$START_POINT'..."
      git --git-dir="$HUB_DIR" worktree add "$TARGET" -b "$NEW_BR" "$START_POINT"
      
      if [[ $? -eq 0 ]]; then
        local CONFIG_SRC="$WT_DIR/artifact/mozconfig"
        [[ "$BUILD_TYPE" == "full" ]] && CONFIG_SRC="$WT_DIR/full/mozconfig"
        [[ -f "$CONFIG_SRC" ]] && cp "$CONFIG_SRC" "$TARGET/mozconfig"
        cd "$TARGET"
      fi
      ;;

    clean)
      shift
      local AUTO_DELETE=false
      [[ "$1" == "-d" ]] && AUTO_DELETE=true && shift
      
      for NAME in "$@"; do
        local TARGET="$WT_DIR/$NAME"
        if [[ -d "$TARGET" ]]; then
          echo "Removing worktree: $NAME"
          git --git-dir="$HUB_DIR" worktree remove "$TARGET"
          if [[ "$AUTO_DELETE" == "true" ]]; then
             git --git-dir="$HUB_DIR" branch -D "$NAME"
          else
             read "response?Delete branch '$NAME'? (y/n) "
             [[ "$response" =~ ^([yY])$ ]] && git --git-dir="$HUB_DIR" branch -D "$NAME"
          fi
        fi
      done
      ;;

    *)
      git --git-dir="$HUB_DIR" "$@"
      ;;
  esac
}

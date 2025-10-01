#!/usr/bin/env bash
### ------------------------ symlink dotfiles repo ------------------------ ###

symlink_dir_contents() {
  TARGET_DIR=$3/${1##$2/}
  ! [ -d "$TARGET_DIR" ] && mkdir -p "$TARGET_DIR"
  for FILE in "$1/"*; do
    symlink_file "$FILE" "$2" "$3"
  done
}

symlink_file() {
  ln -fns "$1" "$3/${1##$2/}"
}

symlink_repo_dotfiles() {
  echo "-> Symlinking dotfiles into home directory."
  DOT_DIR=$HOME/.dotfiles
  IGNORES=("$DOT_DIR/.git" "$DOT_DIR/.github" "$DOT_DIR/.gitignore")
  for DOTFILE in "$DOT_DIR/."*; do
    if ! [[ ${IGNORES[*]} =~ $DOTFILE ]]; then
      [ -d "$DOTFILE" ] && symlink_dir_contents "$DOTFILE" "$DOT_DIR" "$HOME"
      [ -f "$DOTFILE" ] && symlink_file "$DOTFILE" "$DOT_DIR" "$HOME"
    fi
  done
  ln -fns "$DOT_DIR/Brewfile" "$HOME/.Brewfile"
}


if symlink_repo_dotfiles; then
  echo "-> Symlinking successful. Finishing up..."
  chmod 700 "$HOME"/.gnupg
  chmod 600 "$HOME"/.gnupg/gpg.conf
  echo "-> Finished."
else
  echo "-> Symlinking unsuccessful."
  ! [ -d "$HOME"/.dotfiles ] && echo "-> Error: Dotfiles directory not found."
fi

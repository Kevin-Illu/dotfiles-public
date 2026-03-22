#!/bin/bash

set -e
set -x

DOTFILES_DIR=$(pwd)

detect_system() {
  # detecting Android with termux
  if [ -d /data/data/com.termux ]; then
    echo "termux"
    return
  fi

  # detection arch linux
  if [ -f /etc/os-release ]; then
    . /etc/os-release # loads ID, NAME, etc

    case "$ID" in
    arch)
      echo "arch"
      return
      ;;
    esac
  fi

  echo "unknown"
}

declare -A SYSTEM_SUPPORTED=(
  [arch]="Arch Linux"
  [termux]="Android (Termux)"
  [unknown]="Unknown"
)

link_file() {
  local src="$1"
  local dst="$2"

  # Create parent directory if it doesn't exist (e.g., .config)
  mkdir -p "$(dirname "$dst")"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "[b] Backing up $dst to ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  echo "[c] Linking $dst -> $src"
  ln -sfn "$src" "$dst"
}

setup_arch() {
  echo "Arch setup starting..."
  # link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
  # link_file "$DOTFILES_DIR/fish" "$HOME/.config/fish"
}

setup_termux() {
  echo "Termux setup starting..."

  pkg update && pkg upgrade -y
  pkg install -y git curl nvim fish tmux termux-api termux-exec

  termux-wake-lock

  if [ ! -d "$HOME/storage" ]; then
    echo "Requesting storage permissions..."
    termux-setup-storage
  fi

  link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

  if [ "$SHELL" != "$(which fish)" ]; then
    chsh -s "$(which fish)"
  fi

  termux-wake-unlock
}

# ------------ MAIN EXECUTION ---------------------
SYSTEM="$(detect_system)"

if [ "$SYSTEM" = "unknown" ]; then
  echo "x Error: System not supported."
  exit 1
fi

echo "System: [${SYSTEM_SUPPORTED[$SYSTEM]}] detected"

echo "Starting setup from $DOTFILES_DIR ..."

case "$SYSTEM" in
arch) setup_arch ;;
termux) setup_termux ;;
esac

echo "Setup completed!"

#!/bin/bash

set -e

REPO_DIR="$(pwd)"
TARGET_HOME="$HOME"

# Function: Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

echo "[*] Checking for zsh..."
if ! command_exists zsh; then
    echo "[!] zsh not found. Installing..."

    if command_exists apt; then
        sudo apt update && sudo apt install -y zsh
    elif command_exists dnf; then
        sudo dnf install -y zsh
    elif command_exists pacman; then
        sudo pacman -Sy --noconfirm zsh
    else
        echo "[!] Package manager not recognized. Please install zsh manually."
        exit 1
    fi

    # Re-check if zsh is actually installed now
    if ! command_exists zsh; then
        echo "[✘] Zsh installation failed or zsh not found in PATH. Exiting."
        exit 1
    fi
else
    echo "[*] zsh is already installed."
fi

echo "[*] Installing Oh My Zsh (base) if not present..."
if [ ! -d "$TARGET_HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "[*] Replacing ~/.oh-my-zsh with your custom version..."
rm -rf "$TARGET_HOME/.oh-my-zsh"
mv "$REPO_DIR/.oh-my-zsh" "$TARGET_HOME/.oh-my-zsh"

echo "[*] Copying your zshrc as ~/.zshrc..."
cp "$REPO_DIR/.zshrc" "$TARGET_HOME/.zshrc"

echo "[*] Setting default shell to zsh for user $USER..."
chsh -s "$(which zsh)" "$USER"

echo "[✔] Done. Open a new terminal or run 'zsh' to use it."

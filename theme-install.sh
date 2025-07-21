#!/bin/bash

# Exit if not run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (with sudo)"
  exit 1
fi

# Get the directory this bash script is located in (repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the Python script in the subdirectory
PYTHON_SCRIPT="$SCRIPT_DIR/darkmatter-grub-theme/darkmatter-theme.py"

# Check that the script exists
if [ ! -f "$PYTHON_SCRIPT" ]; then
  echo "Error: Python script not found at $PYTHON_SCRIPT"
  exit 1
fi

# Usage help
if [[ "$1" != "-i" && "$1" != "--install" && "$1" != "-u" && "$1" != "--uninstall" ]]; then
  echo "Usage: $0 -i|--install or -u|--uninstall"
  exit 1
fi

# Run the Python script with the argument
python3 "$PYTHON_SCRIPT" "$1"

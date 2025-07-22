#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (with sudo)"
  exit 1
fi

# Get absolute path to the directory this script is in (installer/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Resolve path to the Python script in ../darkmatter-grub-theme/
PYTHON_SCRIPT="$SCRIPT_DIR/../darkmatter-grub-theme/darkmatter-theme.py"

# Check that the Python script exists
if [ ! -f "$PYTHON_SCRIPT" ]; then
  echo "Error: Python script not found at $PYTHON_SCRIPT"
  exit 1
fi

# Usage validation
if [[ "$1" != "-i" && "$1" != "--install" && "$1" != "-u" && "$1" != "--uninstall" ]]; then
  echo "Usage: $0 -i|--install or -u|--uninstall"
  exit 1
fi

# Run the Python script with argument
python3 "$PYTHON_SCRIPT" "$1"

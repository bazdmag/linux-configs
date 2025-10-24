#!/bin/bash

# Get current working directory
CWD=$(pwd)

# Source and destination paths
THEME_SRC="$CWD/OS-themes/Mint-Y-Blue"
THEME_DEST="$HOME/.themes"

ICON_SRC="$CWD/OS-themes/bibata-Modern-Classic"
ICON_DEST="$HOME/.icons"

# Create destination directories if they don't exist
mkdir -p "$THEME_DEST"
mkdir -p "$ICON_DEST"

# Move the theme and icon folders
if [ -d "$THEME_SRC" ]; then
    cp -r "$THEME_SRC" "$THEME_DEST/"
    echo "Moved Mint-Y-blue theme to $THEME_DEST"
else
    echo "Theme folder not found: $THEME_SRC"
fi

if [ -d "$ICON_SRC" ]; then
    cp -r "$ICON_SRC" "$ICON_DEST/"
    echo "Moved bibata-Modern-Classic icons to $ICON_DEST"
else
    echo "Icon folder not found: $ICON_SRC"
fi

echo "reloading Dconf settings"
donf load / < "$CWD/OS-themes/dconf-settings.ini"

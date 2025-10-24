#!/bin/bash




echo "Starting installion please wait..." 

echo "running GRUB theme installion"
sudo $(pwd)/darkmatter-grub-theme/darkmatter-theme.py -i

echo "Running GRUB btrfsinstallion"
sudo $(pwd)/.grub-btrfs.sh

echo "Running user theme installer"
$(pwd)/.OS-theme.sh

echo "Running shell config installer"
$(pwd)/.zsh.sh

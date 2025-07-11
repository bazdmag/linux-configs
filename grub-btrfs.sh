#!/bin/bash

set -e

REPO_URL="https://github.com/Antynea/grub-btrfs.git"
REPO_DIR="$HOME/grub-btrfs"

echo "[*] Disabling grub-btrfs services..."
sudo systemctl disable --now grub-btrfs.path grub-btrfsd.service || true

echo "[*] Removing old grub-btrfs files..."
sudo rm -f /usr/bin/grub-btrfs
sudo rm -f /etc/grub.d/41_snapshots-btrfs
sudo rm -rf /etc/default/grub-btrfs
sudo rm -f /usr/lib/systemd/system/grub-btrfs.*

echo "[*] Cloning latest grub-btrfs from GitHub..."
rm -rf "$REPO_DIR"
git clone "$REPO_URL" "$REPO_DIR"

echo "[*] Installing grub-btrfs..."
cd "$REPO_DIR"
sudo make install

echo "[*] Configuring grub-btrfsd.service for Timeshift snapshots..."
SERVICE_FILE="/etc/systemd/system/grub-btrfsd.service"

sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=Regenerate grub-btrfs.cfg

[Service]
Type=simple
LogLevelMax=notice
Environment="PATH=/sbin:/bin:/usr/sbin:/usr/bin"
EnvironmentFile=/etc/default/grub-btrfs/config
ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto

[Install]
WantedBy=multi-user.target
EOF

echo "[*] Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "[*] Updating GRUB configuration..."
sudo update-grub

echo "[*] Enabling grub-btrfs services..."
sudo systemctl enable --now grub-btrfs.path grub-btrfsd.service

echo "[✔] grub-btrfs installed and configured for Timeshift snapshots successfully."

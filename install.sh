#!/usr/bin/env nix-shell
#!nix-shell -p vim git --run "bash ./install.sh"

# repo
REPO_URL="https://github.com/unlucky-shen/nixos.git"
CLONE_DIR="$HOME/nixos-config"

# clone
echo "Cloning from $REPO_URL..."
rm -rf "$CLONE_DIR"
git clone "$REPO_URL" "$CLONE_DIR"

# backup
echo "Backing up current configuration to /etc/nixos/*.bak..."
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak

# replace configuration.nix
echo "Replacing config"
sudo cp "$CLONE_DIR/configuration.nix" /etc/nixos/configuration.nix

# apply changes
echo "Rebuilding NixOS..."
sudo nixos-rebuild switch

echo "Done! backup is at /etc/nixos/configuration.nix.bak"

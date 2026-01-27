#!/usr/bin/env nix-shell
#!nix-shell -p vim git --run "bash ./nixify.sh"

REPO_URL="https://github.com/unlucky-shen/nixos.git"
CLONE_DIR="$HOME/nixify"

echo "
####################
### Cloning Repo ###
####################
"
rm -rf "$CLONE_DIR"
git clone "$REPO_URL" "$CLONE_DIR"

echo "
###################################
### Replacing Configuration.nix ###
###################################
"
sudo cp "$CLONE_DIR/configuration.nix" /etc/nixos/configuration.nix

echo "
########################
### Rebuilding NixOS ###
########################
"
sudo nixos-rebuild switch

echo "
#######################
### Moving Dotfiles ###
#######################
"
cd "$CLONE_DIR/"
sudo cp auto-cpufreq.conf /etc/
sudo cp .bashrc /home/tau/
sudo cp starship.toml /home/tau/.config/
sudo cp -r hypr/ /home/tau/.config/
chmod +x nixssh.sh
./nixssh.sh
cd ~

echo "
####################################
### All Set! Rebooting System... ###
####################################
"
sudo systemctl reboot

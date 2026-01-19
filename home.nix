{ config, pkgs, ... }:

{
  home.username = "tau";
  home.homeDirectory = "/home/tau";
  programs.git.enable = true;
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      rs = "sudo nixos-rebuild switch";
			v = "nvim";
    };
  };
}

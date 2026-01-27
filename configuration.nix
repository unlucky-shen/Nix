{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  
	boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];

	services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

	boot.supportedFilesystems = [ "ntfs" "exfat" ];
  
	# nvidia PRIME offload
	hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
		prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

	# wayland tweaks
	environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";
	};

	xdg.portal = {
    	enable = true;
    	extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  	};

	# systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Tau";

  networking.networkmanager.enable = true;

	# hyprland
	programs.hyprland = {
  	enable = true;
  	xwayland.enable = true;
	};

	# sddm
	services.displayManager.sddm = {
    	enable = true;
    	wayland.enable = true;
  	};

  # sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # user
  users.users.tau= {
    isNormalUser = true;
    description = "shen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # programs 
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.nm-applet.enable = true;

  environment.systemPackages = with pkgs; 
[
	# core utils
  	wget curl neovim xclip wl-clipboard unzip p7zip libarchive flatpak htop openssh fzf ripgrep fd eza bat auto-cpufreq killall networkmanagerapplet

	# dev tools
	git gcc gnumake cmake gfortran python3 uv rustup typst starship

	# lsp
	clang-tools lua-language-server rust-analyzer tinymist

	# apps
  	kitty zathura libreoffice fastfetch

	# Hyprland essentials
	hyprpolkitagent dunst waybar libappindicator libayatana-appindicator wofi swww hyprsunset hypridle hyprshot kdePackages.dolphin udiskie ntfs3g exfat

	# Misc
	bibata-cursors
];
  
	# fonts
	fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];

	# services
  services.flatpak.enable = true;
	services.openssh.enable = true;
	services.udisks2.enable = true;
  
	networking.firewall.enable = true;

	nixpkgs.config.allowUnfree = true;
	
	system.stateVersion = "25.11";
}

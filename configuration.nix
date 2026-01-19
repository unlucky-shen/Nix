{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  
	boot.kernelParams = [ 
  	"nvidia-drm.modeset=1"
  	"nvidia-drm.fbdev=1"
	];

  # Nvidia PRIME Offload
  services.xserver.videoDrivers = [
		"modesetting"
	  "nvidia"
	];
  
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

	environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";
	};

	# Systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Tau"; # Host

  networking.networkmanager.enable = true; # Wifi

	# DE
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;

  # Gdm
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # Pipewire 
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User
  users.users.tau= {
    isNormalUser = true;
    description = "shen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Programs 
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; 
[
	# core utils
  wget 
	curl
	neovim
	xclip
	wl-clipboard
	unzip
	p7zip
	libarchive
	flatpak 
	htop 
	openssh
	fzf 
	ripgrep 
	fd
	eza
	bat

	# dev tools
	git
	gh
	gcc 
	gnumake
	cmake
	gfortran 
	python3 
	uv 
	rustup 
	typst
	starship

	# lsp
	clang-tools
	lua-language-server
	rust-analyzer
	tinymist

	# apps
  kitty 
	zathura 
	libreoffice
	fastfetch

	# Gnome essentials
	gnomeExtensions.appindicator
	gnomeExtensions.blur-my-shell
	gnome-tweaks

	# Misc
	bibata-cursors
];
  
	# Fonts
	fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];

	# Services
  services.flatpak.enable = true;
	services.openssh.enable = true;
  
	networking.firewall.enable = true; # Firewall

	nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.11";
}

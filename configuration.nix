{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  
		boot.kernelParams = [ 
  "nvidia-drm.modeset=1"
  "nvidia-drm.fbdev=1"
	];

  # Nvidia + PRIME Offload
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

  # Host
  networking.hostName = "Tau";

  # Wifi 
  networking.networkmanager.enable = true;

  # Timezone/Locales
  time.timeZone = "Asia/Kuala_Lumpur";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

	# GNOME
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

  # Enable Programs 
  programs.neovim = {
		enable = true;
		defaultEditor = true;
	};
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # User Packages
  environment.systemPackages = with pkgs; 
[
	# core utils
  wget 
	curl
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

	# dev Tools
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

	# apps
  kitty 
	zathura 
	libreoffice

	# Gnome essentials
	gnomeExtensions.appindicator
	gnomeExtensions.blur-my-shell
	gnome-tweaks
];
  
	# Fonts
	fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];

	# Flatpak
  services.flatpak.enable = true;
  
	# Firewall
	networking.firewall.enable = true;

	system.stateVersion = "25.11"; # Jangan sial
}

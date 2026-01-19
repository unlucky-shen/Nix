{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
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
  
	# Wayland
	environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

	# Hyprland
	programs.hyprland.enable = true;

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

  # Gdm
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

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
	tree-sitter-cli 
	rustup 
	typst

	# apps
  kitty 
	zathura 
	libreoffice

	# wayland 
	waybar
  rofi-wayland
  swww
  mako
  libnotify
];
  
	# Flatpak
  services.flatpak.enable = true;
  # Remote, flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  
	networking.firewall.enable = true;
}

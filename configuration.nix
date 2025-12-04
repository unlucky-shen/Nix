{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

	# NVIDIA on Wayland
	
	# Load nvidia/igpu driver for Xorg/Wayland
  services.xserver.videoDrivers = [
		"modesetting" # use "amdgpu" here instead if iGPU is AMD
	  "nvidia"
	];
  
	# Nvidia Settings
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; # Enable if graphical issues occur after suspend.
    powerManagement.finegrained = true; # Turns off GPU when not in use (Turing/newer)
    open = false;
    nvidiaSettings = true; # Nvidia settings menu, enable using `nvidia-settings`
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
		# Nvidia Optimus PRIME (Offload)
		prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0"; # amdgpuBusId = "PCI:54:0:0"; (AMD GPU example)
    };
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Host
  networking.hostName = "Tau";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Networking
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Asia/Kuala_Lumpur";

  # Locales / Encoding
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

  # ENABLE X11 WINDOWING SYSTEM
  services.xserver.enable = true;

  # ENABLE GNOME DESKTOP ENVIRONMENT
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # CONFIGURE KEYMAP IN X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # CUPS FOR DOCUMENT PRINTING
  # services.printing.enable = true;

  # ENABLE SOUND (PIPEWIRE)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Touchpad Support
  # services.xserver.libinput.enable = true;

  # User
  users.users.shen = {
    isNormalUser = true;
    description = "shen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # System-wide Packages
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # User Packages
  environment.systemPackages = with pkgs; 
[
	# Core Utils
  wget 
	curl
	wl-clipboard
	unzip
	p7zip
	libarchive
	flatpak 
	neovim 
	htop 
	openssh
	fzf 
	ripgrep 
	fd

	# Dev Tools
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
	r 
		(rWrapper.override { 
      		packages = with rPackages; [ rmarkdown dplyr ggplot2 readr readxl writexl ];
    	})
	typst

	# Apps
  kitty 
	zathura 
	libreoffice

	# Gnome essentials
	gnomeExtensions.appindicator
	gnomeExtensions.blur-my-shell
	gnome-tweaks
];
  
  # SUID WRAPPERS (CAN BE CONFIGURED FURTHER OR STARTED IN USER SESSIONS)
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # System Services
  # Flatpak
  services.flatpak.enable = true;
  # Remote, flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

  # Openssh Daemon
  # services.openssh.enable = true;

  # Firewall Ports
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # System State Version
  system.stateVersion = "25.05";
}

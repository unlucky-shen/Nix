{ config, pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  
	boot.kernelParams = [ 
		"nvidia-drm.modeset=1" 
		"nvidia-drm.fbdev=1" 
		"nvidia.NVreg_TemporaryFilePath=/var/tmp"
	];

	services.xserver.videoDrivers = [ 
		"modesetting" 
		"nvidia" 
	];
  
	# fxck nvidia
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

	# fxck wayland too
	environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";
	};

	xdg.portal = {
    	enable = true;
    	extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  	};

	xdg.userDirs = {
  		enable = true;
  		createDirectories = true;
	};

	# Systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Tau"; # Host

  networking.networkmanager.enable = true; # Wifi

	# Hyprland
	programs.hyprland = {
    nvidiaPatches = true;
  	enable = true;
  	xwayland.enable = true; # Ensures legacy X11 apps still work
	};

	# Greeter
	services.greetd = {
  enable = true;
  	settings = {
    	default_session = {
      	command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start hyprland-uwsm.desktop'";
      	user = "greeter";
    	};
  	};
	};

	systemd.services.greetd.serviceConfig = {
  	Type = "idle";
  	StandardInput = "tty";
  	StandardOutput = "null";
  	StandardError = "journal";
  	TTYReset = true;
  	TTYVHangup = true;
  	TTYVTDisallocate = true;
	};

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
  wget curl neovim xclip wl-clipboard unzip p7zip libarchive flatpak htop openssh fzf ripgrep fd eza bat auto-cpufreq

	# dev tools
	git gcc gnumake cmake gfortran python3 uv rustup typst starship

	# lsp
	clang-tools lua-language-server rust-analyzer tinymist

	# apps
  kitty zathura libreoffice fastfetch

	# Greeter
	greetd tuigreet
	
	# Hyprland essentials
	hyprpolkitagent dunst waybar wofi swww hyprsunset hypridle

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
	
	system.stateVersion = "25.11";
}



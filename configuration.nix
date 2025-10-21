{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan
      ./hardware-configuration.nix
    ];

  # BOOTLOADER
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Omega";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # NETWORK PROXY (IF NECESSARY)
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # ENABLE NETWORKING
  networking.networkmanager.enable = true;

  # TIME ZONE
  time.timeZone = "Asia/Kuala_Lumpur";

  # INTERNATIONALISATION PROPERTIES
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
  services.printing.enable = true;

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

  # TOUCHPAD SUPPORT (ENABLED BY DEFAULT IN MOST DESKTOPMANAGER).
  # services.xserver.libinput.enable = true;

  # USER ACCOUNT
  users.users.shen = {
    isNormalUser = true;
    description = "shen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # NIX CONFIGURED PACKAGES
  programs.firefox.enable = true;
  programs.steam.enable = true;

  # ALLOW UNFREE PACKAGES
  nixpkgs.config.allowUnfree = true;

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; 
[
# Core Utils
wget
curl
git
neovim
htop
xclip
unzip
openssh

# Dev Tools
gcc
gnumake
python3
nodejs_22
go
rustup
texlive.combined.scheme-full

# Apps
kitty
tmux
spotify
zathura
gnome-tweaks
];
  

  # SUID WRAPPERS (CAN BE CONFIGURED FURTHER OR
  # STARTED IN USER SESSIONS
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # SYSTEM SERVICES
  # Flatpak
  services.flatpak.enable = true;
  # Run in bash = flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

  # Openssh Daemon
  # services.openssh.enable = true;

  # Firewall Ports
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;


  system.stateVersion = "25.05";
}

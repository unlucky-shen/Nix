{ config, pkgs, ... }: 
{

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

}

{ config, lib, pkgs, ... }:
{
#### NVIDIA CODE BLOCK #####################################################################
  
  # Enable OpenGL
	hardware.graphics = {
    enable = true;
  };
  
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

############################################################################################
}

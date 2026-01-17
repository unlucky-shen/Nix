{ config, lib, pkgs, ... }:
{
  services.xserver.videoDrivers = [
		"modesetting" # use "amdgpu" if iGPU is AMD
	  "nvidia"
	];
  
	# Nvidia Settings
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; # Enable if graphical issues occurs
    powerManagement.finegrained = true; # Turns off GPU when idle (GTX1650 ++)
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
		# Nvidia PRIME (Offload)
		prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0"; # amdgpuBusId = "PCI:54:0:0"; (AMD GPU example)
    };
  };
}

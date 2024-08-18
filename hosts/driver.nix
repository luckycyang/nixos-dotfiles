{
  config,
  pkgs-unstable,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.hosts.driver;
in
  with lib; {
    options.modules.hosts.driver = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = "disable/enable gpu for r7000";
      };
    };
    config = mkIf cfg.enable {
      boot.initrd.kernelModules = ["amdgpu"];
      services.xserver.videoDrivers = ["amdgpu" "nvidia" ];
      hardware.bluetooth.enable = true; # enables support for Bluetooth
      hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
      hardware.opengl = {
        enable = true;
        driSupport = true;
      };

      # 这里和 opengl 会冲突, opengl 就不要添加 32bit 和 extraPackages 了
      hardware.amdgpu = {
      	opencl.enable = true;
        initrd.enable = true;  
	amdvlk.enable = true;
	amdvlk.support32Bit.enable = true;
	amdvlk.supportExperimental.enable = true;
      };

      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          nvidiaBusId = "PCI:1:0:0";
          amdgpuBusId = "PCI:6:0:0";
        };
      };
    };
  }

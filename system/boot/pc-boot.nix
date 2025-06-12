{
  config,
  lib,
  ...
}:
{

  imports = [ ./../../pc/hardware-configuration.nix ];

  options = {
    pc-boot.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "sets the boot config for the pc";
    };
  };

  config = lib.mkIf config.pc-boot.enable {

    boot = {
      initrd.kernelModules = ["amdgpu"];  #davinci-resolve  Might not be able to use amdgpu-pro bc the kernel is not up to date enough


      loader = {
        systemd-boot.enable = false;    #Change when using / not using grub
        
        efi.canTouchEfiVariables = true;

        grub = {
          enable = true;
          devices = [ "nodev"];
          efiSupport = true;
          useOSProber = true;   #To detect other operating systems
          splashImage = ./../../other/images/matrix-options.png;
        };
      };



      #initrd.kernelModules = [ "amdgpu" ];  #For amd stuff

      plymouth = {
        enable = false;
        theme = "spinfinity";
      };
    };
  };
}

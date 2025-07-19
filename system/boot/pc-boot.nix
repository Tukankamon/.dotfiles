{
  config,
  lib,
  pkgs,
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
    environment.systemPackages = with pkgs; [
        vulkan-tools
        vulkan-loader
        mesa
    ];  #Had issues with wayland gamescope

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
          timeout = 1;
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

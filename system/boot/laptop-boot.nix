{
  config,
  lib,
  ...
}:
{

  imports = [ ./../../laptop/hardware-configuration.nix ];

  options = {
    laptop-boot.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "sets the boot config for the laptop";
    };
  };

  config = lib.mkIf config.laptop-boot.enable {

    boot = {
      loader = {
        systemd-boot.enable = false;    #Change when using / not using grub
        
        efi.canTouchEfiVariables = true;

        grub = {
          enable = true;
          devices = [ "nodev"];
          efiSupport = true;
          useOSProber = true;   #To detect other operating systems
        };
      };

      plymouth = {
        enable = true;
        theme = "spinfinity";
      };
    };
  };
}

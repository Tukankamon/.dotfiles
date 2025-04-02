{
  config,
  lib,
  ...
}:
{

  imports = [ ./../../../pc/hardware-configuration.nix ];

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
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      plymouth = {
        enable = true;
        theme = "spinfinity";
      };
    };
  };
}

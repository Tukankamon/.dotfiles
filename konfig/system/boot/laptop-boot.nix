{ inputs, config, pkgs, lib, ... }:

{

imports = [ ./../../../laptop/hardware-configuration.nix ];

options ={
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